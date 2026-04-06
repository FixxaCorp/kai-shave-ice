-- Kai Shave Ice — Full POS Schema
-- Run against Supabase project: npieagluyxpnlmjqiypn

drop table if exists orders cascade;
drop table if exists menu_items cascade;
drop table if exists categories cascade;

create table categories (
  id uuid primary key default gen_random_uuid(),
  name text not null,
  emoji text,
  sort_order integer default 0
);

create table menu_items (
  id uuid primary key default gen_random_uuid(),
  category_id uuid references categories(id),
  name text not null,
  description text,
  price numeric(10,2) not null,
  color text,
  available boolean default true,
  image_url text,
  sort_order integer default 0,
  created_at timestamptz default now()
);

create table orders (
  id uuid primary key default gen_random_uuid(),
  order_number serial,
  source text default 'online',        -- 'online', 'kiosk-1', 'kiosk-2', 'kiosk-3'
  customer_name text,
  customer_phone text,
  items jsonb not null,
  subtotal numeric(10,2),
  total numeric(10,2),
  status text default 'pending',       -- pending, paid, preparing, ready, completed
  stripe_payment_intent_id text,
  payment_status text default 'unpaid',
  notes text,
  created_at timestamptz default now()
);

-- Enable realtime on orders table
alter publication supabase_realtime add table orders;

-- ── Seed categories ──
insert into categories (name, emoji, sort_order) values
  ('Shave Ice', '🧊', 1),
  ('Poke Bowls', '🍣', 2),
  ('Toppings', '✨', 3),
  ('Drinks', '🥤', 4);

-- ── Seed Shave Ice flavors ──
insert into menu_items (category_id, name, description, price, color, sort_order)
select id, 'Strawberry', 'Classic', 6.00, '#F472B6', 1 from categories where name='Shave Ice';
insert into menu_items (category_id, name, description, price, color, sort_order)
select id, 'Mango', 'Tropical', 6.00, '#FB923C', 2 from categories where name='Shave Ice';
insert into menu_items (category_id, name, description, price, color, sort_order)
select id, 'Blue Coconut', 'Dreamy', 6.00, '#38BDF8', 3 from categories where name='Shave Ice';
insert into menu_items (category_id, name, description, price, color, sort_order)
select id, 'Lilikoi', 'Passion fruit', 6.00, '#FBBF24', 4 from categories where name='Shave Ice';
insert into menu_items (category_id, name, description, price, color, sort_order)
select id, 'Matcha', 'Earthy', 6.00, '#34D399', 5 from categories where name='Shave Ice';
insert into menu_items (category_id, name, description, price, color, sort_order)
select id, 'Tiger''s Blood', 'Strawberry coconut', 6.00, '#EF4444', 6 from categories where name='Shave Ice';
insert into menu_items (category_id, name, description, price, color, sort_order)
select id, 'Rainbow', 'Go big', 7.00, '#A78BFA', 7 from categories where name='Shave Ice';
insert into menu_items (category_id, name, description, price, color, sort_order)
select id, 'Watermelon', 'Refreshing', 6.00, '#F87171', 8 from categories where name='Shave Ice';
insert into menu_items (category_id, name, description, price, color, sort_order)
select id, 'Lemon', 'Tart', 6.00, '#FDE047', 9 from categories where name='Shave Ice';
insert into menu_items (category_id, name, description, price, color, sort_order)
select id, 'Grape', 'Sweet', 6.00, '#A78BFA', 10 from categories where name='Shave Ice';

-- ── Seed Poke Bowls ──
insert into menu_items (category_id, name, description, price, color, sort_order)
select id, 'Ahi Tuna Bowl', 'Fresh ahi, rice, house sauce', 16.00, '#FB923C', 1 from categories where name='Poke Bowls';
insert into menu_items (category_id, name, description, price, color, sort_order)
select id, 'Salmon Bowl', 'Atlantic salmon, avocado, sesame', 16.00, '#F87171', 2 from categories where name='Poke Bowls';
insert into menu_items (category_id, name, description, price, color, sort_order)
select id, 'Spicy Tuna Bowl', 'Ahi, spicy mayo, cucumber', 17.00, '#EF4444', 3 from categories where name='Poke Bowls';
insert into menu_items (category_id, name, description, price, color, sort_order)
select id, 'Veggie Bowl', 'Tofu, edamame, mango, avocado', 14.00, '#34D399', 4 from categories where name='Poke Bowls';

-- ── Seed Toppings ──
insert into menu_items (category_id, name, price, color, sort_order)
select id, 'Cream', 1.00, '#FFFFFF', 1 from categories where name='Toppings';
insert into menu_items (category_id, name, price, color, sort_order)
select id, 'Mochi', 1.50, '#FEF3C7', 2 from categories where name='Toppings';
insert into menu_items (category_id, name, price, color, sort_order)
select id, 'Azuki Beans', 1.50, '#92400E', 3 from categories where name='Toppings';
insert into menu_items (category_id, name, price, color, sort_order)
select id, 'Condensed Milk', 0.75, '#FEF3C7', 4 from categories where name='Toppings';
insert into menu_items (category_id, name, price, color, sort_order)
select id, 'Fresh Fruit', 2.00, '#34D399', 5 from categories where name='Toppings';
