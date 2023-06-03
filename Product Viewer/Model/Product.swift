//
//  Product.swift
//  Product Viewer
//
//  Created by Adham Samer on 30/05/2023.
//

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
    var image_url: String?
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
    var product_id: String?
    var upc: String?
    var sku: String?
}
