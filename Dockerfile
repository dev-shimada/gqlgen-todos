FROM --platform=$BUILDPLATFORM golang:1.23.1-bookworm as vscode

ARG TARGETPLATFORM
ARG BUILDPLATFORM
ARG TARGETOS
ARG TARGETARCH

EXPOSE 8080

WORKDIR //server/gqlgen-todos
COPY . //server/gqlgen-todos

RUN go install -v golang.org/x/tools/gopls@latest && \
    go install -v github.com/go-delve/delve/cmd/dlv@latest && \
    go install honnef.co/go/tools/cmd/staticcheck@latest && \
    go install github.com/fullstorydev/grpcurl/cmd/grpcurl@latest

# RUN  ln -sf /usr/share/zoneinfo/Asia/Tokyo /etc/localtime

FROM --platform=$BUILDPLATFORM golang:1.23.1-bookworm as build

ARG TARGETPLATFORM
ARG BUILDPLATFORM
ARG TARGETOS
ARG TARGETARCH

EXPOSE 8080

WORKDIR //server/gqlgen-todos
COPY . //server/gqlgen-todos

RUN CGO_ENABLED=1 GOOS=${TARGETOS} GOARCH=${TARGETARCH} go build -o app cmd/main.go


FROM --platform=$BUILDPLATFORM gcr.io/distroless/base-debian12:latest
COPY --chown=${USERNAME}:${GROUPNAME} --from=build /service/app /main

USER ${USERNAME}
ENTRYPOINT [ "/main" ]
