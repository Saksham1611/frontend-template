# Premium UX Guidelines

A "Premium" feel is achieved by removing **Cumulative Layout Shift (CLS)** and **Latency Visuals**. This guide covers the patterns that make interfaces feel smooth and responsive.

## The "Smoothness" Checklist

### A. Interaction Physics (Motion)

**Springs > Easing**: Never use `linear` or `ease-in`. Use Spring physics for a tactile feel:

```typescript
// Use this for a "premium" pop-up feel
<motion.div 
  transition={{ 
    type: "spring", 
    stiffness: 300, 
    damping: 30 
  }} 
/>
```

**Layout Continuity**: When a small card expands into a dashboard view, use `layoutId`:

```typescript
// List view
<motion.div layoutId={`card-${id}`}>
  <CompactCard data={item} />
</motion.div>

// Detail view
<motion.div layoutId={`card-${id}`}>
  <ExpandedCard data={item} />
</motion.div>
```

> **Rule**: If the user's eye moves, the element should move with them.

---

### B. AI-Native Streaming

**Streaming UI**: Use React `Suspense` with FastAPI `StreamingResponse`.

**Immediate Feedback**: The moment a user submits an AI prompt, show a "Thinking..." skeleton instantly. As tokens arrive, stream them directly into the UI using the **Web Streams API**:

```typescript
// hooks/use-ai-stream.ts
export function useAIStream() {
  const [content, setContent] = useState('');
  const [isStreaming, setIsStreaming] = useState(false);

  const streamResponse = async (prompt: string) => {
    setIsStreaming(true);
    setContent('');

    const response = await fetch('/api/chat', {
      method: 'POST',
      body: JSON.stringify({ prompt }),
    });

    const reader = response.body?.getReader();
    const decoder = new TextDecoder();

    while (reader) {
      const { done, value } = await reader.read();
      if (done) break;
      
      const chunk = decoder.decode(value, { stream: true });
      setContent(prev => prev + chunk);
    }

    setIsStreaming(false);
  };

  return { content, isStreaming, streamResponse };
}
```

---

### C. Optimistic Updates (Server Actions)

For actions like "Save" or "Delete," update the local state **before** the API call finishes:

```typescript
// components/LikeButton.tsx
'use client'
import { useOptimistic } from 'react';
import { toggleLikeAction } from '@/lib/actions';

export function LikeButton({ id, initialLikes }: { id: string, initialLikes: number }) {
  const [optimisticLikes, addOptimistic] = useOptimistic(
    initialLikes,
    (state, amount: number) => state + amount
  );

  return (
    <button onClick={async () => {
      addOptimistic(1); // UI updates to +1 instantly
      await toggleLikeAction(id); // Server Action calls FastAPI in background
    }}>
      ❤️ {optimisticLikes}
    </button>
  );
}
```

---

### D. Data-Heavy Performance

**Virtualization**: If a dashboard table has >100 rows, you **must** use `TanStack Virtual`. It keeps the DOM light and prevents laggy scrolling:

```typescript
import { useVirtualizer } from '@tanstack/react-virtual';

function VirtualTable({ rows }: { rows: DataRow[] }) {
  const parentRef = useRef<HTMLDivElement>(null);

  const virtualizer = useVirtualizer({
    count: rows.length,
    getScrollElement: () => parentRef.current,
    estimateSize: () => 48, // row height
  });

  return (
    <div ref={parentRef} className="h-[600px] overflow-auto">
      <div style={{ height: virtualizer.getTotalSize() }}>
        {virtualizer.getVirtualItems().map(virtualRow => (
          <div
            key={virtualRow.key}
            style={{
              position: 'absolute',
              top: virtualRow.start,
              height: virtualRow.size,
            }}
          >
            <TableRow data={rows[virtualRow.index]} />
          </div>
        ))}
      </div>
    </div>
  );
}
```

---

## Motion & Visual Guidelines

A "Good" app snaps; a "Premium" app flows.

### Shared Element Transitions

Use `layoutId` when moving from a List view to a Detail view:

```typescript
// Wrap both the source and destination with the same layoutId
<AnimatePresence>
  {isExpanded ? (
    <motion.div layoutId="card" className="fixed inset-4 bg-white rounded-xl">
      <DetailView />
    </motion.div>
  ) : (
    <motion.div layoutId="card" className="w-64 h-32 bg-white rounded-lg">
      <CardPreview />
    </motion.div>
  )}
</AnimatePresence>
```

### Spring Physics

Set `type: "spring"` with recommended values for a natural, elastic feel:

| Use Case | Stiffness | Damping | Notes |
|----------|-----------|---------|-------|
| **Pop-ups/Modals** | 300 | 30 | Snappy but controlled |
| **Expansions** | 260 | 20 | Natural elastic feel |
| **Subtle hover** | 400 | 40 | Quick response |
| **Drawer slides** | 200 | 25 | Smooth glide |

### Loading States

Use `loading.tsx` to provide **Skeleton Screens** that match the content shape:

```typescript
// app/(dashboard)/loading.tsx
export default function DashboardLoading() {
  return (
    <div className="p-6 space-y-4">
      <Skeleton className="h-8 w-48" /> {/* Title */}
      <div className="grid grid-cols-3 gap-4">
        <Skeleton className="h-32" /> {/* Card 1 */}
        <Skeleton className="h-32" /> {/* Card 2 */}
        <Skeleton className="h-32" /> {/* Card 3 */}
      </div>
    </div>
  );
}
```

> **Rule**: Generic spinners are strictly prohibited. Skeletons must match the final UI shape.

### Page Transitions

Wrap page changes in Framer Motion `AnimatePresence` for cross-fades between dashboard views:

```typescript
// components/motion/page-transition.tsx
'use client';
import { AnimatePresence, motion } from 'framer-motion';
import { usePathname } from 'next/navigation';

export function PageTransition({ children }: { children: React.ReactNode }) {
  const pathname = usePathname();

  return (
    <AnimatePresence mode="wait">
      <motion.div
        key={pathname}
        initial={{ opacity: 0, y: 8 }}
        animate={{ opacity: 1, y: 0 }}
        exit={{ opacity: 0, y: -8 }}
        transition={{ type: 'spring', stiffness: 300, damping: 30 }}
      >
        {children}
      </motion.div>
    </AnimatePresence>
  );
}
```

### Button Loading States with useFormStatus

Every button click must trigger an Optimistic Update or a Loading State via `useFormStatus`:

```typescript
// components/ui/submit-button.tsx
'use client';
import { useFormStatus } from 'react-dom';
import { Button } from '@/components/ui/button';

export function SubmitButton({ children }: { children: React.ReactNode }) {
  const { pending } = useFormStatus();

  return (
    <Button type="submit" disabled={pending}>
      {pending ? 'Saving...' : children}
    </Button>
  );
}
```

---

## Summary Checklist

Quick reference for premium UX requirements:

| Requirement | Implementation |
|-------------|----------------|
| **Streaming** | Use `StreamingResponse` in FastAPI → `ReadableStream` in Next.js |
| **Feedback** | Every button click must trigger an Optimistic Update or Loading State via `useFormStatus` |
| **Visuals** | Use Skeleton Screens (via `loading.tsx`) instead of spinners |
| **Transitions** | Wrap page changes in Framer Motion `AnimatePresence` for cross-fades |
| **Physics** | Use spring transitions (`stiffness: 260-300`, `damping: 20-30`), never `linear` or `ease-in` |
| **Layout** | Use `layoutId` for shared element transitions between views |

