# Base Go image for go application
FROM golang:1.22.5 as base 

# working directory in container
WORKDIR /app

# Copy the files to present directory
COPY go.mod .

# Run the 
RUN go mod download

COPY . .

# EXPOSE 8080

# CMD [ "go", "run", "main.go" ]

RUN go build -o main .

# Stage 2 - final stage 
FROM gcr.io/distroless/base

COPY --from=base /app/main .

COPY --from=base /app/static /static

EXPOSE 8080

CMD [ "./main" ]
