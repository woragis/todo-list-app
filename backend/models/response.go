package models

type Response struct {
    Status  int         `json:"status"`  // HTTP status code
    Message string      `json:"message"` // Response message
    Error   interface{} `json:"error"`   // Response error
    Data    interface{} `json:"data"`    // Placeholder for any data
}
