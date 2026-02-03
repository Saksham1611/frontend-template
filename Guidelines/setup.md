# Setup Guide

This guide walks through the development workflow for creating a new frontend project.

## 1. Initialize Project

Use `create-next-app` with App Router:

```bash
npx create-next-app@latest your-project-name --typescript --tailwind --eslint
# Choose "App Router: Yes" for premium features

cd your-project-name
```

## 2. Initialize Shadcn UI

```bash
npx shadcn-ui@latest init
# Questions:
# - Style: Default
# - Base Color: Slate or Zinc (for dark-mode friendly palette)
# - CSS variables: Yes
```

## 3. Install Core Dependencies

```bash
# Motion & Interactions
pnpm add framer-motion

# Icons
pnpm add lucide-react

# Utilities
pnpm add clsx tailwind-merge

# Validation
pnpm add zod

# Global State
pnpm add zustand

# Optional: Virtualization for large lists
pnpm add @tanstack/react-virtual
```

## 4. Sync API Types (Optional)

If your FastAPI backend exposes an OpenAPI schema, generate TypeScript types:

```bash
# Replace with your actual FastAPI URL
npx openapi-typescript http://localhost:8000/openapi.json --output ./src/types/api.ts
```

Add this to your `package.json` scripts for easy regeneration:

```json
{
  "scripts": {
    "sync-types": "openapi-typescript http://localhost:8000/openapi.json --output ./src/types/api.ts"
  }
}
```

---

## Development Workflow

### Component First

1. **Build UI primitives** in `components/ui` using Shadcn
2. **Add common components** you'll need:

```bash
npx shadcn-ui@latest add button card input dialog skeleton
```

### Route Groups

Organize routes using Next.js route groups:

```text
app/
├── (auth)/           # Auth flows - /login, /register
│   ├── login/
│   └── register/
├── (dashboard)/      # Main app - /dashboard, /settings
│   ├── dashboard/
│   └── settings/
└── layout.tsx        # Root layout
```

### Add Motion Last

Polish the UI with Framer Motion after core functionality is complete:

1. Create motion wrappers in `components/motion/`
2. Focus on exit/entry transitions
3. Add `layoutId` for shared element animations

---

## Environment Variables

Create `.env.local` for development:

```bash
# FastAPI Backend URL (used by Route Handlers)
FASTAPI_URL=http://localhost:8000

# Public variables (exposed to browser)
NEXT_PUBLIC_APP_NAME=Your App Name
```

---

## Folder Structure After Setup

```text
your-project-name/
├── src/
│   ├── app/
│   │   ├── (auth)/
│   │   ├── (dashboard)/
│   │   ├── api/
│   │   ├── layout.tsx
│   │   ├── page.tsx
│   │   └── globals.css
│   ├── components/
│   │   ├── ui/           # Shadcn components
│   │   └── motion/       # Framer Motion wrappers
│   ├── hooks/
│   ├── lib/
│   │   ├── utils.ts      # cn() helper
│   │   └── api-client.ts
│   ├── store/
│   └── types/
├── .env.local
├── tailwind.config.ts
└── package.json
```

---

## Quick Commands Reference

| Command | Purpose |
|---------|---------|
| `pnpm dev` | Start development server |
| `pnpm build` | Build for production |
| `pnpm lint` | Run ESLint |
| `pnpm sync-types` | Regenerate API types from FastAPI |
| `npx shadcn-ui@latest add [component]` | Add new Shadcn component |
