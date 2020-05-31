//
//  PeopleView.swift
//  Readdle 2020
//
//  Created by Eugene Ilyin on 30.05.2020.
//  Copyright © 2020 Eugene Ilyin. All rights reserved.
//

import UIKit

class PeopleView: UIView {

    // MARK: - Subviews
    
    lazy var peopleLayoutSegmentedControl: UISegmentedControl = {
        var layoutVariants: [String] = []
        for layout in PeopleLayout.allCases {
            layoutVariants.append(layout.rawValue.capitalized)
        }
        let segmentedControl = UISegmentedControl(items: layoutVariants)
        segmentedControl.selectedSegmentIndex = 0
        return segmentedControl
    }()

    lazy var peopleCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
        layout.itemSize = CGSize(width: 100, height: 100)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.backgroundColor = .white
        return collectionView
    }()
    
    lazy var peopleSimulateChangesButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Simulate Changes", for: .normal)
        return button
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
    
    func configure(with viewModel: PeopleViewModel) {
        /// Register UICollectionViewCell classes.
        peopleCollectionView.register(PersonListCollectionViewCell.self, forCellWithReuseIdentifier: PersonListCollectionViewCell.reuseIdentifier)
        peopleCollectionView.register(PersonGridCollectionViewCell.self, forCellWithReuseIdentifier: PersonGridCollectionViewCell.reuseIdentifier)
        
        /// Set data source.
        peopleCollectionView.dataSource = viewModel.collectionViewDataSource
        
        /// Set delegate.
        peopleCollectionView.delegate = viewModel.collectionViewDelegate
        
        DispatchQueue.main.async {
            self.peopleCollectionView.reloadData()
        }
    }
    
    // MARK: - Private methods
    
    private func setupSubviews() {
        setupPeopleLayoutSegmentedControl()
        setupPeopleSimulateChangesButton()
        setupPeopleCollectionView() /// Should be called last
    }
    
    private func setupPeopleLayoutSegmentedControl() {
        self.addSubview(peopleLayoutSegmentedControl)
        
        peopleLayoutSegmentedControl.translatesAutoresizingMaskIntoConstraints = false
        /// Puts `peopleLayoutSegmentedControl` in the top center area of the safe area.
        /// Also makes sure that the segmented control does not clip through screen bounds.
        NSLayoutConstraint.activate([
            peopleLayoutSegmentedControl.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            peopleLayoutSegmentedControl.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            peopleLayoutSegmentedControl.widthAnchor.constraint(greaterThanOrEqualToConstant: 200),
            peopleLayoutSegmentedControl.widthAnchor.constraint(lessThanOrEqualTo: safeAreaLayoutGuide.widthAnchor, constant: -20)
        ])
    }
    
    private func setupPeopleSimulateChangesButton() {
        self.addSubview(peopleSimulateChangesButton)
        
        peopleSimulateChangesButton.translatesAutoresizingMaskIntoConstraints = false
        /// Puts `peopleSimulateChangesButton` in the bottom center area of the safe area.
        NSLayoutConstraint.activate([
            peopleSimulateChangesButton.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            peopleSimulateChangesButton.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            peopleSimulateChangesButton.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            peopleSimulateChangesButton.heightAnchor.constraint(equalToConstant: 80)
        ])
    }
    
    private func setupPeopleCollectionView() {
        self.addSubview(peopleCollectionView)
        
        peopleCollectionView.translatesAutoresizingMaskIntoConstraints = false
        /// Puts `peopleCollectionView` in the center of the safe area,
        /// between `peopleLayoutSegmentedControl` and `peopleSimulateChangesButton`.
        /// As well as compensates vertical space by clipping `peopleLayoutSegmentedControl` if there are no space available.
        NSLayoutConstraint.activate([
            peopleCollectionView.topAnchor.constraint(equalTo: peopleLayoutSegmentedControl.bottomAnchor, constant: 10),
            peopleCollectionView.bottomAnchor.constraint(equalTo: peopleSimulateChangesButton.topAnchor, constant: -10),
            peopleCollectionView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 5),
            peopleCollectionView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -5)
        ])
        
        peopleCollectionView.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
    }

}
