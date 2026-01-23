# Frontend Template

A production-ready React frontend template with TypeScript, TanStack Router, and Tailwind CSS.

## Features

- **Vite + React 19**: Lightning-fast development
- **TypeScript**: Full type safety
- **TanStack Router**: File-based routing
- **TanStack Query**: Server state management
- **Tailwind CSS + shadcn/ui**: Modern styling
- **Zustand**: Client state management
- **Docker**: Production-ready with nginx
- **Pre-commit**: Automated code quality (prettier, eslint, tsc)

## Quick Start

### Option 1: Git Clone (Universal)

```bash
git clone --depth=1 https://github.com/Wellnest-Group/wng_ui_template my-project
cd my-project
./init-project.sh my-project   # Unix/macOS
# or
.\init-project.ps1 my-project  # Windows PowerShell
```

### Option 2: degit (Requires Node.js)

```bash
npx degit Wellnest-Group/wng_ui_template my-project
cd my-project
./init-project.sh my-project
```

### Option 3: GitHub Template

1. Click **"Use this template"** on GitHub
2. Clone your new repository
3. Run the init script:
   ```bash
   ./init-project.sh my-project
   ```

## What the Init Script Does

1. ✅ Checks for `node` and `pre-commit`
2. ✅ Replaces all placeholders with your project name
3. ✅ Reinitializes git (fresh history)
4. ✅ Installs pre-commit hooks (if `pre-commit` is found)
5. ✅ Runs `npm install`

## Prerequisites

- [Node.js](https://nodejs.org/) 20+
- [pre-commit](https://pre-commit.com/) - Git hooks framework

## Development

```bash
# Start dev server
npm run dev

# Type check
npm run type-check

# Lint
npm run lint

# Format
npm run format

# Build for production
npm run build
```

## Docker

```bash
# Build
docker build -t my-project .

# Run
docker run -p 3000:80 my-project
```

## Project Structure

```
├── src/
│   ├── components/
│   │   ├── ui/           # shadcn/ui primitives
│   │   └── domain/       # App-specific components
│   ├── routes/           # TanStack Router pages
│   ├── hooks/            # Custom React hooks
│   ├── lib/              # Utilities & API config
│   ├── services/         # Business logic
│   └── stores/           # Zustand stores
├── Dockerfile
├── docker-build.yml      # CI/CD workflow
└── package.json
```

## Coding Standards

- Use URL as source of truth for UI state
- Use TanStack Query for all data fetching (no `useEffect` for data)
- Wrap API calls in custom hooks
- Mobile-first responsive design
- Follow the [AGENTS.md](./AGENTS.md) for AI-assisted development

## License

MIT
