//
//  APIResponse.swift
//  Pods
//
//  Created by Abhishek.Batra on 6/26/23.
//

import Foundation


// MARK: - Welcome
struct BrandAdResponse: Codable {
    let code: Int
    let message: String
    let data: DataClass
}

// MARK: - DataClass
struct DataClass: Codable {
    let id: String
    let ads: [Ad]
}

// MARK: - Ad
struct Ad: Codable {
    let ctaLandingURL: String
    let brandLogoAccessURL: String
    let title, ctaText: String
    let mediaDetails: [MediaDetail]
    let skus: [JSONAny]
    let adID, campaignID, adGroupID, adFormat: String

    enum CodingKeys: String, CodingKey {
        case ctaLandingURL = "cta_landing_url"
        case brandLogoAccessURL = "brand_logo_access_url"
        case title
        case ctaText = "cta_text"
        case mediaDetails = "media_details"
        case skus
        case adID = "ad_id"
        case campaignID = "campaign_id"
        case adGroupID = "ad_group_id"
        case adFormat = "ad_format"
    }
}

// MARK: - MediaDetail
struct MediaDetail: Codable {
    let id: String
    let mediaAccessURL: String
    let mediaType: String
    let lengthInSeconds: Int
    let aspectRatio: String
    let order, closedCaptionMediaAccessURL, posterAccessURL: JSONNull?

    enum CodingKeys: String, CodingKey {
        case id
        case mediaAccessURL = "media_access_url"
        case mediaType = "media_type"
        case lengthInSeconds = "length_in_seconds"
        case aspectRatio = "aspect_ratio"
        case order
        case closedCaptionMediaAccessURL = "closed_caption_media_access_url"
        case posterAccessURL = "poster_access_url"
    }
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}

class JSONCodingKey: CodingKey {
    let key: String

    required init?(intValue: Int) {
        return nil
    }

    required init?(stringValue: String) {
        key = stringValue
    }

    var intValue: Int? {
        return nil
    }

    var stringValue: String {
        return key
    }
}

class JSONAny: Codable {

    let value: Any

    static func decodingError(forCodingPath codingPath: [CodingKey]) -> DecodingError {
        let context = DecodingError.Context(codingPath: codingPath, debugDescription: "Cannot decode JSONAny")
        return DecodingError.typeMismatch(JSONAny.self, context)
    }

    static func encodingError(forValue value: Any, codingPath: [CodingKey]) -> EncodingError {
        let context = EncodingError.Context(codingPath: codingPath, debugDescription: "Cannot encode JSONAny")
        return EncodingError.invalidValue(value, context)
    }

