# Step 1: Use an official Go image as the base
FROM golang:1.23.4 AS builder

# Step 2: Set the working directory
WORKDIR /app

# Step 3: Copy go.mod and go.sum files
COPY go.mod go.sum ./

# Step 4: Download dependencies
RUN go mod download

# Step 5: Copy the source code into the container
COPY . .

# Step 6: Build the application
RUN go build -o /app/main ./main.go

# CMD [ "go", "run", "main.go" ]

# Step 7: Use a minimal image for production
FROM ubuntu:22.04

# Step 8: Install certificates (if needed for HTTPS requests)
RUN apt-get update && apt-get install -y \
    ca-certificates \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Step 9: Set working directory and copy the binary
WORKDIR /app
COPY --from=builder /app/main .

# Step 10: Expose the application port
EXPOSE 8080

# # Step 11: Run the application
CMD ["./main"]
