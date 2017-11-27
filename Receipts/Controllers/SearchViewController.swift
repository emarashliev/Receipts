//
//  SearchViewController.swift
//  Receipts
//
//  Created by Emil Marashliev on 24.11.17.
//  Copyright © 2017 Emil Marashliev. All rights reserved.
//

import UIKit

final class SearchViewController: UIViewController, UIPopoverPresentationControllerDelegate {
    
    var popOverViewController: PopOverViewController?
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func easyPressed(_ sender: Any) {
        guard let popOverViewController = self.popOverViewController else { return }
        popOverViewController.preferredContentSize = CGSize(width: UIScreen.main.bounds.width, height: 100)
        popOverViewController.modalPresentationStyle = .popover
        let popover = popOverViewController.popoverPresentationController!
        popover.delegate = self
        popover.permittedArrowDirections = .up
        
        popover.sourceView = sender as? UIView
        popover.sourceRect = (sender as! UIView).bounds
        
        present(popOverViewController, animated: true)
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController,
                                   traitCollection: UITraitCollection) -> UIModalPresentationStyle {
        return .none
    }
}
