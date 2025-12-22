# AGENTS.md

This file defines the structural and coding standards for the frontend project. AI agents and developers must strictly follow these rules to maintain consistency, type safety, and scalability.

## Tech Stack (The Hard Slabs)
* **Framework:** Vite + React 19 + TypeScript
* **Routing:** TanStack Router (File-based)
* **Data Fetching:** TanStack Query (v5)
* **UI Components:** shadcn/ui (Radix + Tailwind)
* **State Management:**
    * *Server State:* TanStack Query (Strictly)
    * *Client State:* Zustand (Global UI state)
    * *URL State:* TanStack Router Search Params (For shareable UI state)

## Project Structure
```text
src/
├── components/
│   ├── ui/             # shadcn primitives (Button, Card, etc.)
│   └── domain/         # App-specific/Feature components (PatientCard, TherapyHeader)
├── routes/             # TanStack Router file-based routes (index.tsx, __root.tsx)
├── hooks/              # Custom React hooks (useAuth, usePatient)
├── lib/
│   ├── api.ts          # API/Fetch configuration (Axios instances)
│   └── utils.ts        # Tailwind merger and helpers
├── services/           # PURE TypeScript business logic (Calculations, AudioEngine)
├── stores/             # Zustand stores (useUIStore)
└── types/              # Global TypeScript interfaces/types
```

## How to Add New Features

1.  **New Page/Route**:
    - Add a `.tsx` file in `src/routes/`.
    - If it's a child route, ensure it's nested correctly (e.g., `src/routes/therapy.$id.tsx`).
    - Use `createFileRoute` for type safety.
2.  **New UI Component**:
    - Use `npx shadcn-ui@latest add [component]` for primitives.
    - Put custom domain components in `src/components/domain/`.
3.  **New Data Fetching Logic**:
    - Create a custom hook in `src/hooks/`.
    - Use `useQuery` or `useMutation` from TanStack Query.
    - Never fetch data inside an `useEffect`.
4.  **New Global State**:
    - Create a store in `src/stores/` using Zustand.

## Coding Guidelines (The "Gospel")

### A. Routing & URL State
* **Source of Truth:** If it can be in the URL (tabs, filters, search), it *must* be in the URL.
* **Type Safety:** Use the typed `Link` or `useNavigate`. Never use hardcoded strings for paths.

### B. Data Fetching
* **Custom Hooks Only:** Wrap all API calls in custom hooks. components should only consume hooks, never raw fetch calls.
* **Query Key Factory:** Use a consistent pattern for query keys.

### C. Logic Separation
* **Keep Components Thin:** React components are for rendering and event handling. Move heavy logic (e.g., audio processing, complex data transformations) to `src/services/` or `src/lib/`.
* **Functional Components:** Always use functional components with `const` definition.

### D. TypeScript Strictness
* **No `any`**: Fix type errors at the source.
* **Interface vs Type**: Use `interface` for object structures that might be extended, and `type` for unions/aliases.


1.  **Context Injection**: "Reference `AGENTS.md` for coding standards."
2.  **Specific Components**: "Use existing shadcn components from `src/components/ui/` first."
3.  **Hooks First**: "If this involves an API call, scaffold a TanStack Query hook first."
