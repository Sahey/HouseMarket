//
//  PropertyListInteractor.swift
//  HouseMarket
//
//  Created by Sahey Ignatyev on 02.05.2021.
//

protocol PropertyListInteractorProtocol {
    func loadData()
    func didSelect(property request: PropertyList.Request)
}

final class PropertyListInteractor: PropertyListInteractorProtocol {
    private let presenter: PropertyListPresenterProtocol
    private let service: PropertySearchServiceProtocol

    init(presenter: PropertyListPresenterProtocol, service: PropertySearchServiceProtocol) {
        self.presenter = presenter
        self.service = service
    }

    func loadData() {
        service.fetch(request: PropertySearch.Request()) { [weak self] result in
            switch result {
            case let .success(response):
                self?.presenter.present(data: response)
            case let .failure(error):
                ()
            }
            print(result)
        }
    }

    func didSelect(property request: PropertyList.Request) {
        
    }
}
