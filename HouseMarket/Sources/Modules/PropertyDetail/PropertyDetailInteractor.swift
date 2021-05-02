//
//  PropertyDetailInteractor.swift
//  HouseMarket
//
//  Created by Sahey Ignatyev on 02.05.2021.
//

import Foundation

protocol PropertyDetailInteractorProtocol {
    func loadData()
}

final class PropertyDetailInteractor: PropertyDetailInteractorProtocol {
    private let data: PropertyDetail.Data
    private let presenter: PropertyDetailPresenterProtocol

    init(
        data: PropertyDetail.Data,
        presenter: PropertyDetailPresenterProtocol
    ) {
        self.data = data
        self.presenter = presenter
    }

    func loadData() {
        presenter.present(data: data)
    }
}
