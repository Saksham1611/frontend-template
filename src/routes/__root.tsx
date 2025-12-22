import { createRootRoute, Link, Outlet } from '@tanstack/react-router'
import { TanStackRouterDevtools } from '@tanstack/router-devtools'
import { ReactQueryDevtools } from '@tanstack/react-query-devtools'

export const Route = createRootRoute({
  component: () => (
    <div className="flex min-h-screen flex-col">
      <header className="sticky top-0 z-50 border-b bg-background/95 backdrop-blur supports-[backdrop-filter]:bg-background/60">
        <div className="container flex h-14 items-center gap-4">
          <nav className="flex items-center gap-6 text-sm font-medium">
            <Link
              to={'/' as any}
              className="transition-colors hover:text-foreground/80 [&.active]:font-bold [&.active]:text-foreground"
            >
              Home
            </Link>
            <Link
              to={'/therapy' as any}
              className="transition-colors hover:text-foreground/80 [&.active]:font-bold [&.active]:text-foreground"
            >
              Therapy Session
            </Link>
          </nav>
        </div>
      </header>
      <main className="container flex-1 py-6">
        <Outlet />
      </main>
      <footer className="mt-auto border-t bg-muted/20 py-6">
        <div className="container flex flex-col items-center justify-between gap-4 md:h-24 md:flex-row">
          <p className="text-center text-sm leading-loose text-muted-foreground md:text-left">
            Built with React, TanStack, and Tailwind.
          </p>
        </div>
      </footer>
      <TanStackRouterDevtools />
      <ReactQueryDevtools position="bottom" />
    </div>
  ),
})
