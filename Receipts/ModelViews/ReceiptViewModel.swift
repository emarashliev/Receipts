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
    
    func ingredientsSectionTitle() -> String {
        let count = receipt.ingredients?.count ?? 0
        return "Ingredients \(count)"
    }
    
    func minutes() -> String {
        return "\(receipt.timers.reduce(0, +)) minutes"
    }
    
    func imageURL() -> URL? {
        return URL(string: receipt.imageURL)
    }
    
    func ingredientViewModel(at index: Int) -> IngredientViewModel? {
        guard let ingredients = receipt.ingredients,
            ingredients.indices.contains(index) else { return nil }
        return IngredientViewModel(ingredient: ingredients[index])
    }
    
    func step(at index: Int) -> String? {
        guard receipt.steps.indices.contains(index) else { return nil }
        let step = receipt.steps[index]
        return " Step #\(index + 1) \(step)"
    }
}
