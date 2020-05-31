//
//  PeopleViewController.swift
//  Readdle 2020
//
//  Created by Eugene Ilyin on 30.05.2020.
//  Copyright © 2020 Eugene Ilyin. All rights reserved.
//

import UIKit

class PeopleViewController: UIViewController {

    // MARK: - Properties
    
    var coordinator: PeopleCoordinator?
    
    // MARK: - Private properties
    
    private var alertHandler: AlertHandler?
    private var viewModelReference: PeopleViewModel?
    private var collectionViewDataSource: UICollectionViewDataSource?
    private var collectionViewDelegate: UICollectionViewDelegate?
    
    // MARK: - View life cycle
    
    override func loadView() {
        super.loadView()
        
        let view = PeopleView()
        self.view = view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        setupViewModel()
        bindView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        /// Hide the navigation bar for this view controller.
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        /// Show the navigation bar for other view controllers.
        self.navigationController?.navigationBar.isHidden = false
    }
    
    // MARK: - Private methods
    
    private func setupViewModel() {
        self.alertHandler = AlertHandler(delegate: self)
        
        var viewModel = PeopleViewModel()
        viewModel.coordinatorReference = coordinator
        viewModel.alertHandlerReference = alertHandler
        self.viewModelReference = viewModel
        
        if let view = self.view as? PeopleView {
            view.configure(with: viewModel)
        }
    }
    
    private func bindView() {
        guard viewModelReference != nil else {
            return
        }
        if let view = self.view as? PeopleView {
            view.peopleSimulateChangesButton.addTarget(self, action: #selector(didPressSimulateChanges(_:)), for: .touchUpInside)
            
            view.peopleLayoutSegmentedControl.addTarget(self, action: #selector(didChangeSegmentedControlValue(_:)), for: .valueChanged)
        }
    }
    
    @objc
    private func didPressSimulateChanges(_ sender: UIButton) {
        if let view = self.view as? PeopleView {
            PersonsWarehouse.shared.shufflePersons()
            DispatchQueue.main.async {
                view.peopleCollectionView.reloadData()
            }
        }
    }
    
    @objc
    private func didChangeSegmentedControlValue(_ sender: UISegmentedControl) {
        if let view = self.view as? PeopleView {
            switch sender.selectedSegmentIndex {
            case 0: /// List
                viewModelReference?.currentLayout = .list
            case 1: /// Grid
                viewModelReference?.currentLayout = .grid
            default:
                break
            }
            
            DispatchQueue.main.async {
                view.peopleCollectionView.reloadData()
            }
        }
    }
}
