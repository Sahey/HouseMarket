//
//  MunicipalityView.swift
//  HouseMarket
//
//  Created by Sahey Ignatyev on 02.05.2021.
//

import Kingfisher
import UIKit

struct MunicipalityViewModel {
    let id: Int

    let title: String
    let city: String
    let rating: String
    let imageUrl: URL?
    let averagePrice: String
}

final class MunicipalityView: UIView {
    private let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.font = .design(.header(style: .h1))
        titleLabel.textColor = .design(.text(style: .primary))
        titleLabel.setContentCompressionResistancePriority(.defaultHigh + 4, for: .vertical)
        return titleLabel
    }()

    private let areaImageView: UIImageView = {
        let areaImageView = UIImageView()
        areaImageView.backgroundColor = .gray
        areaImageView.contentMode = .scaleAspectFill
        areaImageView.layer.cornerRadius = 6
        areaImageView.clipsToBounds = true
        areaImageView.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        return areaImageView
    }()

    private let cityLabel: UILabel = {
        let cityLabel = UILabel()
        cityLabel.font = .design(.header(style: .h2))
        cityLabel.textColor = .design(.text(style: .primary))
        cityLabel.setContentCompressionResistancePriority(.defaultHigh + 3, for: .vertical)
        return cityLabel
    }()

    private let ratingLabel: UILabel = {
        let ratingLabel = UILabel()
        ratingLabel.font = .design(.paragraph(style: .p1))
        ratingLabel.textColor = .design(.text(style: .primary))
        ratingLabel.setContentCompressionResistancePriority(.defaultHigh + 2, for: .vertical)
        return ratingLabel
    }()

    private let averagePriceLabel: UILabel = {
        let averagePriceLabel = UILabel()
        averagePriceLabel.font = .design(.paragraph(style: .p1))
        averagePriceLabel.textColor = .design(.text(style: .primary))
        averagePriceLabel.setContentCompressionResistancePriority(.defaultHigh + 1, for: .vertical)
        return averagePriceLabel
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
        let stackView = UIStackView(arrangedSubviews: [
            titleLabel,
            areaImageView,
            cityLabel,
            ratingLabel,
            averagePriceLabel
        ])
        stackView.axis = .vertical
        stackView.spacing = 5
        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    func configure(viewModel: MunicipalityViewModel) {
        titleLabel.text = viewModel.title
        cityLabel.text = viewModel.city
        ratingLabel.text = viewModel.rating
        averagePriceLabel.text = viewModel.averagePrice
        areaImageView.kf.setImage(with: viewModel.imageUrl)
    }
}
