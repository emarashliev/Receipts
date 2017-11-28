//
//  ReceiptListController.swift
//  Receipts
//
//  Created by Emil Marashliev on 17.11.17.
//  Copyright © 2017 Emil Marashliev. All rights reserved.
//

import UIKit

protocol ReceiptListControllerDelegate: class {
    func didSelect(receipt: ReceiptViewModel)
    func searchViewController() -> SearchViewController?
}

final class ReceiptListController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    weak var delegate: ReceiptListControllerDelegate!
    weak var searchViewControllerDelegate: SearchViewControllerDelegate!
    
    private var difficultyFilter: Difficulty = .any{
        didSet {
            filterTheReceipts()
        }
    }
    
    private var timeFIlter: CookingTime = .any {
        didSet {
            filterTheReceipts()
        }
    }
    
    private var searchText = "" {
        didSet {
            filterTheReceipts()
        }
    }
    
    private var allReceipts = [ReceiptViewModel]()
    private var receiptsToShow = [ReceiptViewModel]() {
        didSet {
            collectionView.reloadData()
        }
    }
    
    private let cellHeight = CGFloat(200)
    private let cellSpacing = CGFloat(10)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Webservice.load(resource: Receipt.all) { [weak self] result in
            if let receipts = result?.map({ ReceiptViewModel(receipt: $0) }) {
                self?.allReceipts = receipts
                self?.receiptsToShow = receipts
            }
        }
        delegate.searchViewController()?.delegate = searchViewControllerDelegate
        delegate.searchViewController()?.searchBar.delegate = self
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
    
    func filterDidSelect(filter: ReceiptFIlter, filterType: FilterType) {
        switch filterType {
        case .difficulty:
            difficultyFilter = filter as? Difficulty ?? .any
        default:
            timeFIlter = filter as? CookingTime ?? .any
        }
    }
    
    private func filterTheReceipts() {
        let searchText = self.searchText.lowercased()
        let filteredReceipts = allReceipts.filter { receipt in
            if difficultyFilter != .any {
                return receipt.difficulty() == difficultyFilter
            }
            return true
            }.filter { receipt in
                if timeFIlter != .any {
                    return receipt.cookingTime() == timeFIlter
                }
                return true
        }
        
        if searchText.count > 0 {
            receiptsToShow = filteredReceipts.filter { receipt  in
                let receiptModel = receipt.receipt
                let ingredientsModel = receiptModel.ingredients
                return receipt.name.lowercased().contains(searchText) ||
                    receiptModel.steps.map { $0.lowercased().contains(searchText) }.contains(true) ||
                    ingredientsModel?.map { $0.name.lowercased().contains(searchText) }.contains(true) ?? false
            }
        } else {
            receiptsToShow = filteredReceipts
        }
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
        let receiptViewModel =  receiptsToShow[indexPath.row]
        cell.title.text = receiptViewModel.name
        cell.ingredients.text = receiptViewModel.numberOfingredients
        cell.minutes.text = receiptViewModel.minutes
        cell.image.image(withURL: receiptViewModel.imageURL)
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
        searchText = textDidChange
    }
}
