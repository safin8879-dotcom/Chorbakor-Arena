-- Initial PostgreSQL schema proposal for CHORBAKOR ARENA.
-- Review and adapt before production. Apply through migrations, not manually on a live DB.

create extension if not exists pgcrypto;

create type booking_status as enum ('held','confirmed','cancelled','completed','expired');
create type payment_status as enum ('initiated','pending','partial','paid','failed','refunded');
create type payment_method as enum ('bkash','nagad','card','cash','other');

create table if not exists customers (
  id uuid primary key default gen_random_uuid(),
  full_name text not null,
  phone text not null,
  email text,
  auth_user_id uuid unique,
  created_at timestamptz not null default now()
);

create table if not exists slot_templates (
  id uuid primary key default gen_random_uuid(),
  start_time time not null,
  end_time time not null,
  duration_minutes integer not null default 120 check (duration_minutes = 120),
  active boolean not null default true,
  sort_order integer not null,
  check (end_time > start_time),
  unique (start_time, end_time)
);

create table if not exists bookings (
  id uuid primary key default gen_random_uuid(),
  booking_code text not null unique,
  customer_id uuid not null references customers(id),
  booking_date date not null,
  slot_template_id uuid not null references slot_templates(id),
  status booking_status not null default 'held',
  total_amount numeric(10,2) not null check (total_amount >= 0),
  amount_paid numeric(10,2) not null default 0 check (amount_paid >= 0),
  hold_expires_at timestamptz,
  notes text,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  check (amount_paid <= total_amount)
);

-- A slot may have only one active hold/confirmed booking for a date.
-- Expired holds must be transitioned to 'expired' by a trusted server job.
create unique index if not exists one_active_booking_per_slot_date
  on bookings (booking_date, slot_template_id)
  where status in ('held','confirmed');

create table if not exists payments (
  id uuid primary key default gen_random_uuid(),
  booking_id uuid not null references bookings(id),
  method payment_method not null,
  status payment_status not null default 'initiated',
  amount numeric(10,2) not null check (amount > 0),
  provider_transaction_id text unique,
  provider_reference text,
  verified_at timestamptz,
  created_at timestamptz not null default now()
);

create table if not exists admin_audit_logs (
  id uuid primary key default gen_random_uuid(),
  admin_user_id uuid not null,
  action text not null,
  target_type text,
  target_id uuid,
  metadata jsonb not null default '{}'::jsonb,
  created_at timestamptz not null default now()
);

insert into slot_templates (start_time, end_time, duration_minutes, sort_order)
values
 ('08:00','10:00',120,1),
 ('10:00','12:00',120,2),
 ('12:00','14:00',120,3),
 ('14:00','16:00',120,4),
 ('16:00','18:00',120,5),
 ('18:00','20:00',120,6),
 ('20:00','22:00',120,7),
 ('22:00','00:00',120,8)
on conflict (start_time, end_time) do nothing;

-- Production requirements:
-- 1. Use a transaction/locking strategy when creating a hold.
-- 2. Verify payment with the gateway on the server and validate webhook signatures.
-- 3. Never mark a booking confirmed based only on a browser redirect.
-- 4. Add row-level security policies before exposing tables through a client API.
-- 5. Restrict admin operations to verified admin roles.
