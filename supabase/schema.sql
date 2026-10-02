-- Run this entire file in Supabase Dashboard > SQL Editor.
-- Row Level Security ensures each signed-in user can access only their own records.
create extension if not exists pgcrypto;
create table if not exists public.habits (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users(id) on delete cascade,
  name text not null check (char_length(name) between 1 and 80),
  target_per_week int not null default 5 check (target_per_week between 1 and 7),
  weekdays int[] not null default array[0,1,2,3,4,5,6],
  color text not null default '#9b8cff',
  created_at timestamptz not null default now(),
  constraint valid_weekdays check (weekdays <@ array[0,1,2,3,4,5,6])
);
create table if not exists public.completions (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users(id) on delete cascade,
  habit_id uuid not null references public.habits(id) on delete cascade,
  done_date date not null,
  created_at timestamptz not null default now(),
  unique (habit_id, done_date)
);
create table if not exists public.tasks (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users(id) on delete cascade,
  title text not null check (char_length(title) between 1 and 180),
  due_date date,
  done boolean not null default false,
  created_at timestamptz not null default now()
);
create table if not exists public.sleep_logs (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users(id) on delete cascade,
  sleep_date date not null,
  hours numeric(4,2) not null check (hours between 0 and 24),
  created_at timestamptz not null default now(),
  unique (user_id, sleep_date)
);
alter table public.habits enable row level security;
alter table public.completions enable row level security;
alter table public.tasks enable row level security;
alter table public.sleep_logs enable row level security;
drop policy if exists "Users manage own habits" on public.habits;
create policy "Users manage own habits" on public.habits for all to authenticated using (auth.uid() = user_id) with check (auth.uid() = user_id);
drop policy if exists "Users manage own completions" on public.completions;
create policy "Users manage own completions" on public.completions for all to authenticated using (auth.uid() = user_id) with check (auth.uid() = user_id);
drop policy if exists "Users manage own tasks" on public.tasks;
create policy "Users manage own tasks" on public.tasks for all to authenticated using (auth.uid() = user_id) with check (auth.uid() = user_id);
drop policy if exists "Users manage own sleep logs" on public.sleep_logs;
create policy "Users manage own sleep logs" on public.sleep_logs for all to authenticated using (auth.uid() = user_id) with check (auth.uid() = user_id);
-- Prevent a user from attaching another user's habit to their own completion.
create or replace function public.check_completion_owner() returns trigger language plpgsql security invoker as $$
begin
  if not exists (select 1 from public.habits h where h.id = new.habit_id and h.user_id = auth.uid() and h.user_id = new.user_id) then
    raise exception 'Habit does not belong to the signed-in user';
  end if;
  return new;
end; $$;
drop trigger if exists completion_owner_guard on public.completions;
create trigger completion_owner_guard before insert or update on public.completions for each row execute function public.check_completion_owner();
