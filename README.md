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

## Adapting for a New Project

To use this template for a new project, follow these steps:

1. **Copy the Template:** Use this folder as your project's boilerplate.
2. **Update Project Metadata:**
   - In `package.json`, update `name`, `version`, and `description`.
   - In `index.html`, update the `<title>` tag to your project's name.
3. **Follow the [AGENTS.md](file:///c:/Users/DELL/repos/templates/frontend-template/AGENTS.md):** This file contains the coding "Gospel" for the project.

## AI Collaboration

This project is optimized for AI-assisted development. To work effectively with an AI agent:
1. Ensure the agent has read [AGENTS.md](file:///c:/Users/DELL/repos/templates/frontend-template/AGENTS.md).
2. Ask the agent to follow the standards defined there for any new routes, components, or logic.

## Coding Principles
- Use the URL as the primary source of truth for UI state.
- Strictly use TanStack Query for all data fetching (no `useEffect` for data).
- Wrap API calls in custom hooks.
- Prefer functional components and `const` definitions.
- Mobile-first responsive design with Tailwind.
