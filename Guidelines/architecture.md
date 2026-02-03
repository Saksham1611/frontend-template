# Architecture Guide

This document defines the core architecture for Next.js frontend applications that integrate with FastAPI backends.

## Core Architecture: The "Next-FastAPI" Bridge

We use **Next.js (App Router)** as our primary orchestration layer. It acts as a **BFF (Backend-for-Frontend)** to our **FastAPI** services.

```text
src/
├── app/                  # Routing & Server Orchestration
│   ├── (auth)/           # Route Group: Auth flows (no URL impact)
│   ├── (dashboard)/      # Route Group: Main App UI
│   │   ├── _components/  # Dashboard-specific UI (private to this group)
│   │   ├── layout.tsx    # Persistent Sidebar/Header (No re-renders on nav)
│   │   └── page.tsx      # Main dashboard view
│   ├── api/              # Route Handlers (BFF Proxy to FastAPI)
│   └── globals.css       # Tailwind & Global Styles
├── components/           # Universal Shared Components
│   ├── ui/               # Atomic Shadcn components (Button, Input, etc.)
│   └── motion/           # Framer Motion wrappers (Transitions, Morphs)
├── hooks/                # Custom React Hooks (use-ai-stream, use-optimistic)
├── lib/                  # Shared Utilities (cn-merge, api-client)
├── types/                # TypeScript Interfaces (Auto-generated from FastAPI)
└── store/                # Global State (Zustand)
```

## Folder Usage Examples

### Route Group Components

**`app/(dashboard)/_components`**: If you have a `DataChart.tsx` that is *only* used in the dashboard, put it here. This prevents the root `components` folder from becoming a "junk drawer."

The underscore prefix `_` makes the folder private—Next.js won't treat it as a route segment.

### BFF Proxy Layer

**`app/api/`**: Use this to hide your FastAPI URL. Instead of calling `https://fastapi.example.com/data` directly, the frontend calls `/api/data`. This approach:

- Avoids CORS issues
- Secures API keys server-side
- Enables request/response transformation
- Allows streaming passthrough

---

## Connecting to FastAPI (The BFF Pattern)

Since we are in separate repos, follow this communication flow:

### 1. Direct Fetch (Server-Side)

Inside Next.js `page.tsx` (Server Component), fetch data directly from FastAPI for the initial load. This removes the "loading spinner" entirely:

```typescript
// app/(dashboard)/page.tsx
async function DashboardPage() {
  const data = await fetch(`${process.env.FASTAPI_URL}/dashboard`, {
    cache: 'no-store' // or use revalidation
  }).then(r => r.json());

  return <Dashboard initialData={data} />;
}
```

### 2. Streaming Proxy

For AI responses, use a Next.js **Route Handler** to pipe the FastAPI stream to the browser:

```typescript
// app/api/chat/route.ts
export async function POST(request: Request) {
  const body = await request.json();
  
  const response = await fetch(`${process.env.FASTAPI_URL}/chat`, {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify(body),
  });

  // Pipe the stream directly
  return new Response(response.body, {
    headers: { 'Content-Type': 'text/event-stream' },
  });
}
```

### 3. Type Safety

Use `openapi-typescript` to sync types from FastAPI:

```bash
npx openapi-typescript http://fastapi-url/openapi.json --output ./src/types/api.ts
```

---

## Performance Standards

| Feature | Standard | Why? |
|---------|----------|------|
| **Images** | `next/image` only | Automatic WebP conversion and lazy loading |
| **Fonts** | `next/font` | Zero layout shift on load |
| **Spinners** | Avoid them | Use **Skeleton Screens** that match the final UI shape |
| **Bundle** | Dynamic Imports | Only load heavy libraries (like Recharts) when needed |

---

## Folder Responsibilities

| Folder | Purpose | Example Code/Logic |
|--------|---------|-------------------|
| **`src/app/`** | Routing & Server Logic | Server Components that fetch initial data from FastAPI |
| **`src/app/api/`** | **BFF Proxy** | Route Handlers that call FastAPI and stream chunks back to the client |
| **`src/components/ui/`** | Atomic Elements | Base Shadcn/Radix components (keep these pure and unstyled) |
| **`src/components/motion/`** | **Premium Motion** | Wrappers for Framer Motion (Transitions, Shared Elements) |
| **`src/hooks/`** | Business Logic | `useOptimistic` handlers, AI Stream consumers, and local state |
| **`src/lib/`** | Shared Utils | API clients, type-safe fetchers, and formatting helpers |
| **`src/store/`** | Global State | Zustand stores for client-side state |
| **`src/types/`** | TypeScript Interfaces | Auto-generated from FastAPI OpenAPI schema |
