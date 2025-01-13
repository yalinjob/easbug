# Stage 1: Builder Stage
FROM node:12-alpine as builder

WORKDIR /usr/src/app

# Copy package.json and package-lock.json
COPY package*.json ./

# Install dependencies
RUN npm install --production

# Debug: Verify node_modules exists
RUN ls -al /usr/src/app

# Stage 2: Final Image
FROM node:12-alpine

WORKDIR /home/node/app

# Copy node_modules from the builder stage
COPY --from=builder /usr/src/app/node_modules ./node_modules

# Debug: Verify node_modules was copied
RUN ls -al ./node_modules

# Copy the rest of the application
COPY . .

# Set permissions for the working directory
RUN chown -R node:node /home/node/app

EXPOSE 22
