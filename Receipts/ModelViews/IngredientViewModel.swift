//
//  IngredientViewModel.swift
//  Receipts
//
//  Created by Emil Marashliev on 26.11.17.
//  Copyright © 2017 Emil Marashliev. All rights reserved.
//

import Foundation

struct IngredientViewModel {
    
    let ingredient: Ingredient
    
    func item(number: Int) -> String {
        return "Item #\(number) \(ingredient.name)"
    }
    
    func quantity() -> String {
        return ingredient.quantity
    }
}
