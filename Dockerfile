# 1. Base Stage: Install dependencies only when needed
FROM node:20-alpine AS base

# 2. Dependencies Stage
FROM base AS deps
RUN apk add --no-cache libc6-compat
WORKDIR /app
COPY package.json pnpm-lock.yaml* ./ 
RUN npm install -g pnpm && pnpm i --frozen-lockfile

# 3. Builder Stage: Compile the application
FROM base AS builder
WORKDIR /app
COPY --from=deps /app/node_modules ./node_modules
COPY . .
RUN npm run build

# 4. Runner Stage: The final, tiny production image
FROM base AS runner
WORKDIR /app

ENV NODE_ENV=production
# Add a non-root user for security
RUN addgroup --system --gid 1001 nodejs && adduser --system --uid 1001 nextjs

# Copy only the compiled "standalone" folder and static assets
COPY --from=builder /app/public ./public
COPY --from=builder --chown=nextjs:nodejs /app/.next/standalone ./
COPY --from=builder --chown=nextjs:nodejs /app/.next/static ./.next/static

USER nextjs
EXPOSE 3000
ENV PORT=3000

# We run the node server directly, no "serve" package needed
CMD ["node", "server.js"]