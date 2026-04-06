create table menu_items (
  id uuid primary key default gen_random_uuid(),
  name text not null,
  description text,
  price numeric(10,2) not null,
  category text not null, -- 'shave_ice', 'topping', 'drink'
  color text, -- hex color for display
  available boolean default true,
  sort_order integer default 0
);

create table orders (
  id uuid primary key default gen_random_uuid(),
  order_number serial,
  customer_name text not null,
  customer_phone text,
  customer_email text,
  items jsonb not null,
  subtotal numeric(10,2),
  total numeric(10,2),
  status text default 'pending',
  pickup_notes text,
  stripe_payment_intent_id text,
  stripe_payment_status text,
  created_at timestamptz default now()
);

create table daily_inventory (
  id uuid primary key default gen_random_uuid(),
  menu_item_id uuid references menu_items(id),
  date date default current_date,
  quantity_available integer default 50,
  quantity_sold integer default 0,
  unique(menu_item_id, date)
);

-- Seed flavors
insert into menu_items (name, description, price, category, color, sort_order) values
  ('Strawberry', 'Classic', 6.00, 'shave_ice', '#F472B6', 1),
  ('Mango', 'Tropical', 6.00, 'shave_ice', '#FB923C', 2),
  ('Blue Coconut', 'Dreamy', 6.00, 'shave_ice', '#38BDF8', 3),
  ('Lilikoi', 'Passion fruit', 6.00, 'shave_ice', '#FBBF24', 4),
  ('Matcha', 'Earthy', 6.00, 'shave_ice', '#34D399', 5),
  ('Watermelon', 'Refreshing', 6.00, 'shave_ice', '#F87171', 6),
  ('Tiger''s Blood', 'Strawberry coconut — legendary', 6.00, 'shave_ice', '#EF4444', 7),
  ('Rainbow', 'Go big', 7.00, 'shave_ice', '#A78BFA', 8),
  ('Lemon', 'Tart', 6.00, 'shave_ice', '#FDE047', 9),
  ('Grape', 'Sweet', 6.00, 'shave_ice', '#A78BFA', 10),
  ('Cream', 'Add cream', 1.00, 'topping', '#FFFFFF', 1),
  ('Mochi', 'Chewy rice balls', 1.50, 'topping', '#FEF3C7', 2),
  ('Azuki Beans', 'Sweet red bean', 1.50, 'topping', '#92400E', 3),
  ('Condensed Milk', 'Sweet drizzle', 0.75, 'topping', '#FEF3C7', 4),
  ('Fresh Fruit', 'Seasonal', 2.00, 'topping', '#34D399', 5);
