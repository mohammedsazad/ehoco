create extension if not exists "pgcrypto";

create table if not exists public.profiles (
  id uuid primary key references auth.users(id) on delete cascade,
  full_name text,
  role text not null default 'customer' check (role in ('customer','admin')),
  created_at timestamptz not null default now()
);

create table if not exists public.products (
  id uuid primary key default gen_random_uuid(),
  name text not null,
  description text default '',
  category text not null,
  price numeric(12,2) not null default 0,
  compare_at_price numeric(12,2),
  stock integer not null default 0,
  image_url text default '',
  video_url text default '',
  active boolean not null default true,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table if not exists public.orders (
  id uuid primary key default gen_random_uuid(),
  user_id uuid references auth.users(id) on delete set null,
  status text not null default 'pending',
  total numeric(12,2) not null default 0,
  payment_method text,
  shipping_address jsonb,
  created_at timestamptz not null default now()
);

create table if not exists public.order_items (
  id uuid primary key default gen_random_uuid(),
  order_id uuid not null references public.orders(id) on delete cascade,
  product_id uuid references public.products(id) on delete set null,
  product_name text not null,
  quantity integer not null,
  price numeric(12,2) not null
);

alter table public.profiles enable row level security;
alter table public.products enable row level security;
alter table public.orders enable row level security;
alter table public.order_items enable row level security;

drop policy if exists "Public can read active products" on public.products;
create policy "Public can read active products" on public.products for select using (active=true or auth.uid() in (select id from public.profiles where role='admin'));

drop policy if exists "Admins manage products" on public.products;
create policy "Admins manage products" on public.products for all using (auth.uid() in (select id from public.profiles where role='admin')) with check (auth.uid() in (select id from public.profiles where role='admin'));

drop policy if exists "Users read own orders" on public.orders;
create policy "Users read own orders" on public.orders for select using (user_id=auth.uid() or auth.uid() in (select id from public.profiles where role='admin'));

drop policy if exists "Users create own orders" on public.orders;
create policy "Users create own orders" on public.orders for insert with check (user_id=auth.uid());

drop policy if exists "Admins manage orders" on public.orders;
create policy "Admins manage orders" on public.orders for update using (auth.uid() in (select id from public.profiles where role='admin'));

drop policy if exists "Users read own order items" on public.order_items;
create policy "Users read own order items" on public.order_items for select using (order_id in (select id from public.orders where user_id=auth.uid()) or auth.uid() in (select id from public.profiles where role='admin'));

-- After creating the admin user in Supabase Authentication, run:
-- insert into public.profiles (id, full_name, role)
-- select id, 'HOCO Admin', 'admin' from auth.users where email='YOUR_ADMIN_EMAIL';
-- IMPORTANT: put the admin password only in Supabase Authentication, never in this repository.

insert into storage.buckets (id,name,public) values ('product-media','product-media',true) on conflict (id) do nothing;
