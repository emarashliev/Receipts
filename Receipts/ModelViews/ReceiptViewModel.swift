//
//  ReceiptViewModel.swift
//  Receipts
//
//  Created by Emil Marashliev on 26.11.17.
//  Copyright © 2017 Emil Marashliev. All rights reserved.
//

import Foundation

struct ReceiptViewModel {
    
    let receipt: Receipt
    
    func name() -> String {
        return receipt.name
    }
    
    func ingredients() -> String {
        let count = receipt.ingredients?.count ?? 0
        return "\(count) ingredients"
    }
    
    func minutes() -> String {
        return "\(receipt.timers.reduce(0, +)) minutes"
    }
}
