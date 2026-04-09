# Flutter web build + nginx. Intended for DigitalOcean App Platform (BUILD_TIME arg PRIMERPESO_API_BASE_URL).
FROM ghcr.io/cirruslabs/flutter:stable AS build
WORKDIR /app

COPY pubspec.yaml pubspec.lock ./
COPY packages ./packages
RUN flutter pub get

COPY . .

ARG PRIMERPESO_API_BASE_URL
RUN test -n "$PRIMERPESO_API_BASE_URL" && \
    flutter build web --release \
      --dart-define=PRIMERPESO_API_BASE_URL="$PRIMERPESO_API_BASE_URL"

FROM nginx:1.27-alpine
COPY --from=build /app/build/web /usr/share/nginx/html
COPY nginx.default.conf /etc/nginx/conf.d/default.conf
EXPOSE 80
