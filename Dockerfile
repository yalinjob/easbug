# Stage 1: Builder Stage
FROM node:12-alpine as builder

# Define working directory for builder stage
WORKDIR /usr/src/app

# Copy package.json and package-lock.json (or other relevant files)
COPY package*.json ./

# Install dependencies
RUN npm install --production

# Stage 2: Final Image
FROM node:12-alpine

# Define user and working directory for the final image
ENV USER node
ENV WORKDIR /home/$USER/app
WORKDIR $WORKDIR

# Copy node_modules from the builder stage
COPY --from=builder /usr/src/app/node_modules ./node_modules

# Set permissions for the working directory
RUN chown $USER:$USER $WORKDIR

# Copy the rest of the application files to the working directory
COPY --chown=node . $WORKDIR

# Expose port 22
EXPOSE 22





