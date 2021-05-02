//
//  PropertyListViewController.swift
//  HouseMarket
//
//  Created by Sahey Ignatyev on 02.05.2021.
//

import UIKit

protocol PropertyListViewControllerProtocol: AnyObject {}

final class PropertyListViewController: UIViewController {
    private var flowLayout: UICollectionViewFlowLayout!
    private var collectionView: UICollectionView!

    private typealias PropertyCell = CollectionCell<PropertyView>
    private typealias MunicipalityCell = CollectionCell<MunicipalityView>

    private let interactor: PropertyListInteractorProtocol

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
        if indexPath.row % 3 == 0 {
            return CGSize(
                width: collectionView.bounds.inset(by: collectionView.layoutMargins).size.width,
                height: 230
            )
        } else {
            return CGSize(
                width: collectionView.bounds.inset(by: collectionView.layoutMargins).size.width,
                height: 180
            )
        }
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: UICollectionViewCell

        if indexPath.row % 3 == 0 {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MunicipalityCell", for: indexPath)
        } else {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PropertyCell", for: indexPath)
        }

        switch cell {
        case let propertyCell as PropertyCell:
            propertyCell.view.configure(
                viewModel: PropertyViewModel(
                    id: 1,
                    imageUrl: URL(string: "https://upload.wikimedia.org/wikipedia/commons/thumb/5/5b/Hus_i_svarttorp.jpg/800px-Hus_i_svarttorp.jpg"),
                    isPremium: indexPath.row % 2 == 0,
                    address: "Mockvägen 1",
                    municipality: "Gällivare kommun",
                    price: "2 650 000 kr",
                    livingArea: "49,5 m",
                    numberOfRooms: "2 rum",
                    daysPosted: "1 dagar"
                )
            )
        case let municipalityCell as MunicipalityCell:
            municipalityCell.view.configure(
                viewModel: MunicipalityViewModel(
                    id: 1,
                    title: "Omrade",
                    city: "Stockholm",
                    rating: "Betyg: 4.5/5",
                    imageUrl: URL(string: "https://i.imgur.com/v6GDnCG.png"),
                    averagePrice: "Snittpris: 20 014 kr/m"
                )
            )
        default:
            fatalError("Unexpected cell type")
        }

        return cell
    }
}

extension PropertyListViewController: PropertyListViewControllerProtocol {}