    static func decode(from container: SingleValueDecodingContainer) throws -> Any {
        if let value = try? container.decode(Bool.self) {
            return value
        }
        if let value = try? container.decode(Int64.self) {
            return value
        }
        if let value = try? container.decode(Double.self) {
            return value
        }
        if let value = try? container.decode(String.self) {
            return value
        }
        if container.decodeNil() {
            return JSONNull()
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decode(from container: inout UnkeyedDecodingContainer) throws -> Any {
        if let value = try? container.decode(Bool.self) {
            return value
        }
        if let value = try? container.decode(Int64.self) {
            return value
        }
        if let value = try? container.decode(Double.self) {
            return value
        }
        if let value = try? container.decode(String.self) {
            return value
        }
        if let value = try? container.decodeNil() {
            if value {
                return JSONNull()
            }
        }
        if var container = try? container.nestedUnkeyedContainer() {
            return try decodeArray(from: &container)
        }
        if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self) {
            return try decodeDictionary(from: &container)
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decode(from container: inout KeyedDecodingContainer<JSONCodingKey>, forKey key: JSONCodingKey) throws -> Any {
        if let value = try? container.decode(Bool.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(Int64.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(Double.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(String.self, forKey: key) {
            return value
        }
        if let value = try? container.decodeNil(forKey: key) {
            if value {
                return JSONNull()
            }
        }
        if var container = try? container.nestedUnkeyedContainer(forKey: key) {
            return try decodeArray(from: &container)
        }
        if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key) {
            return try decodeDictionary(from: &container)
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decodeArray(from container: inout UnkeyedDecodingContainer) throws -> [Any] {
        var arr: [Any] = []
        while !container.isAtEnd {
            let value = try decode(from: &container)
            arr.append(value)
        }
        return arr
    }

    static func decodeDictionary(from container: inout KeyedDecodingContainer<JSONCodingKey>) throws -> [String: Any] {
        var dict = [String: Any]()
        for key in container.allKeys {
            let value = try decode(from: &container, forKey: key)
            dict[key.stringValue] = value
        }
        return dict
    }

    static func encode(to container: inout UnkeyedEncodingContainer, array: [Any]) throws {
        for value in array {
            if let value = value as? Bool {
                try container.encode(value)
            } else if let value = value as? Int64 {
                try container.encode(value)
            } else if let value = value as? Double {
                try container.encode(value)
            } else if let value = value as? String {
                try container.encode(value)
            } else if value is JSONNull {
                try container.encodeNil()
            } else if let value = value as? [Any] {
                var container = container.nestedUnkeyedContainer()
                try encode(to: &container, array: value)
            } else if let value = value as? [String: Any] {
                var container = container.nestedContainer(keyedBy: JSONCodingKey.self)
                try encode(to: &container, dictionary: value)
            } else {
                throw encodingError(forValue: value, codingPath: container.codingPath)
            }
        }
    }

    static func encode(to container: inout KeyedEncodingContainer<JSONCodingKey>, dictionary: [String: Any]) throws {
        for (key, value) in dictionary {
            let key = JSONCodingKey(stringValue: key)!
            if let value = value as? Bool {
                try container.encode(value, forKey: key)
            } else if let value = value as? Int64 {
                try container.encode(value, forKey: key)
            } else if let value = value as? Double {
                try container.encode(value, forKey: key)
            } else if let value = value as? String {
                try container.encode(value, forKey: key)
            } else if value is JSONNull {
                try container.encodeNil(forKey: key)
            } else if let value = value as? [Any] {
                var container = container.nestedUnkeyedContainer(forKey: key)
                try encode(to: &container, array: value)
            } else if let value = value as? [String: Any] {
                var container = container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key)
                try encode(to: &container, dictionary: value)
            } else {
                throw encodingError(forValue: value, codingPath: container.codingPath)
            }
        }
    }

    static func encode(to container: inout SingleValueEncodingContainer, value: Any) throws {
        if let value = value as? Bool {
            try container.encode(value)
        } else if let value = value as? Int64 {
            try container.encode(value)
        } else if let value = value as? Double {
            try container.encode(value)
        } else if let value = value as? String {
            try container.encode(value)
        } else if value is JSONNull {
            try container.encodeNil()
        } else {
            throw encodingError(forValue: value, codingPath: container.codingPath)
        }
    }

    public required init(from decoder: Decoder) throws {
        if var arrayContainer = try? decoder.unkeyedContainer() {
            self.value = try JSONAny.decodeArray(from: &arrayContainer)
        } else if var container = try? decoder.container(keyedBy: JSONCodingKey.self) {
            self.value = try JSONAny.decodeDictionary(from: &container)
        } else {
            let container = try decoder.singleValueContainer()
            self.value = try JSONAny.decode(from: container)
        }
    }

    public func encode(to encoder: Encoder) throws {
        if let arr = self.value as? [Any] {
            var container = encoder.unkeyedContainer()
            try JSONAny.encode(to: &container, array: arr)
        } else if let dict = self.value as? [String: Any] {
            var container = encoder.container(keyedBy: JSONCodingKey.self)
            try JSONAny.encode(to: &container, dictionary: dict)
        } else {
            var container = encoder.singleValueContainer()
            try JSONAny.encode(to: &container, value: self.value)
        }
    }
}


// MARK: - ProductAdResponse
struct ProductAdResponse: Codable {
    let code: Int
    let message: String
    let data: ProductDataClass
}

struct ProductDataClass: Codable {
    let id: String
    let adsData: [ProductAdsDatum]?

    enum CodingKeys: String, CodingKey {
        case id
        case adsData = "ads_data"
    }
}

struct ProductAdsDatum: Codable {
    let ads: [ProductAd]?
    let placementID: String

    enum CodingKeys: String, CodingKey {
        case ads
        case placementID = "placement_id"
    }
}

struct ProductAd: Codable {
    let adID, campaignID: String
    let mediaDetails: [ProductMediaDetail]?
    let title: String
    let ctaText: JSONNull?
    let brandLogoAccessURL: String
    let adGroupID, adFormat: String
    let ctaLandingURL: String
    let skus: [ProductSkus]?

    enum CodingKeys: String, CodingKey {
        case adID = "ad_id"
        case campaignID = "campaign_id"
        case mediaDetails = "media_details"
        case title
        case ctaText = "cta_text"
        case brandLogoAccessURL = "brand_logo_access_url"
        case adGroupID = "ad_group_id"
        case adFormat = "ad_format"
        case ctaLandingURL = "cta_landing_url"
        case skus
    }
}

struct ProductMediaDetail: Codable {
    let posterAccessURL: JSONNull?
    let mediaAccessURL: String
    let id: String
    let order: JSONNull?
    let mediaType, aspectRatio: String
    let closedCaptionMediaAccessURL: JSONNull?
    let lengthInSeconds: Int

    enum CodingKeys: String, CodingKey {
        case posterAccessURL = "poster_access_url"
        case mediaAccessURL = "media_access_url"
        case id, order
        case mediaType = "media_type"
        case aspectRatio = "aspect_ratio"
        case closedCaptionMediaAccessURL = "closed_caption_media_access_url"
        case lengthInSeconds = "length_in_seconds"
    }
}

struct ProductSkus: Codable {
    let id: String
}


struct ProductDetailResponse: Codable {
    let products: [ProductDetail]
}

// MARK: - Product
struct ProductDetail: Codable {
    let id, masterID: String
    let url: String
    let title: String
    let isMaster: Bool
    let brandName, shortDescription: String
    let discountInPercentage: Double
    let price, salePrice: ProductDetailPrice
    let imageUrls: [String]
    let properties: [ProductDetailProperty]
    let siblingProductVariants: [JSONAny]

    enum CodingKeys: String, CodingKey {
        case id
        case masterID = "master_id"
        case url, title
        case isMaster = "is_master"
        case brandName = "brand_name"
        case shortDescription = "short_description"
        case discountInPercentage = "discount_in_percentage"
        case price
        case salePrice = "sale_price"
        case imageUrls = "image_urls"
        case properties
        case siblingProductVariants = "sibling_product_variants"
    }
}

// MARK: - Price
struct ProductDetailPrice: Codable {
    let amount: Float
    let currency: String
}

// MARK: - Property
struct ProductDetailProperty: Codable {
    let name, value: String
}

