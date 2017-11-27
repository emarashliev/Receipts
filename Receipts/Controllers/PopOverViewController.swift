//
//  PopOverViewController.swift
//  Receipts
//
//  Created by Emil Marashliev on 24.11.17.
//  Copyright © 2017 Emil Marashliev. All rights reserved.
//

import UIKit

protocol PopOverViewControllerDelegate: class {
    func applyFIlter(filter: ReceiptFIlter, filterType: FilterType)
}

final class PopOverViewController: UIViewController {
    
    var filterType: FilterType!
    
    weak var deledate: PopOverViewControllerDelegate!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        tableView.dataSource = self
        tableView.delegate = self
    }
}

extension PopOverViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch filterType {
        case .difficulty:
            return Difficulty.allValues.count
        default:
            return CookingTime.allValues.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = String(describing: FilterTableViewCell.self)
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! FilterTableViewCell
        switch filterType {
        case .difficulty:
            cell.title.text = Difficulty.allValues[indexPath.row].rawValue
        default:
            cell.title.text = CookingTime.allValues[indexPath.row].rawValue
        }
        return cell
    }
}

extension PopOverViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(30)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch filterType {
        case .difficulty:
            deledate.applyFIlter(filter: Difficulty.allValues[indexPath.row], filterType: filterType)
        default:
            deledate.applyFIlter(filter: CookingTime.allValues[indexPath.row], filterType: filterType)
        }
        
    }
}
