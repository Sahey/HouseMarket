//
//  PropertyListModels.swift
//  HouseMarket
//
//  Created by Sahey Ignatyev on 02.05.2021.
//

enum PropertyList {
    enum Request {
        case property(id: Int)
    }

    typealias Data = PropertySearch.Response

    struct ViewModel {
        let cells: [Cell]
    }
}

extension PropertyList.ViewModel {
    enum Cell {
        case property(viewModel: PropertyViewModel)
        case municipality(viewModel: MunicipalityViewModel)
    }
}
