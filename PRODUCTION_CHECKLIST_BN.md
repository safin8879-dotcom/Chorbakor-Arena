# লাইভ করার আগে যা সম্পন্ন করতে হবে

এই ZIP-এ থাকা HTML হলো ব্যবহারযোগ্য Frontend Demo। এটি এখনো লাইভ বুকিং বা বাস্তব পেমেন্ট নেয় না। বাস্তব গ্রাহকের টাকা নেওয়ার আগে নিচের কাজগুলো অবশ্যই করতে হবে।

## Backend ও Database
- Secure server/API এবং production PostgreSQL/Supabase project তৈরি
- Customer login: Mobile OTP এবং Email authentication
- Guest booking-এর জন্য mobile verification ও privacy notice
- প্রতিটি তারিখের slot availability server থেকে হিসাব
- Database transaction/locking দিয়ে double booking প্রতিরোধ
- Hold expiry worker/cron job
- Admin role ও permission control; public admin signup বন্ধ
- Database backup, audit log এবং monitoring

## Payment
- SSLCommerz বা aamarPay merchant onboarding সম্পন্ন
- Gateway-এর official server-side API ও signed webhook integration
- Success, fail, cancel, refund flow পরীক্ষা
- Browser redirect-কে payment proof হিসেবে গ্রহণ না করা
- Advance এবং full payment ledger সঠিকভাবে হিসাব
- Gateway credential শুধু server environment-এ রাখা

## Customer communication
- SMS/Email provider নির্বাচন ও অনুমোদন
- Booking confirmation, cancellation এবং reminder message
- QR ticket-এ public sensitive customer data না রাখা

## Launch
- Domain `chorbakorarena.com` কিনে DNS ও HTTPS configure
- Privacy Policy, Terms, Cancellation/Refund Policy প্রকাশ
- Mobile, desktop, accessibility এবং security testing
- Test payment/sandbox দিয়ে end-to-end পরীক্ষা
- Owner-এর অনুমোদনের পর production payment চালু

## ব্যবসার মালিকের কাছ থেকে প্রয়োজন
- সঠিক ঠিকানা, ফোন, WhatsApp ও Google Maps link
- চূড়ান্ত slot price, advance amount ও cancellation/refund policy
- Payment gateway merchant account
- SMS sender/provider account
- Logo এবং বাস্তব turf photos
