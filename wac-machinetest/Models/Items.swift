//
//  Items.swift
//  wac-machinetest
//
//  Created by bibeesh on 31.08.2023.
//

import Foundation

struct HomeDataResponse: Codable {
    let status: Bool
    let homeData: [HomeDataType]

    enum CodingKeys:String,CodingKey{
        case status
        case homeData
    }
}

enum HomeDataType: Codable {
    case category(values: [CategoryValue])
    case banners(values: [BannerValue])
    case products(values: [ProductValue])

    private enum CodingKeys: String, CodingKey {
        case type
        case values
    }

    private enum HomeType: String, Codable {
        case category
        case banners
        case products
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let type = try container.decode(HomeType.self, forKey: .type)

        switch type {
        case .category:
            let values = try container.decode([CategoryValue].self, forKey: .values)
            self = .category(values: values)
        case .banners:
            let values = try container.decode([BannerValue].self, forKey: .values)
            self = .banners(values: values)
        case .products:
            let values = try container.decode([ProductValue].self, forKey: .values)
            self = .products(values: values)
        }
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        switch self {
        case .category(let values):
            try container.encode(HomeType.category, forKey: .type)
            try container.encode(values, forKey: .values)
        case .banners(let values):
            try container.encode(HomeType.banners, forKey: .type)
            try container.encode(values, forKey: .values)
        case .products(let values):
            try container.encode(HomeType.products, forKey: .type)
            try container.encode(values, forKey: .values)
        }
    }
}

struct CategoryValue: Codable {
    let id: Int
    let name: String
    let imageUrl: String
    
    enum CodingKeys:String,CodingKey{
        case id
        case name
        case imageUrl = "image_url"
    }


}

struct BannerValue: Codable {
    let id: Int
    let bannerUrl: String?
    
    enum CodingKeys:String,CodingKey{
        case id
        case bannerUrl = "banner_url"
    }
}

struct ProductValue: Codable {
    let id: Int
    let name: String
    let image: String
    let actualPrice: String
    let offerPrice: String
    let offer: Int
    let isExpress: Bool
    
    
    enum CodingKeys:String,CodingKey{
        case id
        case name
        case image
        case actualPrice = "actual_price"
        case offerPrice = "offer_price"
        case offer
        case isExpress = "is_express"
    }
}

