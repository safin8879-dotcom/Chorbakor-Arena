# CHORBAKOR ARENA — Website Starter Package

This package contains the current responsive, bilingual (English/Bangla) frontend prototype and starter documentation for the CHORBAKOR ARENA turf-booking website.

## Included
- `frontend/index.html` — standalone frontend demo. No build tools are required.
- `database/schema.sql` — initial PostgreSQL schema for customers, slots, bookings and payments.
- `.env.example` — placeholders for future server-side integration. Do not put real secrets in frontend code.
- `docs/PRODUCTION_CHECKLIST_BN.md` — what must be completed before accepting real bookings or payments.
- `docs/BOOKING_RULES.md` — proposed operating rules.

## Run the demo
1. Extract the ZIP.
2. Open `frontend/index.html` in a modern browser.
3. For a local web server, run from the project folder:
   `python3 -m http.server 8000`
4. Open `http://localhost:8000/frontend/`.

## Important limitation
This is a frontend prototype and project starter, **not a live production booking/payment system**. The current demo uses sample slot states and client-side demo interactions. It does not create durable reservations, verify payments, send OTP/SMS, or protect an admin account. Do not accept customer payments based on this demo.

Before launch, implement a secure backend, database migrations and access policies, payment gateway server-side verification/webhooks, OTP/email authentication, atomic slot holds and booking confirmation, admin authorization, logging, backups, and end-to-end tests. Payment gateway merchant credentials and SMS provider credentials must be obtained by the business owner and stored only as server environment variables.
