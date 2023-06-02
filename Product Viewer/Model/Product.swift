//
//  Product.swift
//  Product Viewer
//
//  Created by Adham Samer on 30/05/2023.
//

import Foundation

// MARK: - Product

struct Product: Codable {
    let product: ProductClass?
    let productMerchants: [ProductMerchant]?
}

// MARK: - ProductClass

struct ProductClass: Codable {
    let id: String?
    let name: String?
    let description: String?
    let price: String?
    let imageUrl: String?
}

// MARK: - ProductMerchant

struct ProductMerchant: Codable {
    let merchant: Merchant?
    let merchantProduct: MerchantProduct?
    let productMerchant: SingleProductMerchant?
}

// MARK: - Merchant

struct Merchant: Codable {
    let id: String?
    let name: String?
}

// MARK: - MerchantProduct

struct MerchantProduct: Codable {
    let id: String?
    let price: String?
    let upc: String?
    let sku: String?
    let buyUrl: String?
    let discountPercent: String?
}

// MARK: - SingleProductMerchant

struct SingleProductMerchant {
    let id: String?
    let productId: String?
    let upc: String?
    let sku: String?
    let created: String?
    let modified: String?
    let multipleProductsPerPage: String?
}
