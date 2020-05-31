//
//  DetailedInfoView.swift
//  Readdle 2020
//
//  Created by Eugene Ilyin on 30.05.2020.
//  Copyright © 2020 Eugene Ilyin. All rights reserved.
//

import UIKit

class DetailedInfoView: UIView {

    // MARK: - Subviews
    
    lazy var detailAvatarImageView: AsyncImageView = {
        let imageView = AsyncImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var detailAvatarImageLoadingActivityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.style = .gray
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
        return activityIndicator
    }()
    
    lazy var detailNameLabel: UILabel = {
        let label = UILabel()
        label.lineBreakMode = .byTruncatingTail
        label.numberOfLines = 1
        label.textAlignment = .center
        label.font = .preferredFont(forTextStyle: .largeTitle)
        return label
    }()
    
    lazy var detailStatusLabel: UILabel = {
        let label = UILabel()
        label.lineBreakMode = .byTruncatingTail
        label.numberOfLines = 1
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 20)
        return label
    }()
    
    lazy var detailEmailTextView: UITextView = {
        let textView = UITextView()
        textView.isEditable = false
        textView.textAlignment = .center
        textView.font = .preferredFont(forTextStyle: .title2)
        textView.dataDetectorTypes = .all
        return textView
    }()
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .white
        setupSubviews()
    }
    
    @available(*, unavailable, message: "use init(frame:) instead")
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    func configure(with viewModel: DetailedInfoViewModel) {
        detailNameLabel.text = viewModel.name
        detailStatusLabel.text = viewModel.status
        detailEmailTextView.text = viewModel.email
        
        if let url = viewModel.largeImageURL {
            detailAvatarImageView.loadImageFrom(url: url) { (result) in
                switch result {
                case .success():
                    DispatchQueue.main.async {
                        self.detailAvatarImageView.clipsToBounds = true
                        self.detailAvatarImageView.layer.cornerRadius = self.detailAvatarImageView.frame.height / 2
                        self.detailAvatarImageLoadingActivityIndicator.stopAnimating()
                    }
                case .failure(let error):
                    // TODO: Handle errors!
                    print("An error accured while loading image: \(error)")
                    DispatchQueue.main.async {
                        self.detailAvatarImageLoadingActivityIndicator.stopAnimating()
                    }
                }
            }
        } else {
            // Has no image url.
            // TODO: Handle errors!
            detailAvatarImageLoadingActivityIndicator.stopAnimating()
        }
    }
    
    // MARK: - Private methods
    
    private func setupSubviews() {
        setupDetailNameLabel() /// Should be called first, since it will be the "reference" view for other subviews.
         
        setupDetailAvatarImageView()
        setupDetailAvatarImageLoadingActivityIndicator()
        setupDetailStatusLabel()
        setupDetailEmailTextView()
    }
    
    
    private func setupDetailNameLabel() {
        self.addSubview(detailNameLabel)
        
        detailNameLabel.translatesAutoresizingMaskIntoConstraints = false
        /// Puts `detailNameLabel` in the center of the safe area.
        /// Also makes sure that the text in label does not clip through screen bounds.
        NSLayoutConstraint.activate([
            detailNameLabel.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor),
            detailNameLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 5),
            detailNameLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -5)
        ])
    }
    
    private func setupDetailStatusLabel() {
        self.addSubview(detailStatusLabel)
        
        detailStatusLabel.translatesAutoresizingMaskIntoConstraints = false
        /// Puts `detailStatusLabel` in the center of the safe area,
        /// right below `detailNameLabel` with 10 pts vertical spacing.
        /// Also makes sure that the text in label does not clip through screen bounds.
        NSLayoutConstraint.activate([
            detailStatusLabel.topAnchor.constraint(equalTo: detailNameLabel.bottomAnchor, constant: 10),
            detailStatusLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 5),
            detailStatusLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -5)
        ])
    }
    
    private func setupDetailEmailTextView() {
        self.addSubview(detailEmailTextView)
        
        detailEmailTextView.translatesAutoresizingMaskIntoConstraints = false
        /// Puts `detailEmailTextView` in the center of the safe area,
        /// right below `detailStatusLabel` with 10 pts vertical spacing.
        /// Also makes sure that the text in textView does not clip through screen bounds.
        /// As well as compensates vertical space by clipping `detailEmailTextView` if there are no space available.
        NSLayoutConstraint.activate([
            detailEmailTextView.topAnchor.constraint(equalTo: detailStatusLabel.bottomAnchor, constant: 10),
            detailEmailTextView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 5),
            detailEmailTextView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -5),
            detailEmailTextView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: 20)
        ])
        detailEmailTextView.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
    }
    
    
    private func setupDetailAvatarImageView() {
        self.addSubview(detailAvatarImageView)
        
        detailAvatarImageView.translatesAutoresizingMaskIntoConstraints = false
        /// Puts `detailAvatarImageView` in the center of the safe area,
        /// right above `detailNameLabel` with 10 pts vertical spacing.
        /// Also sets aspect ratio to be 1:1.
        /// And makes sure that the image in imageView does not clip through screen bounds.
        NSLayoutConstraint.activate([
            detailAvatarImageView.bottomAnchor.constraint(equalTo: detailNameLabel.topAnchor, constant: -10),
            detailAvatarImageView.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            detailAvatarImageView.widthAnchor.constraint(lessThanOrEqualToConstant: UIScreen.main.bounds.width * 2 / 3),
            detailAvatarImageView.heightAnchor.constraint(equalTo: detailAvatarImageView.widthAnchor, multiplier: 1)
        ])
    }
    
    private func setupDetailAvatarImageLoadingActivityIndicator() {
        self.detailAvatarImageView.addSubview(detailAvatarImageLoadingActivityIndicator)
        
        detailAvatarImageLoadingActivityIndicator.translatesAutoresizingMaskIntoConstraints = false
        /// Puts `detailAvatarImageLoadingActivityIndicator` in the center of `detailAvatarImageView`
        NSLayoutConstraint.activate([
            detailAvatarImageLoadingActivityIndicator.centerXAnchor.constraint(equalTo: detailAvatarImageView.centerXAnchor),
            detailAvatarImageLoadingActivityIndicator.centerYAnchor.constraint(equalTo: detailAvatarImageView.centerYAnchor)
        ])
    }

}
