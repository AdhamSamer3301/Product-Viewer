//
//  Product.swift
//  Product Viewer
//
//  Created by Adham Samer on 30/05/2023.
//

import Foundation

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let product = try? JSONDecoder().decode(Product.self, from: jsonData)

import Foundation

// MARK: - Product
struct Product: Codable {
    var Product: ProductClass?
    var ProductMerchants: [ProductMerchantElement]?
}

// MARK: - ProductClass
struct ProductClass: Codable {
    var id: String?
    var name: String?
    var description: String?
    var price: String?
    var imageUrl: String?
}

// MARK: - ProductMerchantElement
struct ProductMerchantElement: Codable {
    var Merchant: Merchant?
    var MerchantProduct: MerchantProduct?
    var ProductMerchant: ProductMerchantProductMerchant?
}

// MARK: - Merchant
struct Merchant: Codable {
    var id: String?
    var name: String?
}

// MARK: - MerchantProduct
struct MerchantProduct: Codable {
    var id: String?
    var price: String?
    var upc: String?
    var sku: String?
}

// MARK: - ProductMerchantProductMerchant
struct ProductMerchantProductMerchant: Codable {
    var id: String?
    var productId: String?
    var upc: String?
    var sku: String?
}
