-- Run once in Supabase: SQL Editor -> New query -> paste -> Run
create table if not exists public.properties(
 id uuid primary key default gen_random_uuid(),
 slug text unique not null,
 kind text not null default 'villa' check (kind in ('villa','apt','house')),
 type text not null default 'Luxury Villa',
 name text not null, location text not null, full_address text,
 price text, beds int, baths int, area text, parking text,
 status text default 'Available',
 short_desc text, details jsonb default '{}', amenities text[] default '{}',
 images text[] default '{}', video_url text, model_url text,
 lat double precision, lng double precision, palette text[],
 published boolean default true,
 created_at timestamptz default now(), updated_at timestamptz default now());
create table if not exists public.settings(
 id int primary key default 1 check (id=1),
 phone text, display_phone text, broker_name text, broker_title text, bio text,
 years int, homes_sold int, areas text, specialisation text);
insert into public.settings(id) values (1) on conflict do nothing;
alter table public.properties enable row level security;
alter table public.settings enable row level security;
create policy "public reads published" on public.properties for select to anon using (published);
create policy "admin manages properties" on public.properties for all to authenticated using (true) with check (true);
create policy "public reads settings" on public.settings for select to anon, authenticated using (true);
create policy "admin updates settings" on public.settings for all to authenticated using (true) with check (true);
insert into storage.buckets(id,name,public) values ('property-media','property-media',true) on conflict do nothing;
create policy "public reads media" on storage.objects for select using (bucket_id='property-media');
create policy "admin uploads media" on storage.objects for insert to authenticated with check (bucket_id='property-media');
create policy "admin edits media" on storage.objects for update to authenticated using (bucket_id='property-media');
create policy "admin deletes media" on storage.objects for delete to authenticated using (bucket_id='property-media');
