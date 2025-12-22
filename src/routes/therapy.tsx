import { createFileRoute } from '@tanstack/react-router'
import { Button } from '@/components/ui/button'

export const Route = createFileRoute('/therapy' as any)({
  component: TherapySession,
})

function TherapySession() {
  return (
    <div className="mx-auto max-w-4xl space-y-6">
      <div className="flex flex-col gap-2">
        <h1 className="text-3xl font-bold tracking-tight">Therapy Session</h1>
        <p className="text-lg text-muted-foreground">
          Real-time interactive therapy dashboard.
        </p>
      </div>

      <div className="relative flex aspect-video items-center justify-center overflow-hidden rounded-xl border bg-slate-100 p-8 dark:bg-slate-900">
        <div className="flex flex-col items-center gap-4 text-center">
          <div className="flex h-16 w-16 animate-pulse items-center justify-center rounded-full bg-primary/10">
            <div className="flex h-8 w-8 items-center justify-center rounded-full bg-primary/20">
              <div className="h-4 w-4 rounded-full bg-primary" />
            </div>
          </div>
          <p className="font-medium text-muted-foreground">
            Waveform Canvas goes here...
          </p>
        </div>
      </div>

      <div className="flex gap-4">
        <Button size="lg" onClick={() => alert('Recording Started')}>
          Start Recording
        </Button>
        <Button variant="outline" size="lg">
          Settings
        </Button>
      </div>
    </div>
  )
}
