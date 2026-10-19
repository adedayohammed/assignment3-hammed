FROM alpine:3.18
RUN apk add --no-cache bash
WORKDIR /app
COPY app/app.sh /app/app.sh
RUN chmod +x /app/app.sh
ENTRYPOINT ["/app/app.sh"]
CMD ["help"]
