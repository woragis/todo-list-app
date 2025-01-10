# Step 1: Use an official Go image as the base
FROM golang:1.23.4

# Step 2: Set the working directory
WORKDIR /app

# Step 3: Copy go.mod and go.sum files
COPY go.mod go.sum ./

# Step 4: Download dependencies
RUN go mod download

# Step 5: Copy the source code into the container
COPY . .

CMD [ "go", "run", "main.go" ]
# # Step 6: Build the application
# RUN go build -o main

# # Step 7: Use a minimal image for production
# FROM alpine:latest

# # Step 8: Install certificates (if needed for HTTPS requests)
# RUN apk --no-cache add ca-certificates

# # Step 9: Set working directory and copy the binary
# WORKDIR /app

# # Step 10: Expose the application port
# EXPOSE 8080

# # Step 11: Run the application
# CMD ["./main"]
