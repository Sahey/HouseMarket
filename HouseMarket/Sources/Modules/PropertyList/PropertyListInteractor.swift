//
//  PropertyListInteractor.swift
//  HouseMarket
//
//  Created by Sahey Ignatyev on 02.05.2021.
//

protocol PropertyListInteractorProtocol {
    func loadData()
    func request(request: PropertyList.Request)
}

final class PropertyListInteractor: PropertyListInteractorProtocol {
    private let presenter: PropertyListPresenterProtocol
    private let service: PropertySearchServiceProtocol
    private let router: PropertyListRouterProtocol
    private var items = [String: (data: PropertyList.Data.Property, isHighlighted: Bool)]()

    init(
        presenter: PropertyListPresenterProtocol,
        service: PropertySearchServiceProtocol,
        router: PropertyListRouterProtocol
    ) {
        self.presenter = presenter
        self.service = service
        self.router = router
    }

    private func buffer(_ response: PropertySearch.Response) {
        response.items
            .compactMap { item -> (PropertyList.Data.Property, Bool)? in
                switch item {
                case let .property(data):
                    return (data, false)
                case let .highlightedProperty(data):
                    return (data, true)
                case .area:
                    return nil
                }
            }
            .forEach { (property, isHighlighted) in
                self.items[property.id] = (property, isHighlighted)
            }
    }

    func loadData() {
        service.fetch(request: PropertySearch.Request()) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(response):
                self.buffer(response)
                self.presenter.present(data: response)
            case let .failure(error):
                self.presenter.present(error: error)
            }
        }
    }

    func request(request: PropertyList.Request) {
        switch request {
        case let .property(id):
            guard let (property, isHighlighted) = items[id] else { break }
            router.routeToDetails(property: property, isHighlihted: isHighlighted)
        case .reload:
            loadData()
        }
    }
}
