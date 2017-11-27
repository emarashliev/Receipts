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
    
    init(ingredient: Ingredient) {
        self.ingredient = ingredient
    }
    
    var quantity: String {
        return ingredient.quantity
    }
    
    func item(number: Int) -> String {
        return "Item #\(number) \(ingredient.name)"
    }
    
}
