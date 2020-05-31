//
//  DetailedInfoViewController.swift
//  Readdle 2020
//
//  Created by Eugene Ilyin on 30.05.2020.
//  Copyright © 2020 Eugene Ilyin. All rights reserved.
//

import UIKit

class DetailedInfoViewController: UIViewController {

    // MARK: - Properties
    
    var coordinator: PeopleCoordinator?
    var person: Person?
    
    // MARK: - Private properties
    
    private var viewModelReference: DetailedInfoViewModel?
    
    // MARK: - View life cycle
    
    override func loadView() {
        super.loadView()
        
        let view = DetailedInfoView()
        self.view = view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViewModel()
    }
    
    // MARK: - Private methods

    private func setupViewModel() {
        guard let person = person else {
            return
        }
        let viewModel = DetailedInfoViewModel(person: person)
        self.viewModelReference = viewModel
        
        if let view = self.view as? DetailedInfoView {
            view.configure(with: viewModel)
        }
    }
    
}
