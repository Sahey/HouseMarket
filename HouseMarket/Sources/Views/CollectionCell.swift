//
//  CollectionCell.swift
//  HouseMarket
//
//  Created by Sahey Ignatyev on 02.05.2021.
//

import UIKit

public protocol CollectionCellWrappable: AnyObject {
    func prepareForReuse()
}

public extension CollectionCellWrappable {
    func prepareForReuse() {}
}

extension UIView: CollectionCellWrappable {}

open class CollectionCell<Wrapped: UIView>: UICollectionViewCell {
    public private(set) var view: Wrapped!

    override public init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    override open func prepareForReuse() {
        super.prepareForReuse()
        view.prepareForReuse()
    }

    open func setup() {
        view = Wrapped(frame: contentView.bounds)

        contentView.backgroundColor = view.backgroundColor
        contentView.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            view.leadingAnchor.constraint(equalTo: leadingAnchor),
            view.trailingAnchor.constraint(equalTo: trailingAnchor),
            view.topAnchor.constraint(equalTo: topAnchor),
            view.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
