package com.datn.food_delivery.mapper;

import com.datn.food_delivery.dto.ProductDTO;
import com.datn.food_delivery.models.Product;

public class ProductMapper {

    public static Product toProduct(ProductDTO productDTO) {
        return new Product(
                productDTO.getProductId(),
                productDTO.getName(),
                productDTO.getDescription(),
                productDTO.getPrice()
        );
    }
}
