//
//  FirstModel.swift
//  Image
//
//  Created by Tanya on 04.01.2022.
//


import Foundation

// MARK: - RandomImage
struct RandomImage: Codable {
    let type: String
    let totalCount: Int
    let value: [Value]

    enum CodingKeys: String, CodingKey {
        case type = "_type"
        case totalCount, value
    }
}

// MARK: - Value
struct Value: Codable {
    let url: String
    let height, width: Int
    let thumbnail: String
    let thumbnailHeight, thumbnailWidth: Int
    let base64Encoding: JSONNull?
    let name, title: String
    let provider: Provider
    let imageWebSearchURL: String
    let webpageURL: String

    enum CodingKeys: String, CodingKey {
        case url, height, width, thumbnail, thumbnailHeight, thumbnailWidth, base64Encoding, name, title, provider
        case imageWebSearchURL = "imageWebSearchUrl"
        case webpageURL = "webpageUrl"
    }
}

// MARK: - Provider
struct Provider: Codable {
    let name, favIcon, favIconBase64Encoding: String
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

