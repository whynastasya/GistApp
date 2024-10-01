//
//  GistCommitsInformationCollectionViewCell.swift
//  GistApp
//
//  Created by nastasya on 30.09.2024.
//

import UIKit

final class GistCommitsInformationCollectionViewCell: UICollectionViewCell {
    static let identifier = "GistCommitsInformationCollectionViewCell"
    
    private let authorNameLabel = UILabel()
    private let dateTimeLabel = UILabel()
    private let additionsChangeStatusLabel = UILabel()
    private let deletionsChangeStatusLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupContentView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with commit: Commit) {
        authorNameLabel.text = commit.author.name
        dateTimeLabel.text = "Commited at " + DateFormatter.dateForCommits(commit.dateTime)
        additionsChangeStatusLabel.text = "+\(commit.changeStatus.additions)"
        deletionsChangeStatusLabel.text = "-\(commit.changeStatus.deletions)"
    }
    
    private func setupContentView() {
        setupAuthorNameLabel()
        setupDateTimeLabel()
        setupChangeStatusLabel()
        setupConstraints()
    }
    
    private func setupAuthorNameLabel() {
        authorNameLabel.font = UIFont.systemFont(ofSize: 13, weight: .medium)
        authorNameLabel.textAlignment = .left
        authorNameLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(authorNameLabel)
    }
    
    private func setupDateTimeLabel() {
        dateTimeLabel.font = UIFont.systemFont(ofSize: 13, weight: .light)
        dateTimeLabel.textAlignment = .left
        dateTimeLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(dateTimeLabel)
    }
    
    private func setupChangeStatusLabel() {
        additionsChangeStatusLabel.font = UIFont.systemFont(ofSize: 13, weight: .bold)
        additionsChangeStatusLabel.textColor = .systemGreen
        additionsChangeStatusLabel.textAlignment = .left
        additionsChangeStatusLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(additionsChangeStatusLabel)
        
        deletionsChangeStatusLabel.font = UIFont.systemFont(ofSize: 13, weight: .bold)
        deletionsChangeStatusLabel.textColor = .systemRed
        deletionsChangeStatusLabel.textAlignment = .left
        deletionsChangeStatusLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(deletionsChangeStatusLabel)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            authorNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            authorNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            
            dateTimeLabel.topAnchor.constraint(equalTo: authorNameLabel.bottomAnchor, constant: 0),
            dateTimeLabel.leadingAnchor.constraint(equalTo: authorNameLabel.leadingAnchor),
            
            deletionsChangeStatusLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            deletionsChangeStatusLabel.topAnchor.constraint(equalTo: authorNameLabel.topAnchor),
            
            additionsChangeStatusLabel.trailingAnchor.constraint(equalTo: deletionsChangeStatusLabel.leadingAnchor,constant: -5),
            additionsChangeStatusLabel.topAnchor.constraint(equalTo: authorNameLabel.topAnchor)
        ])
    }
}
