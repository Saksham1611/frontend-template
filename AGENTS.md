# AGENTS.md

This file defines the structural and coding standards for the frontend project. AI agents and developers must strictly follow these rules to maintain consistency, type safety, and scalability.

## Tech Stack

| Category | Technology | Notes |
|----------|-----------|-------|
| **Framework** | Next.js 14+ (App Router) | Server Components by default |
| **Language** | TypeScript | Strict mode enabled |
| **Styling** | Tailwind CSS | Utility-first, mobile-first |
| **Components** | shadcn/ui (Radix + Tailwind) | We own the code |
| **Motion** | Framer Motion | Spring physics, `layoutId` |
| **Icons** | Lucide React | Consistent icon set |
| **State** | Zustand | Client-side global state only |
| **Backend** | FastAPI (separate repo) | Connected via BFF pattern |

---

## Project Structure

```text
src/
├── app/                      # Next.js App Router
│   ├── (auth)/               # Route Group: Auth flows
│   │   ├── login/
│   │   └── register/
│   ├── (dashboard)/          # Route Group: Main App
│   │   ├── _components/      # Private to this group
│   │   ├── layout.tsx        # Persistent sidebar/header
│   │   └── page.tsx
│   ├── api/                  # BFF Route Handlers (proxy to FastAPI)
│   ├── layout.tsx            # Root layout
│   ├── page.tsx              # Landing page
│   └── globals.css
├── components/
│   ├── ui/                   # Shadcn atomic components
│   └── motion/               # Framer Motion wrappers
├── hooks/                    # Custom React hooks
├── lib/
│   ├── utils.ts              # cn() and helpers
│   └── api-client.ts         # Fetch wrappers
├── store/                    # Zustand stores
└── types/                    # TypeScript interfaces (sync from FastAPI)
```

---

## How to Add New Features

### 1. New Page/Route

- Add a `page.tsx` file in the appropriate route group
- Use Server Components for data fetching when possible
- Add `loading.tsx` for skeleton states

```typescript
// app/(dashboard)/analytics/page.tsx
export default async function AnalyticsPage() {
  const data = await fetch(`${process.env.FASTAPI_URL}/analytics`);
  return <AnalyticsDashboard data={data} />;
}
```

### 2. New UI Component

- Use `npx shadcn-ui@latest add [component]` for primitives
- Put custom domain components in route group `_components/` if page-specific
- Put shared components in `components/` root

### 3. New API Endpoint (BFF Proxy)

- Create a Route Handler in `app/api/`
- Never expose FastAPI URL to the client

```typescript
// app/api/users/route.ts
export async function GET() {
  const res = await fetch(`${process.env.FASTAPI_URL}/users`);
  return Response.json(await res.json());
}
```

### 4. New Global State

- Create a store in `store/` using Zustand
- Keep stores focused and small

```typescript
// store/ui-store.ts
import { create } from 'zustand';

interface UIState {
  sidebarOpen: boolean;
  toggleSidebar: () => void;
}

export const useUIStore = create<UIState>((set) => ({
  sidebarOpen: true,
  toggleSidebar: () => set((s) => ({ sidebarOpen: !s.sidebarOpen })),
}));
```

### 5. New Motion Component

- Create wrappers in `components/motion/`
- Use spring physics, never `linear` or `ease-in`

```typescript
// components/motion/fade-in.tsx
'use client';
import { motion } from 'framer-motion';

export function FadeIn({ children }: { children: React.ReactNode }) {
  return (
    <motion.div
      initial={{ opacity: 0, y: 10 }}
      animate={{ opacity: 1, y: 0 }}
      transition={{ type: 'spring', stiffness: 300, damping: 30 }}
    >
      {children}
    </motion.div>
  );
}
```

---

## Coding Guidelines

### A. React 19 Rules

- **No `useEffect` for Fetching**: Use Server Components for initial data and the `use()` hook for streaming
- **The Compiler is your Friend**: You no longer need `useMemo` or `useCallback`. The React Compiler (enabled in Next.js 15+) handles optimization automatically
- **Actions for Mutations**: All data changes (POST/PUT/DELETE) should go through Server Actions (`'use server'`) rather than manual fetch/Axios calls. This automatically handles revalidation and pending states

### B. Server vs Client Components

- **Default to Server Components** for data fetching and static UI
- Use `'use client'` only when needed (interactivity, hooks, browser APIs)
- Keep client boundaries as low as possible in the component tree

### C. Data Fetching

- **Server Components**: Fetch directly in the component using `fetch()`
- **Client Components**: Use Server Actions or the `use()` hook for streaming
- **Never use `useEffect` for data fetching**

### D. BFF Pattern (Backend-for-Frontend)

- All external API calls go through `app/api/` Route Handlers
- FastAPI URL is **never** exposed to the browser
- Streaming responses are piped through Route Handlers

### E. Motion & Transitions

- Use **Skeleton Screens** instead of spinners (provide `loading.tsx`)
- Use `layoutId` for shared element transitions
- Spring physics only: `type: "spring", stiffness: 260-300, damping: 20-30`

### F. TypeScript Strictness

- **No `any`**: Fix type errors at the source
- **Interface vs Type**: Use `interface` for objects, `type` for unions/aliases
- Sync types from FastAPI using `openapi-typescript`

### G. Styling

- Mobile-first Tailwind classes (`w-full md:w-1/2`)
- Use `cn()` utility for conditional classes
- Modify Shadcn components directly—we own the code

---

## Agent Instructions

When generating code for this project:

1. **Reference this file** for coding standards
2. **Check existing components** in `components/ui/` before creating new ones
3. **Use Server Components** by default, add `'use client'` only when necessary
4. **Create Route Handlers** for any external API calls
5. **Add `loading.tsx`** for any new pages with data fetching
6. **Use spring transitions** for any motion/animation work
