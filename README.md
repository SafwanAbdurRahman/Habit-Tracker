# Habit Tracker (private web app starter)

A responsive personal habit dashboard with email authentication, recurring habit check-ins, weekly/monthly completion analytics, a separate task list, and a sleep-duration log. It uses Next.js, Supabase, and Recharts.

## Included
- Private email sign-in / account creation through Supabase Auth
- Starter habits and custom habits with weekly targets
- Month calendar; unscheduled rest days are disabled and excluded from scheduled-day analytics
- Weekly consistency bars, monthly completion percentage and donut chart
- Separate one-off to-do list
- Sleep-duration logging and monthly chart
- Supabase Row Level Security policies to isolate each user's data

## Setup
1. Create a project at https://supabase.com/ and open **SQL Editor**.
2. Paste and run `supabase/schema.sql`.
3. In Supabase **Authentication → Providers → Email**, choose whether email confirmation is required. For a private deployment, use a strong password and keep account registration limited according to your needs.
4. Copy `.env.example` to `.env.local` and set your Supabase project URL and publishable/anon key. These two `NEXT_PUBLIC_` values are intended for browser use; **never** use the `service_role` key here.
5. Install Node.js (LTS), then run:
   ```bash
   npm install
   npm run dev
   ```
6. Open http://localhost:3000.

## Deploy privately
- Push this folder to a private GitHub repository.
- Import it into Vercel (or another Next.js host), set the same two environment variables in project settings, and deploy.
- Configure the Supabase Auth **Site URL** and allowed **Redirect URLs** to your deployed domain.
- In Supabase, keep RLS enabled. Review auth signup settings if you want only one account. Never commit `.env.local` or share passwords/keys in chat.

This is a starter implementation, not a security audit or a deployed service. Test account signup, sign-in, CRUD operations, and access isolation before using it for personal records. The UI currently seeds suggested habits and supports adding/deleting habits; editing a habit's weekdays/target after creation can be added as a follow-up enhancement.
