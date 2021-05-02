//
//  PropertyDetailPresenter.swift
//  HouseMarket
//
//  Created by Sahey Ignatyev on 02.05.2021.
//

protocol PropertyDetailPresenterProtocol: AnyObject {
    func present(data: PropertyDetail.Data)
}

final class PropertyDetailPresenter: PropertyDetailPresenterProtocol {
    weak var viewController: PropertyDetailViewControllerProtocol?
    private let mapper: PropertyMapperProtocol

    init(mapper: PropertyMapperProtocol) {
        self.mapper = mapper
    }

    func present(data: PropertyDetail.Data) {
        let propertyViewModel = mapper.map(property: data.property, isHighlighted: data.isHighlighted)
        let viewModel = PropertyDetail.ViewModel(property: propertyViewModel)
        viewController?.show(viewModel: viewModel)
    }
}
