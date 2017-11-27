//
//  ReceiptListController.swift
//  Receipts
//
//  Created by Emil Marashliev on 17.11.17.
//  Copyright © 2017 Emil Marashliev. All rights reserved.
//

import UIKit

protocol ReceiptListControllerDelegate: class {
    func didSelect(receipt: Receipt)
    func popOverViewController() -> PopOverViewController
}

final class ReceiptListController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    weak var delegate: ReceiptListControllerDelegate!
    
    private var allReceipts = [Receipt]()
    private var receiptsToShow = [Receipt]() {
        didSet {
            self.collectionView.reloadData()
        }
    }
    
    private let cellHeight = CGFloat(200)
    private let cellSpacing = CGFloat(10)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Webservice.load(resource: Receipt.all) { [weak self] result in
            self?.allReceipts = result ?? [Receipt]()
            self?.receiptsToShow = result ?? [Receipt]()
        }
        
        if let searchViewController = childViewControllers.first as? SearchViewController {
            searchViewController.popOverViewController = delegate.popOverViewController()
            searchViewController.searchBar.delegate = self
        }
        
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.isNavigationBarHidden = false
    }
}

// MARK: - UICollectionViewDataSource
extension ReceiptListController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return receiptsToShow.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let identifier = String(describing: ReceiptCollectionViewCell.self)
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! ReceiptCollectionViewCell
        let receiptViewModel = ReceiptViewModel(receipt: receiptsToShow[indexPath.row])
        cell.title.text = receiptViewModel.name()
        cell.ingredients.text = receiptViewModel.ingredients()
        cell.minutes.text = receiptViewModel.minutes()
        cell.image.image(withURL: receiptViewModel.imageURL())
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension ReceiptListController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.bounds.size.width / 2) - (cellSpacing / 2), height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return cellSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate.didSelect(receipt: receiptsToShow[indexPath.row])
    }
}

// MARK: - UISearchBarDelegate
extension ReceiptListController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange: String) {
        if textDidChange.count > 0 {
            let searchText = textDidChange.lowercased()
            receiptsToShow = allReceipts.filter { receipt  in
                let ingredients = receipt.ingredients ?? [Ingredient]()
                return receipt.name.lowercased().contains(searchText) ||
                    receipt.steps.map { $0.lowercased().contains(searchText) }.contains(true) ||
                    ingredients.map { $0.name.lowercased().contains(searchText) }.contains(true)
            }
        } else {
            receiptsToShow = allReceipts
        }
    }
    
}

