//
//  PersonListCollectionViewCell.swift
//  Readdle 2020
//
//  Created by Eugene Ilyin on 29.05.2020.
//  Copyright © 2020 Eugene Ilyin. All rights reserved.
//

import UIKit

class PersonListCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Subviews
    
    lazy var personAvatarImageView: AsyncImageView = {
        let imageView = AsyncImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var personAvatarLoadingActivityIndicatorView: UIActivityIndicatorView = {
        let activityIndicatorView = UIActivityIndicatorView()
        activityIndicatorView.style = .gray
        activityIndicatorView.hidesWhenStopped = true
        activityIndicatorView.startAnimating()
        return activityIndicatorView
    }()
    
    lazy var personStatusView: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        return view
    }()
    
    lazy var personNameLabel: UILabel = {
        let label = UILabel()
        label.lineBreakMode = .byTruncatingTail
        label.numberOfLines = 1
        label.textAlignment = .left
        return label
    }()
    
    // MARK: - Properties
    
    var alertHandler: AlertHandler?
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
    }
    
    @available(*, unavailable, message: "use init(frame:) instead")
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    func configure(with viewModel: PersonListCollectionViewCellViewModel) {
        personNameLabel.text = viewModel.name
        personStatusView.backgroundColor = viewModel.statusColor
        
        if let url = viewModel.smallImageURL {
            personAvatarImageView.loadImageFrom(url: url) { [unowned self] (result) in
                switch result {
                case .success():
                    DispatchQueue.main.async {
                        self.personAvatarImageView.clipsToBounds = true
                        self.personAvatarImageView.layer.cornerRadius = self.personAvatarImageView.frame.height / 2
                        self.personAvatarLoadingActivityIndicatorView.stopAnimating()
                    }
                case .failure(let error):
                    let title = "An error occurred while loading image"
                    self.alertHandler?.showAlertDialog(title: title, message: error.localizedDescription)
                    DispatchQueue.main.async {
                        self.personAvatarLoadingActivityIndicatorView.stopAnimating()
                    }
                }
            }
        } else {
            // The Person for some reason has no image url.
            let error = CustomError.cannotCreateImageURL
            let title = "The Person \(viewModel.name) has invalid email"
            self.alertHandler?.showAlertDialog(title: title, message: error.localizedDescription)
            personAvatarLoadingActivityIndicatorView.stopAnimating()
        }
    }
    
    // MARK: - Private methods
    
    private func setupSubviews() {
        setupPersonAvatarImageView()
        setupPersonStatusView()
        setupPersonAvatarLoadingActivityIndicatorView()
        setupPersonNameLabel()
    }
    
    private func setupPersonAvatarImageView() {
        self.addSubview(personAvatarImageView)
        
        personAvatarImageView.translatesAutoresizingMaskIntoConstraints = false
        /// Puts `personAvatarImageView` in the left part of the safe area.
        NSLayoutConstraint.activate([
            personAvatarImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            personAvatarImageView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            personAvatarImageView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            personAvatarImageView.widthAnchor.constraint(equalTo: personAvatarImageView.heightAnchor, multiplier: 1)
        ])
    }
    
    private func setupPersonStatusView() {
        self.addSubview(personStatusView)
        
        personStatusView.translatesAutoresizingMaskIntoConstraints = false
        /// Puts `personAvatarLoadingActivityIndicatorView` in the bottom right corner of the `personAvatarImageView`.
        /// Also sets its aspect ratio to 1:1. As well as height to be 20 pts.
        NSLayoutConstraint.activate([
            personStatusView.trailingAnchor.constraint(equalTo: personAvatarImageView.trailingAnchor),
            personStatusView.bottomAnchor.constraint(equalTo: personAvatarImageView.bottomAnchor),
            personStatusView.heightAnchor.constraint(equalTo: personStatusView.widthAnchor, multiplier: 1),
            personStatusView.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        personStatusView.layer.cornerRadius = 10
    }
    
    private func setupPersonAvatarLoadingActivityIndicatorView() {
        personStatusView.addSubview(personAvatarLoadingActivityIndicatorView)
        
        personAvatarLoadingActivityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        /// Puts `personAvatarLoadingActivityIndicatorView` in the center of the `personAvatarImageView`.
        NSLayoutConstraint.activate([
            personAvatarLoadingActivityIndicatorView.centerXAnchor.constraint(equalTo: personStatusView.centerXAnchor),
            personAvatarLoadingActivityIndicatorView.centerYAnchor.constraint(equalTo: personStatusView.centerYAnchor)
        ])
    }
    
    private func setupPersonNameLabel() {
        self.addSubview(personNameLabel)
        
        personNameLabel.translatesAutoresizingMaskIntoConstraints = false
        /// Puts `personNameLabel` in the right area of the cell.
        NSLayoutConstraint.activate([
            personNameLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 5),
            personNameLabel.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -5),
            personNameLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -10),
            personNameLabel.leadingAnchor.constraint(equalTo: personAvatarImageView.trailingAnchor, constant: 10)
        ])
    }

}
