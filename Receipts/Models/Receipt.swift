//
//  Receipt.swift
//  Receipts
//
//  Created by Emil Marashliev on 26.11.17.
//  Copyright © 2017 Emil Marashliev. All rights reserved.
//

import Foundation

private let receiptsUrl = URL(string: "https://mobile.asosservices.com/sampleapifortest/recipes.json")!

struct Receipt: Decodable {
    var name: String
    var steps: [String]
    var timers: [Int]
    var imageURL: String
    var ingredients: [Ingredient]?
}

extension Receipt {
    static let all = Resource<[Receipt]>(url: receiptsUrl, parseJSON: { json in
        let decoder = JSONDecoder()
        return json.flatMap { receiptJson in
            guard let data = try? receiptJson.rawData() else { return nil }
            return try? decoder.decode(Receipt.self, from: data)
        }
    })
}
