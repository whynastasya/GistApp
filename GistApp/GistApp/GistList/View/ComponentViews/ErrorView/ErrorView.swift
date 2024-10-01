//
//  ErrorView.swift
//  GistApp
//
//  Created by nastasya on 27.09.2024.
//

import UIKit

final class ErrorView: UIView {
    private let warningImageView = UIImageView()
    private let titleLabel = UILabel()
    private let messageLabel = UILabel()
    private let retryButton = UIButton()
    
    var retryAction: () -> Void = {}
        
    init() {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupView() {
        setupWarningImageView()
        setupTitleLabel()
        setupMessageButton()
        setupRetryButton()
        setupConstraints()
    }
    
    private func setupWarningImageView() {
        warningImageView.image = UIImage(systemName: "exclamationmark.triangle.fill")
        warningImageView.tintColor = .systemYellow
        warningImageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(warningImageView)
    }
    
    private func setupTitleLabel() {
        titleLabel.text = "Что-то пошло не так"
        titleLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(titleLabel)
    }
    
    private func setupMessageButton() {
        messageLabel.text = "Возможно, пропал интернет, или у нас что-то сломалось. Проверьте подключение или попробуйте позже"
        messageLabel.textAlignment = .center
        messageLabel.font = UIFont.preferredFont(forTextStyle: .body)
        messageLabel.textAlignment = .center
        messageLabel.numberOfLines = 3
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(messageLabel)
    }
    
    private func setupRetryButton() {
        retryButton.setTitle("Обновить", for: .normal)
        retryButton.backgroundColor = .systemBlue
        retryButton.setTitleColor(.white, for: .normal)
        retryButton.layer.cornerRadius = 10
        retryButton.addTarget(self, action: #selector(retryTapped), for: .touchUpInside)
        retryButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(retryButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            messageLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            messageLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            messageLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            titleLabel.bottomAnchor.constraint(equalTo: messageLabel.topAnchor, constant: -10),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            warningImageView.bottomAnchor.constraint(equalTo: titleLabel.topAnchor, constant: -10),
            warningImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            warningImageView.widthAnchor.constraint(equalToConstant: 40),
            warningImageView.heightAnchor.constraint(equalToConstant: 40),
            
            retryButton.topAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 15),
            retryButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            retryButton.widthAnchor.constraint(equalToConstant: 100),
            retryButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    @objc private func retryTapped() {
        retryAction()
    }
}
