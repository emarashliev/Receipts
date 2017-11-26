//
//  ReceiptListController.swift
//  Receipts
//
//  Created by Emil Marashliev on 17.11.17.
//  Copyright © 2017 Emil Marashliev. All rights reserved.
//

import UIKit

final class ReceiptListController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    private lazy var collectionViewDelegate = ReceiptCollectionViewDelegateFlowLayout()
    private var receipts: [Receipt]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Webservice.load(resource: Receipt.all) { [weak self] result in
            self?.receipts = result
            self?.collectionView.reloadData()
        }
        collectionView.dataSource = self
        collectionView.delegate = collectionViewDelegate
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
        return receipts?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let identifier = String(describing: ReceiptCollectionViewCell.self)
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! ReceiptCollectionViewCell
        if let receipt = receipts?[indexPath.row] {
            let receiptViewModel = ReceiptViewModel(receipt: receipt)
            cell.title.text = receiptViewModel.name()
            cell.ingredients.text = receiptViewModel.ingredients()
            cell.minutes.text = receiptViewModel.minutes()
            cell.image.image(withURL: URL(string: receipt.imageURL)!)

        }
        return cell
    }
    
}

