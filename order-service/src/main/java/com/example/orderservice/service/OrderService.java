package com.example.orderservice.service;

import com.example.orderservice.dto.CreateOrderRequest;
import com.example.orderservice.dto.CreateOrderResponse;
import com.example.orderservice.dto.OrderResponse;

import java.util.UUID;

public interface OrderService {

    CreateOrderResponse createOrder(CreateOrderRequest request);

    OrderResponse getOrder(UUID orderId);

    void completeOrder(UUID orderId);

    void cancelOrder(UUID orderId);
}