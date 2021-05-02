//
//  PropertyListViewController.swift
//  HouseMarket
//
//  Created by Sahey Ignatyev on 02.05.2021.
//

import UIKit

final class ColumnFlowLayout: UICollectionViewFlowLayout {
    private let height: CGFloat

    init(height: CGFloat) {
        self.height = height
        super.init()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepare() {
        super.prepare()
        guard let collectionView = collectionView else {
            return
        }
        itemSize = CGSize(
            width: collectionView.bounds.inset(by: collectionView.layoutMargins).size.width,
            height: height
        )

        sectionInset = UIEdgeInsets(
            top: minimumInteritemSpacing,
            left: 0,
            bottom: 0,
            right: 0
        )

        sectionInsetReference = .fromSafeArea
    }
}

final class PropertyListViewController: UIViewController {
    private var flowLayout: ColumnFlowLayout!
    private var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    private func setup() {
        view.backgroundColor = .designColor(.background(style: .primary))
        flowLayout = ColumnFlowLayout(height: 100)
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: flowLayout)
        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        collectionView.backgroundColor = .designColor(.background(style: .primary))
        collectionView.alwaysBounceVertical = true
        view.addSubview(collectionView)

        collectionView.dataSource = self
        collectionView.delegate = self
    }
}

extension PropertyListViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        UICollectionViewCell()
    }
}
