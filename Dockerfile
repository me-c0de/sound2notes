ARG GO_VERSION=1.18

# Build Stage
FROM golang:${GO_VERSION}-alpine AS builder

# add git for alpine version https://github.com/docker-library/golang/issues/250#issuecomment-451201761
RUN apk add --no-cache git

WORKDIR /app
COPY . .
RUN go build -o main main.go

# RUN Stage
FROM alpine
WORKDIR /app
COPY --from=builder /app/main .


EXPOSE 8080
CMD ["/app/main"]
