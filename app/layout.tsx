import type { Metadata } from 'next';
import './globals.css';
export const metadata: Metadata = { title: 'Habit Tracker', description: 'A private space to track habits, tasks, and sleep.' };
export default function RootLayout({ children }: Readonly<{ children: React.ReactNode }>) { return <html lang="en"><body>{children}</body></html>; }
