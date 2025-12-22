import { createFileRoute } from '@tanstack/react-router'

export const Route = createFileRoute('/' as any)({
  component: Home,
})

function Home() {
  return (
    <div className="space-y-6">
      <div className="flex flex-col gap-2">
        <h1 className="text-3xl font-bold tracking-tight">
          Welcome to the App
        </h1>
        <p className="text-lg text-muted-foreground">
          This is a modern frontend template using Vite, React, TanStack, and
          shadcn/ui.
        </p>
      </div>
      <div className="grid gap-4 md:grid-cols-2 lg:grid-cols-4">
        {/* Placeholder cards */}
        <div className="rounded-xl border bg-card text-card-foreground shadow">
          <div className="p-6">
            <h3 className="font-semibold leading-none tracking-tight">Fast</h3>
            <p className="mt-2 text-sm text-muted-foreground">
              Powered by Vite for instant HMR.
            </p>
          </div>
        </div>
        <div className="rounded-xl border bg-card text-card-foreground shadow">
          <div className="p-6">
            <h3 className="font-semibold leading-none tracking-tight">
              Type-Safe
            </h3>
            <p className="mt-2 text-sm text-muted-foreground">
              End-to-end type safety with TypeScript and TanStack Router.
            </p>
          </div>
        </div>
      </div>
    </div>
  )
}
