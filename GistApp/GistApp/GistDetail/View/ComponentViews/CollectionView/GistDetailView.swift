//
//  GistDetailView.swift
//  GistApp
//
//  Created by nastasya on 30.09.2024.
//

import UIKit

final class GistDetailView: UIView {
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    init() {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        setupCollectionView()
        setupConstraints()
    }
    
    private func setupCollectionView() {
        collectionView.register(
            GistMainInformationCollectionViewCell.self,
            forCellWithReuseIdentifier: GistMainInformationCollectionViewCell.identifier
        )
        collectionView.register(GistCommitsInformationCollectionViewCell.self, forCellWithReuseIdentifier: GistCommitsInformationCollectionViewCell.identifier)
        collectionView.register(GistFilesInformationCollectionViewCell.self, forCellWithReuseIdentifier: GistFilesInformationCollectionViewCell.identifier)
        collectionView.register(HeaderCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderCollectionReusableView.identifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(collectionView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
