//
//  PropertyListViewController.swift
//  HouseMarket
//
//  Created by Sahey Ignatyev on 02.05.2021.
//

import UIKit

protocol PropertyListViewControllerProtocol: AnyObject {
    func show(viewModel: PropertyList.ViewModel)
}

final class PropertyListViewController: UIViewController {
    private typealias PropertyCell = CollectionCell<PropertyView>
    private typealias MunicipalityCell = CollectionCell<MunicipalityView>
    private typealias ViewModel = PropertyList.ViewModel

    private var flowLayout: UICollectionViewFlowLayout!
    private var collectionView: UICollectionView!

    private let interactor: PropertyListInteractorProtocol

    private var cells = [ViewModel.Cell]()

    init(interactor: PropertyListInteractorProtocol) {
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
        title = "Sök bostad"
        view.backgroundColor = .design(.background(style: .primary))
        flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = 20
        flowLayout.sectionInset = UIEdgeInsets(
            top: flowLayout.minimumInteritemSpacing,
            left: 0,
            bottom: 0,
            right: 0
        )
        flowLayout.sectionInsetReference = .fromSafeArea

        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: flowLayout)
        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        collectionView.backgroundColor = .design(.background(style: .primary))
        collectionView.alwaysBounceVertical = true
        view.addSubview(collectionView)

        collectionView.dataSource = self
        collectionView.delegate = self

        collectionView.register(PropertyCell.self, forCellWithReuseIdentifier: "PropertyCell")
        collectionView.register(MunicipalityCell.self, forCellWithReuseIdentifier: "MunicipalityCell")
    }
}

extension PropertyListViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(
            width: collectionView.bounds.inset(by: collectionView.layoutMargins).size.width,
            height: cells[indexPath.row].cellHeight
        )
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        cells.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let viewModel = cells[indexPath.row]
        let cell: UICollectionViewCell
        switch viewModel {
        case let .property(viewModel):
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PropertyCell", for: indexPath)
            (cell as? PropertyCell)?.view.configure(viewModel: viewModel)
        case let .municipality(viewModel):
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MunicipalityCell", for: indexPath)
            (cell as? MunicipalityCell)?.view.configure(viewModel: viewModel)
        }
        return cell
    }
}

extension PropertyListViewController: PropertyListViewControllerProtocol {
    func show(viewModel: PropertyList.ViewModel) {
        cells = viewModel.cells
        collectionView.reloadData()
    }
}

private extension PropertyList.ViewModel.Cell {
    var cellHeight: CGFloat {
        switch self {
        case .property:
            return 180
        case .municipality:
            return 230
        }
    }
}
