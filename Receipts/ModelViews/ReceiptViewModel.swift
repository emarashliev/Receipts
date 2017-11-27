//
//  ReceiptViewModel.swift
//  Receipts
//
//  Created by Emil Marashliev on 26.11.17.
//  Copyright © 2017 Emil Marashliev. All rights reserved.
//

import Foundation

protocol ReceiptFIlter {}

enum Difficulty: String, ReceiptFIlter {
    case any = "Any", easy = "Easy", medium = "Medium", hard = "Hard"
    
    static let allValues = [Difficulty.any, .easy, .medium, .hard]
}

enum CookingTime: String, ReceiptFIlter {
    case any = "Any", fast = "0-10min", medium = "10-20min", slow = "20+min"
    
    static let allValues = [CookingTime.any, .fast, .medium, .slow]
}

enum FilterType {
    case difficulty
    case cookingTime
}

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
    
    func difficulty() -> Difficulty {
        switch receipt.steps.count {
        case 0...4:
            return Difficulty.easy
        case 5...8:
            return Difficulty.medium
        default:
            return Difficulty.hard
        }
    }
    
    func cookingTime() -> CookingTime {
        switch receipt.timers.reduce(0, +) {
        case 0...10:
            return CookingTime.fast
        case 11...20:
            return CookingTime.medium
        default:
            return CookingTime.slow
        }
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
