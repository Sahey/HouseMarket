//
//  PropertySearchModels.swift
//  HouseMarket
//
//  Created by Sahey Ignatyev on 02.05.2021.
//

enum PropertySearch {
    struct Request {}

    struct Response {
        let items: [Item]
    }
}

extension PropertySearch.Response {
    enum Item {
        case property(data: Property)
        case highlightedProperty(data: Property)
        case area(data: Area)
    }

    struct Property {
        let id: String
        let askingPrice: String
        let municipality: String
        let area: String
        let daysOnHemnet: Int
        let livingArea: Double
        let numberOfRooms: Double
        let streetAddress: String
        let image: String?
    }

    struct Area {
        let id: String
        let area: String
        let rating: String
        let averagePrice: String
        let image: String?
    }
}

extension PropertySearch.Response.Area: Decodable {}
extension PropertySearch.Response.Property: Decodable {}

extension PropertySearch.Response.Item: Decodable {
    private enum `Type`: String, Decodable {
        case property = "Property"
        case area = "Area"
        case highlightedProperty = "HighlightedProperty"
    }

    private enum CodingKeys: String, CodingKey {
        case type
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let type = try container.decode(Type.self, forKey: .type)
        switch type {
        case .property:
            self = try .property(data: PropertySearch.Response.Property(from: decoder))
        case .highlightedProperty:
            self = try .highlightedProperty(data: PropertySearch.Response.Property(from: decoder))
        case .area:
            self = try .area(data: PropertySearch.Response.Area(from: decoder))
        }
    }
}

extension PropertySearch.Response: Decodable {}
