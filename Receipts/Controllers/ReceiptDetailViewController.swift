//
//  ReceiptDetailViewController.swift
//  Receipts
//
//  Created by Emil Marashliev on 25.11.17.
//  Copyright © 2017 Emil Marashliev. All rights reserved.
//

import UIKit

final class ReceiptDetailViewController: UIViewController {
    
    var receiptViewModel: ReceiptViewModel!

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var image: UIImageView!
    
    private enum Sections: Int {
        case ingredients = 0
        case steps = 1
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        image.image(withURL: receiptViewModel.imageURL)
    }
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.topItem?.backBarButtonItem =
            UIBarButtonItem(title: "", style: .plain, target: self, action: #selector(back))
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.view.backgroundColor = .clear
    }
    
    @objc
    func back() {
        navigationController?.popViewController(animated: true)
    }
    
}

extension ReceiptDetailViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case Sections.ingredients.rawValue:
            return receiptViewModel.receipt.ingredients?.count ?? 0
        case Sections.steps.rawValue:
            return receiptViewModel.receipt.steps.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case Sections.ingredients.rawValue:
            return receiptViewModel.ingredientsSectionTitle
        case Sections.steps.rawValue:
            return "Instructions"
        default:
            return ""
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case Sections.ingredients.rawValue:
            guard let ingredientViewModel = receiptViewModel.ingredientViewModel(at: indexPath.row) else { fallthrough }
            let identifier = String(describing: IngredientsTableViewCell.self)
            let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
                as! IngredientsTableViewCell
            cell.item.text = ingredientViewModel.item(number: indexPath.row + 1)
            cell.quantity.text = ingredientViewModel.quantity
            return cell
        case Sections.steps.rawValue:
            let identifier = String(describing: InstructionTableViewCell.self)
            let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
                as! InstructionTableViewCell
            cell.stepDescription.text = receiptViewModel.step(at: indexPath.row) ?? ""
            return cell
        default:
            return UITableViewCell()
        }
    }
}


