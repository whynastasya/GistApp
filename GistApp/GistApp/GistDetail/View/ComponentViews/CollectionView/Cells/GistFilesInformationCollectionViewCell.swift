//
//  GistFilesInformationCollectionViewCell.swift
//  GistApp
//
//  Created by nastasya on 30.09.2024.
//

import UIKit

final class GistFilesInformationCollectionViewCell: UICollectionViewCell {
    static let identifier = "GistFilesInformationCollectionViewCell"
    
    private let fileNameLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupContentView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with fileName: String) {
        fileNameLabel.text = fileName
    }
    
    private func setupContentView() {
        setupFileNameLabel()
        setupConstraints()
    }
    
    private func setupFileNameLabel() {
        fileNameLabel.font = .systemFont(ofSize: 14, weight: .medium)
        fileNameLabel.textAlignment = .left
        fileNameLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(fileNameLabel)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            fileNameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            fileNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            fileNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15)        ])
    }
}
