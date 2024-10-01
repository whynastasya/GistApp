//
//  GistMainInformationCollectionViewCell.swift
//  GistApp
//
//  Created by nastasya on 30.09.2024.
//

import UIKit

final class GistMainInformationCollectionViewCell: UICollectionViewCell {
    static let identifier = "GistMainInformationCollectionViewCell"
    
    private let gistMainInformationView = GistMainInformationView(multiplier: 1.5)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupContentView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with information: GistMainInformation) {
        gistMainInformationView.configure(with: information)
    }
    
    private func setupContentView() {
        contentView.addSubview(gistMainInformationView)
        gistMainInformationView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            gistMainInformationView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            gistMainInformationView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            gistMainInformationView.topAnchor.constraint(equalTo: contentView.topAnchor),
            gistMainInformationView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}

