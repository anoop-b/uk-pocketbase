FROM golang:1.23.4-bookworm AS build

WORKDIR /src

#pls clone pcoket base to cwd first. (https://github.com/pocketbase/pocketbase.git)
COPY ./pocketbase /src

RUN mkdir app

RUN cd examples/base && \
     CGO_ENABLED=1 \
     go build \
     -buildmode=pie \
     -ldflags "-linkmode external -extldflags '-static-pie'" \
     -o /app/pb main.go

RUN mkdir -p /app/pb_data; \
    mkdir -p /app/pb_public; \
    mkdir -p /app/pb_hooks;

RUN chmod +x /app/pb
RUN chmod +rw /app/pb_data

FROM scratch

COPY --from=build /app /app
COPY --from=build /lib/x86_64-linux-gnu/libc.so.6 /lib/x86_64-linux-gnu/
COPY --from=build /lib64/ld-linux-x86-64.so.2 /lib64/

#uncomment to test the scratch container
#ENTRYPOINT ["/app/pb", "serve", "--dev", "--http=0.0.0.0:8090"]
