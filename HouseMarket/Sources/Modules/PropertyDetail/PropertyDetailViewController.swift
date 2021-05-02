//
//  PropertyDetailViewController.swift
//  HouseMarket
//
//  Created by Sahey Ignatyev on 02.05.2021.
//

import UIKit

protocol PropertyDetailViewControllerProtocol: AnyObject {
    func show(viewModel: PropertyDetail.ViewModel)
}

final class PropertyDetailViewController: UIViewController {
    private let interactor: PropertyDetailInteractorProtocol
    private var propertyView: PropertyView!

    init(interactor: PropertyDetailInteractorProtocol) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        interactor.loadData()
    }
    
    private func setup() {
        view.backgroundColor = .design(.background(style: .primary))
        propertyView = PropertyView()
        view.addSubview(propertyView)
        propertyView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            propertyView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            propertyView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -15),
            propertyView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            propertyView.heightAnchor.constraint(equalToConstant: 180)
        ])
    }
}

extension PropertyDetailViewController: PropertyDetailViewControllerProtocol {
    func show(viewModel: PropertyDetail.ViewModel) {
        propertyView.configure(viewModel: viewModel.property)
        title = viewModel.property.address
    }
}
