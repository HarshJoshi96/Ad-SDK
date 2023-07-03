//
//  APIRequest.swift
//  Pods
//
//  Created by Abhishek.Batra on 6/26/23.
//

import Foundation

// MARK: - BrandAdRequest
struct BrandAdRequest: Codable {
    let user: User
    let filter: Filter
    let consent: Consent
}

struct Consent: Codable {
    let gdpr, ccpa, coppa: Bool
}

struct Filter: Codable {
    let adCount, placementID: Int
    let targetingType: String
    let targetingValueList: [String]

    enum CodingKeys: String, CodingKey {
        case adCount = "ad_count"
        case placementID = "placement_id"
        case targetingType = "targeting_type"
        case targetingValueList = "targeting_value_list"
    }
}

struct User: Codable {
    let guestID, userID: String
    let platform: Platform

    enum CodingKeys: String, CodingKey {
        case guestID = "guest_id"
        case userID = "user_id"
        case platform
    }
}

struct Platform: Codable {
    let deviceType: String

    enum CodingKeys: String, CodingKey {
        case deviceType = "device_type"
    }
}

// MARK: - ProductAdRequest
struct ProductAdRequest: Codable {
    let user: ProductUser
    let filter: ProductFilter
    let consent: ProductConsent
}

struct ProductConsent: Codable {
    let gdpr, ccpa, coppa: Bool
}

struct ProductFilter: Codable {
    let placements: [ProductPlacement]
    let targetingType: String
    let targetingValueList: [String]

    enum CodingKeys: String, CodingKey {
        case placements
        case targetingType = "targeting_type"
        case targetingValueList = "targeting_value_list"
    }
}

struct ProductPlacement: Codable {
    let adCount, id: Int

    enum CodingKeys: String, CodingKey {
        case adCount = "ad_count"
        case id
    }
}

struct ProductUser: Codable {
    let guestID, iccsID, userID: String
    let platform: ProductPlatform
    let address: ProductAddress

    enum CodingKeys: String, CodingKey {
        case guestID = "guest_id"
        case iccsID = "iccs_id"
        case userID = "user_id"
        case platform, address
    }
}

struct ProductAddress: Codable {
    let zipCode: String

    enum CodingKeys: String, CodingKey {
        case zipCode = "zip_code"
    }
}

struct ProductPlatform: Codable {
    let deviceType: String

    enum CodingKeys: String, CodingKey {
        case deviceType = "device_type"
    }
}
