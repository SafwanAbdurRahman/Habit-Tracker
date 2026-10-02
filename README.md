# 🚀 Production-Grade Habit Tracker & Personal Dashboard

A secure, multi-tenant habit tracking and personal productivity web application built with a modern full-stack cloud architecture. Designed for real-world utility, featuring automated analytics, consistency streaks, task management, and rigorous database-level security.

## 🔗 Live Production App
* **URL:** [Habit Tracker Live App](https://habit-tracker-lovat-delta.vercel.app)

---

## 🛠️ Tech Stack & Infrastructure

* **Frontend & UI:** Next.js (React Framework), Tailwind CSS, Recharts
* **Deployment & Hosting:** Vercel (Edge network routing & automatic deployments)
* **Backend & Database:** Supabase (PostgreSQL, Auth Engine, Row Level Security)

---

## ✨ Core Features

* **Secure Authentication:** User sign-up and sign-in managed via Supabase Auth with automated session control and unauthenticated route guards.
* **Multi-Tenant Data Isolation:** Enforced via PostgreSQL **Row Level Security (RLS)** using `auth.uid() = user_id`, guaranteeing absolute data privacy per user at the database engine level.
* **Comprehensive Analytics:** Tracks daily habits, recurring check-ins, custom weekly targets, weekly consistency bar charts, and monthly completion percentage donuts.
* **Productivity Suite:** Integrated one-off to-do task list and sleep-duration logging with historical tracking charts.

---

## 🔒 Production Security & Architecture

* **Database-Level RLS:** All primary relational tables (`habits`, `completions`, `tasks`, `sleep_logs`) require strict row-owner validation.
* **Least-Privilege Access Control:** Public table permissions for the unauthenticated `anon` role are explicitly revoked, ensuring all data operations require verified user tokens.

---

## 📦 Getting Started Locally

1. **Clone the repository:**
   ```bash
   git clone [https://github.com/SafwanAbdurRahman/Habit-Tracker.git](https://github.com/SafwanAbdurRahman/Habit-Tracker.git)
   cd Habit-Tracker
