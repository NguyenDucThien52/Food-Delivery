package com.datn.food_delivery.repositories;

import com.datn.food_delivery.models.Product;
import org.springframework.data.jpa.repository.JpaRepository;

public interface ProductRepository extends JpaRepository<Product, Long> {
}
