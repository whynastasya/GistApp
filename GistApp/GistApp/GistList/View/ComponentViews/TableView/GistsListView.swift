//
//  GistsListView.swift
//  GistApp
//
//  Created by nastasya on 27.09.2024.
//

import UIKit

final class GistsListView: UIView {
    let tableView = UITableView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupView() {
        setupTableView()
        setupConstraints()
    }
    
    private func setupTableView() {
        tableView.register(GistMainInformationTableViewCell.self, forCellReuseIdentifier: GistMainInformationTableViewCell.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(tableView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
