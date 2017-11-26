//
//  File.swift
//  Receipts
//
//  Created by Emil Marashliev on 26.11.17.
//  Copyright © 2017 Emil Marashliev. All rights reserved.
//

import Foundation

struct Ingredient: Decodable {
    
    var quantity: String
    var name: String
    var type: String
}
