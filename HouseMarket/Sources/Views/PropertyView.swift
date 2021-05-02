//
//  PropertyView.swift
//  HouseMarket
//
//  Created by Sahey Ignatyev on 02.05.2021.
//

import UIKit
import Kingfisher

struct PropertyViewModel {
    let id: String

    let imageUrl: URL?
    let isPremium: Bool
    let address: String
    let municipality: String

    let price: String
    let livingArea: String
    let numberOfRooms: String

    let daysPosted: String
}

class PropertyView: UIView {
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .gray
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 6
        imageView.clipsToBounds = true
        imageView.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        return imageView
    }()

    private let addressLabel: UILabel = {
        let addressLabel = UILabel()
        addressLabel.font = .design(.header(style: .h3))
        addressLabel.textColor = .design(.text(style: .primary))
        addressLabel.setContentCompressionResistancePriority(.defaultHigh + 3, for: .vertical)
        return addressLabel
    }()

    private let iconImageView: UIImageView = {
        let iconImageView = UIImageView()
        iconImageView.contentMode = .scaleAspectFit
        iconImageView.image = UIImage(named: "Icons/flat")
        iconImageView.heightAnchor.constraint(equalToConstant: 12).isActive = true
        iconImageView.widthAnchor.constraint(equalToConstant: 12).isActive = true
        iconImageView.tintColor = .purple
        return iconImageView
    }()

    private let municipalityLabel: UILabel = {
        let municipalityLabel = UILabel()
        municipalityLabel.font = .design(.paragraph(style: .p2))
        municipalityLabel.textColor = .design(.text(style: .secondary))
        municipalityLabel.setContentCompressionResistancePriority(.defaultHigh + 2, for: .vertical)
        return municipalityLabel
    }()

    private let detailsLabel: UILabel = {
        let detailsLabel = UILabel()
        detailsLabel.font = .design(.paragraph(style: .p2))
        detailsLabel.textColor = .design(.text(style: .primary))
        detailsLabel.setContentCompressionResistancePriority(.defaultHigh + 1, for: .vertical)
        detailsLabel.setContentCompressionResistancePriority(.defaultHigh - 1, for: .horizontal)
        detailsLabel.setContentHuggingPriority(.defaultLow + 1, for: .horizontal)
        return detailsLabel
    }()

    private let timeLabel: UILabel = {
        let timeLabel = UILabel()
        timeLabel.font = .design(.paragraph(style: .p2))
        timeLabel.textColor = .design(.text(style: .primary))
        timeLabel.setContentCompressionResistancePriority(.defaultHigh + 1, for: .horizontal)
        timeLabel.setContentHuggingPriority(.defaultLow + 2, for: .horizontal)
        return timeLabel
    }()

    override init(frame: CGRect) {
        super.init(frame: .zero)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    private func setup() {
        backgroundColor = .design(.background(style: .primary))
        let areaStackView = UIStackView(arrangedSubviews: [iconImageView, municipalityLabel])
        areaStackView.spacing = .horizontalStackSpacing
        areaStackView.axis = .horizontal

        let detailsStackView = UIStackView(arrangedSubviews: [detailsLabel, timeLabel])
        detailsStackView.spacing = .horizontalStackSpacing
        detailsStackView.axis = .horizontal

        let stackView = UIStackView(arrangedSubviews: [imageView, addressLabel, areaStackView, detailsStackView])
        stackView.axis = .vertical
        stackView.frame = bounds
        stackView.spacing = .verticalStackSpacing
        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    func configure(viewModel: PropertyViewModel) {
        addressLabel.text = viewModel.address
        municipalityLabel.text = viewModel.municipality
        detailsLabel.text = [viewModel.price, viewModel.livingArea, viewModel.numberOfRooms].commaSeparated
        timeLabel.text = viewModel.daysPosted
        if viewModel.isPremium {
            imageView.layer.borderWidth = .premiumBorderWidth
            imageView.layer.borderColor = UIColor.design(.constant(style: .premium)).cgColor
        } else {
            imageView.layer.borderWidth = 0
            imageView.layer.borderColor = nil
        }
        imageView.kf.setImage(with: viewModel.imageUrl)
    }
}

private extension CGFloat {
    static let verticalStackSpacing: CGFloat = 5
    static let horizontalStackSpacing: CGFloat = 5
    static let premiumBorderWidth: CGFloat = 2.5
}
