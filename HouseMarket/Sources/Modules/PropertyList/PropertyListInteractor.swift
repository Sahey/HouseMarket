//
//  PropertyListInteractor.swift
//  HouseMarket
//
//  Created by Sahey Ignatyev on 02.05.2021.
//

protocol PropertyListInteractorProtocol {
    func loadData()
    func didSelect(property id: Int)
}

final class MockPropertyListInteractor: PropertyListInteractorProtocol {
    private let presenter: PropertyListPresenterProtocol

    init(presenter: PropertyListPresenterProtocol) {
        self.presenter = presenter
    }

    func loadData() {}

    func didSelect(property id: Int) {}
}
