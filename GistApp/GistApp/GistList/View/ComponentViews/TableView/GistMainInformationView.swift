//
//  GistMainInformationView.swift
//  GistApp
//
//  Created by nastasya on 26.09.2024.
//

import UIKit

final class GistMainInformationView: UIView  {
    private var multiplier: CGFloat
    
    private let avatarImageView = UIImageView()
    private let authorNameLabel = UILabel()
    private let gistNameLabel = UILabel()
    
    init(multiplier: CGFloat) {
        self.multiplier = multiplier
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with information: GistMainInformation) {
        authorNameLabel.text = information.author.name
        gistNameLabel.text = information.name
        
        if let cachedImage = ImageCache.shared.object(forKey: information.author.avatarUrl as NSString) {
            avatarImageView.image = cachedImage
            return
        }
        
        if let avatarURL = URL(string: information.author.avatarUrl) {
            URLSession.shared.dataTask(with: avatarURL) { [weak self] data, response, error in
                guard let self = self, let data = data, error == nil else { return }
                
                if let image = UIImage(data: data) {
                    ImageCache.shared.setObject(image, forKey: information.author.avatarUrl as NSString)
                    
                    DispatchQueue.main.async {
                        UIView.transition(with: self.avatarImageView,
                                          duration: 0.3,
                                          options: .transitionCrossDissolve,
                                          animations: {
                            self.avatarImageView.image = image
                        },
                                          completion: nil)
                    }
                }
            }.resume()
        }
    }
    
    private func setupView() {
        setupAvatarImageView()
        setupGistNameLabel()
        setupAuthorNameLabel()
        setupConstraints()
    }
    
    private func setupAvatarImageView() {
        avatarImageView.contentMode = .scaleAspectFill
        avatarImageView.backgroundColor = .lightGray.withAlphaComponent(0.4)
        avatarImageView.layer.cornerRadius = Dimensions.avatarForTableViewCell.rawValue * multiplier / 2
        avatarImageView.layer.masksToBounds = true
        avatarImageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(avatarImageView)
    }
    
    private func setupGistNameLabel() {
        gistNameLabel.font = UIFont.systemFont(ofSize: 17 * multiplier, weight: .medium)
        gistNameLabel.textAlignment = .left
        gistNameLabel.numberOfLines = 2
        gistNameLabel.textColor = .systemBlue
        gistNameLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(gistNameLabel)
    }
    
    private func setupAuthorNameLabel() {
        authorNameLabel.font = UIFont.systemFont(ofSize: 13 * multiplier, weight: .light)
        authorNameLabel.textAlignment = .left
        authorNameLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(authorNameLabel)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            avatarImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            avatarImageView.widthAnchor.constraint(equalToConstant: Dimensions.avatarForTableViewCell.rawValue * multiplier),
            avatarImageView.heightAnchor.constraint(equalToConstant: Dimensions.avatarForTableViewCell.rawValue * multiplier),
            avatarImageView.topAnchor.constraint(equalTo: topAnchor, constant: 5),

            gistNameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 15),
            gistNameLabel.topAnchor.constraint(equalTo: avatarImageView.topAnchor),
            gistNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            
            authorNameLabel.leadingAnchor.constraint(equalTo: gistNameLabel.leadingAnchor),
            authorNameLabel.topAnchor.constraint(equalTo: gistNameLabel.bottomAnchor, constant: 0),
            authorNameLabel.trailingAnchor.constraint(equalTo: gistNameLabel.trailingAnchor),
            
            authorNameLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        ])
    }
}
