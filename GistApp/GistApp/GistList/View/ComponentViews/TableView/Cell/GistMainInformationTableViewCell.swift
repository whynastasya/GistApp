//
//  GistMainInformationTableViewCell.swift
//  GistApp
//
//  Created by nastasya on 30.09.2024.
//

import UIKit

final class GistMainInformationTableViewCell: UITableViewCell {
    static let identifier = "GistMainInformationTableViewCell"
    
    private let gistMainInformationView = GistMainInformationView(multiplier: 1)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
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
        selectionStyle = .none
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
