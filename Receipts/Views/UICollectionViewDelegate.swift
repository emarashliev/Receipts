//
//  ReceiptCollectionViewDelegateFlowLayout.swift
//  Receipts
//
//  Created by Emil Marashliev on 25.11.17.
//  Copyright © 2017 Emil Marashliev. All rights reserved.
//

import UIKit

final class ReceiptCollectionViewDelegateFlowLayout: NSObject, UICollectionViewDelegateFlowLayout {
    
    private let cellHeight = CGFloat(200)
    private let cellSpacing = CGFloat(10)
    
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
}
