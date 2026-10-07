# HOCO Complete Fresh Store

This is the fresh HOCO electronics e-commerce foundation.

## What is included

Customer storefront, customer authentication, account page, product pages, admin dashboard, product CRUD, price/stock/category/description controls, product image/video URL fields, floating product video popup, Supabase schema with RLS, and a structure ready for cart/checkout/orders/payment integration.

## Important security rule

The administrator password is NOT included anywhere in this project. Do not put it in source code, GitHub, `.env`, client JavaScript, or README files. Create the admin account through Supabase Authentication and give that account the `admin` role in `profiles`.

## Setup

1. Create a Supabase project.
2. Run `supabase/schema.sql` in Supabase SQL Editor.
3. Create the admin user in Supabase Authentication with the intended admin email/password.
4. Insert that user's UUID into `profiles` with role `admin` using the SQL comment in the schema.
5. Copy `.env.example` to `.env.local`.
6. Add your Supabase URL and anon key.
7. Run `npm install`, then `npm run dev`.

## Next production modules

- Real image/video upload to Supabase Storage (instead of URL fields)
- Cart persistence
- Checkout/address flow
- COD/UPI/online payment gateway
- Customer order history
- Admin order management
- Coupons/discounts
- Reviews/ratings
- Search/filter/sort
- Analytics
- Email/order notifications
- Final security testing and Vercel deployment
