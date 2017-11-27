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
    
    init(receipt: Receipt) {
        self.receipt = receipt
    }
    
    private(set) lazy var ingredientViewModels = {
        receipt.ingredients?.map { IngredientViewModel(ingredient: $0) } ?? [IngredientViewModel]()
    }()
    
    
    var name: String {
        return receipt.name
    }
    
    var numberOfingredients: String {
        
        let count = receipt.ingredients?.count ?? 0
        return "\(count) ingredients"
    }
    
    var ingredientsSectionTitle: String {
        let count = receipt.ingredients?.count ?? 0
        return "Ingredients \(count)"
    }
    
    var minutes: String {
        return "\(receipt.timers.reduce(0, +)) minutes"
    }
    
    var steps: [String] {
        return receipt.steps
    }
    
    var imageURL: URL? {
        return URL(string: receipt.imageURL)
    }
    
    mutating func ingredientViewModel(at index: Int) -> IngredientViewModel? {
        guard ingredientViewModels.indices.contains(index) else { return nil }
        return ingredientViewModels[index]
    }
    
    func step(at index: Int) -> String? {
        guard receipt.steps.indices.contains(index) else { return nil }
        let step = receipt.steps[index]
        return " Step #\(index + 1) \(step)"
    }
}
