COPY go.mod .
COPY go.sum .
RUN go mod download

COPY . .

RUN CG0_ENABLED=0 GOOS=linux GOARCH=amd64 go build -a -tags netgo -ldflags '-w -extldflags "-static"' -o ./main ./httpserver/cmd/httpserver

# 2

FROM scratch

WORKDIR /app

COPY --from=build /app/main /app/main
COPY --from=build /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/
COPY --from=build /usr/share/zoneinfo /usr/share/zoneinfo
ENV TZ=Europe/Moscow

EXPOSE 8080


CMD ["./main"]