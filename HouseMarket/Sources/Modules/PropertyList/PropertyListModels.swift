//
//  PropertyListModels.swift
//  HouseMarket
//
//  Created by Sahey Ignatyev on 02.05.2021.
//

enum PropertyList {
    enum Request {
        case property(id: Int)
        case reload
    }

    typealias Data = PropertySearch.Response

    enum ViewModel {
        case data(cells: [Cell])
        case failure(alert: Alert)
    }
}

extension PropertyList.ViewModel {
    enum Cell {
        case property(viewModel: PropertyViewModel)
        case municipality(viewModel: MunicipalityViewModel)
    }
}

extension PropertyList.ViewModel {
    struct Alert {
        let title: String
        let message: String
        let retry: String
        let cancel: String
    }
}
