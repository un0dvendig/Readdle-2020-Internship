//
//  PersonGridCollectionViewCell.swift
//  Readdle 2020
//
//  Created by Eugene Ilyin on 29.05.2020.
//  Copyright © 2020 Eugene Ilyin. All rights reserved.
//

import UIKit

class PersonGridCollectionViewCell: UICollectionViewCell {
    
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
    
    func configure(with viewModel: PersonGridCollectionViewCellViewModel) {
        personStatusView.backgroundColor = viewModel.statusColor
        
        if let url = viewModel.smallImageURL {
            personAvatarImageView.loadImageFrom(url: url) { (result) in
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
            let title = "The Person has invalid email"
            self.alertHandler?.showAlertDialog(title: title, message: error.localizedDescription)
            personAvatarLoadingActivityIndicatorView.stopAnimating()
        }
    }
    
    // MARK: - Private methods
    
        private func setupSubviews() {
        setupPersonAvatarImageView()
        setupPersonStatusView()
        setupPersonAvatarLoadingActivityIndicatorView()
    }
    
    private func setupPersonAvatarImageView() {
        self.addSubview(personAvatarImageView)
        
        personAvatarImageView.translatesAutoresizingMaskIntoConstraints = false
        /// Puts `personAvatarImageView` in the center of the safe area.
        NSLayoutConstraint.activate([
            personAvatarImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            personAvatarImageView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            personAvatarImageView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            personAvatarImageView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor)
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
        personAvatarImageView.addSubview(personAvatarLoadingActivityIndicatorView)
        
        personAvatarLoadingActivityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        /// Puts `personAvatarLoadingActivityIndicatorView` in the center of the `personAvatarImageView`.
        NSLayoutConstraint.activate([
            personAvatarLoadingActivityIndicatorView.centerXAnchor.constraint(equalTo: personAvatarImageView.centerXAnchor),
            personAvatarLoadingActivityIndicatorView.centerYAnchor.constraint(equalTo: personAvatarImageView.centerYAnchor)
        ])
    }
}
