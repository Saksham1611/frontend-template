# Frontend Template

A Next.js (App Router) frontend template designed to integrate with FastAPI backends using the BFF (Backend-for-Frontend) pattern.

## Quick Start

```bash
# 1. Create new project
npx create-next-app@latest your-project --typescript --tailwind --eslint
cd your-project

# 2. Initialize Shadcn UI
npx shadcn-ui@latest init

# 3. Install core dependencies
pnpm add framer-motion lucide-react clsx tailwind-merge zod zustand

# 4. Add common components
npx shadcn-ui@latest add button card input dialog skeleton

# 5. Start development
pnpm dev
```

## Project Structure

```text
src/
├── app/                  # Next.js App Router
│   ├── (auth)/           # Auth route group
│   ├── (dashboard)/      # Main app route group
│   ├── api/              # BFF Route Handlers
│   └── globals.css
├── components/
│   ├── ui/               # Shadcn components
│   └── motion/           # Framer Motion wrappers
├── hooks/                # Custom hooks
├── lib/                  # Utilities
├── store/                # Zustand stores
└── types/                # TypeScript interfaces
```

## Key Patterns

### BFF Proxy

All FastAPI calls go through Next.js Route Handlers:

```typescript
// app/api/data/route.ts
export async function GET() {
  const res = await fetch(`${process.env.FASTAPI_URL}/data`);
  return Response.json(await res.json());
}
```

### Optimistic Updates

Use `useOptimistic` for instant UI feedback:

```typescript
const [optimisticValue, addOptimistic] = useOptimistic(value);
```

### AI Streaming

Stream responses through Route Handlers:

```typescript
// Pipe FastAPI StreamingResponse to the browser
return new Response(response.body, {
  headers: { 'Content-Type': 'text/event-stream' },
});
```

### Premium Motion

Spring physics for smooth animations:

```typescript
<motion.div transition={{ type: "spring", stiffness: 300, damping: 30 }} />
```

## Type Sync

Generate TypeScript types from FastAPI:

```bash
npx openapi-typescript http://localhost:8000/openapi.json --output ./src/types/api.ts
```

## Guidelines

| Document | Description |
|----------|-------------|
| [AGENTS.md](./AGENTS.md) | Coding standards and project structure |
| [Guidelines/architecture.md](./Guidelines/architecture.md) | Core architecture and BFF pattern |
| [Guidelines/premium-ux.md](./Guidelines/premium-ux.md) | Motion, streaming, and UX patterns |
| [Guidelines/setup.md](./Guidelines/setup.md) | Development workflow and commands |

## Tech Stack

- **Framework**: Next.js 14+ (App Router)
- **Styling**: Tailwind CSS
- **Components**: shadcn/ui
- **Motion**: Framer Motion
- **State**: Zustand
- **Backend**: FastAPI (separate repo)
