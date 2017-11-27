//
//  SearchViewController.swift
//  Receipts
//
//  Created by Emil Marashliev on 24.11.17.
//  Copyright © 2017 Emil Marashliev. All rights reserved.
//

import UIKit

protocol SearchViewControllerDelegate: class {
    func showPopOverViewController(with sourceView: UIView, and type: FilterType)
}

final class SearchViewController: UIViewController {
    
    weak var delegate: SearchViewControllerDelegate!
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var difficultyButton: UIButton!
    @IBOutlet weak var timeButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func difficultyButtonPressed(_ sender: UIButton) {
        delegate.showPopOverViewController(with: sender, and: .difficulty)
    }
    
    @IBAction func timeButtonPressed(_ sender: UIButton) {
        delegate.showPopOverViewController(with: sender,and: .cookingTime)
    }
    
    func filterDidSelect(filter: ReceiptFIlter, filterType: FilterType) {
        switch filterType {
        case .difficulty:
            difficultyButton.setTitle((filter as! Difficulty).rawValue, for: .normal)
        default:
            timeButton.setTitle((filter as! CookingTime).rawValue, for: .normal)
        }
    }
}
