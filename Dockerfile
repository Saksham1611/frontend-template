# Simple Node.js server for React app
FROM node:18-alpine
WORKDIR /app

# Copy package files
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy source code
COPY . .

# Build the application
RUN npm run build

# Install serve package for production
RUN npm install -g serve

# Expose port 5173
EXPOSE 5173

# Serve the built files
CMD ["serve", "-s", "dist", "-l", "5173"]
