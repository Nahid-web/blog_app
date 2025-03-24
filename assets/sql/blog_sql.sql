-- Create a table for public blogs
create table blogs (
  id uuid not null primary key,
  updated_at timestamp with time zone,
  poster_id uuid not null,
  title text not null,
  content text not null,
  image_url text,
  topics text array,
  foreign key (poster_id) references public.profiles(id)
 

  
);
-- Set up Row Level Security (RLS)
-- See https://supabase.com/docs/guides/database/postgres/row-level-security for more details.
alter table blogs
  enable row level security;

create policy "Public blogs are viewable by everyone." on blogs
  for select using (true);

create policy "Users can insert their own profile." on blogs
  for insert with check ((select auth.uid()) = id);

create policy "Users can update own profile." on blogs
  for update using ((select auth.uid()) = id);


-- Set up Storage!
insert into storage.buckets (id, name)
  values ('blog_images', 'blog_images');

-- Set up access controls for storage.
-- See https://supabase.com/docs/guides/storage/security/access-control#policy-examples for more details.
create policy "Blog images are publicly accessible." on storage.objects
  for select using (bucket_id = 'blog_images');

create policy "Anyone can upload an blog." on storage.objects
  for insert with check (bucket_id = 'blog_images');

create policy "Anyone can update their own blog." on storage.objects
  for update using ((select auth.uid()) = owner) with check (bucket_id = 'blog_images');