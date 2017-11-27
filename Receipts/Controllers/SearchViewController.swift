//
//  SearchViewController.swift
//  Receipts
//
//  Created by Emil Marashliev on 24.11.17.
//  Copyright © 2017 Emil Marashliev. All rights reserved.
//

import UIKit

protocol SearchViewControllerDelegate: class {
    func showPopOverViewController(with sourceView: UIView)
}

final class SearchViewController: UIViewController {
    
    weak var delegate: SearchViewControllerDelegate!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func difficultyButtonPressed(_ sender: UIButton) {
        delegate.showPopOverViewController(with: sender)
    }
    
    @IBAction func timeButtonPressed(_ sender: UIButton) {
        delegate.showPopOverViewController(with: sender)
    }
    
}
