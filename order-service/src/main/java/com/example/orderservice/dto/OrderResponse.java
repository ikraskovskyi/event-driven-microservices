package com.example.orderservice.dto;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.UUID;

public record OrderResponse(
        UUID orderId,
        Long customerId,
        Long productId,
        Integer quantity,
        BigDecimal amount,
        String status,
        LocalDateTime createdAt) {
}
