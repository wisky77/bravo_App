# Flutter Docker image for building and running the app
FROM ghcr.io/cirruslabs/flutter:stable

# Set working directory
WORKDIR /app

# Copy project files
COPY pubspec.yaml ./
COPY lib ./lib/

# Install dependencies
RUN flutter pub get

# Enable web support
RUN flutter config --enable-web

# Build for web
RUN flutter build web --release

# Use nginx to serve the web app
FROM nginx:alpine

# Copy built web files to nginx
COPY --from=0 /app/build/web /usr/share/nginx/html

# Expose port 80
EXPOSE 80

# Start nginx
CMD ["nginx", "-g", "daemon off;"]
