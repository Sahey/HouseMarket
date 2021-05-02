//
//  PropertyDetailModels.swift
//  HouseMarket
//
//  Created by Sahey Ignatyev on 02.05.2021.
//

enum PropertyDetail {
    struct Input {
        let property: PropertySearch.Response.Property
        let isHighlighted: Bool
    }

    struct Data {
        let property: PropertySearch.Response.Property
        let isHighlighted: Bool
    }

    struct ViewModel {
        let property: PropertyViewModel
    }
}
