//
//  CatalogCell.swift
//  FakeNFT
//
//  Created by Руслан  on 04.11.2023.
//

import UIKit

final class CatalogCell: UITableViewCell {
    
    // MARK: Private properties
    private let previewImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 12
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let previewText: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .bodyBold
        return label
    }()
    
    // MARK: Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 21, left: 16, bottom: .zero, right: 16))
    }
    
    func setupCell(_ collection: CollectionModel) {
        previewText.text = "\(collection.name) (\(collection.nfts.count))"
        guard let urlString = collection.cover.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
              let url = URL(string: urlString) else { return }
        previewImage.kf.indicatorType = .activity
        previewImage.kf.setImage(with: url, placeholder: UIImage(named: "Catalog.collection.placeholder"))
    }
}

private extension CatalogCell {
    func setupViews() {
        self.selectionStyle = .none
        self.backgroundColor = .clear
        contentView.addSubviews(previewImage, previewText)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            previewImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            previewImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            previewImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            previewImage.heightAnchor.constraint(equalToConstant: Constants.imageHeight.rawValue),
            
            previewText.topAnchor.constraint(equalTo: previewImage.bottomAnchor, constant: Constants.topOffset.rawValue),
            previewText.leadingAnchor.constraint(equalTo: contentView.leadingAnchor)
        ])
    }
}

// MARK: - Constants
extension CatalogCell {
    private enum Constants: CGFloat {
        case imageHeight = 140
        case topOffset = 4
    }
}
