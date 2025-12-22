# Frontend Development Template

This is a comprehensive frontend template based on modern web development standards.

## Tech Stack
- **Framework:** Vite + React 19 + TypeScript
- **Routing:** TanStack Router (File-based)
- **Data Fetching:** TanStack Query (v5)
- **Styling:** Tailwind CSS + shadcn/ui
- **State Management:** Zustand (Client State), TanStack Query (Server State)

## Directory Structure
- `src/components/ui/`: shadcn/ui primitives.
- `src/components/domain/`: Application-specific components.
- `src/routes/`: Route definitions (TanStack Router).
- `src/hooks/`: Custom React hooks.
- `src/lib/`: Shared utilities and API configuration.
- `src/services/`: Pure TypeScript business logic.
- `src/stores/`: Zustand state stores.

## Getting Started

1. **Install Dependencies:**
   ```bash
   npm install
   ```

2. **Install Pre-commit Hooks:**
   If you have `pre-commit` installed on your system, run:
   ```bash
   pre-commit install
   ```

3. **Run Development Server:**
   ```bash
   npm run dev
   ```

3. **Build for Production:**
   ```bash
   npm run build
   ```

## Coding Principles
- Use the URL as the primary source of truth for UI state.
- Strictly use TanStack Query for all data fetching (no `useEffect` for data).
- Wrap API calls in custom hooks.
- Prefer functional components and `const` definitions.
- Mobile-first responsive design with Tailwind.
