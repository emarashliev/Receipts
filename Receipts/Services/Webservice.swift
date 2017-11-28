//
//  Webservice.swift
//  Receipts
//
//  Created by Emil Marashliev on 26.11.17.
//  Copyright © 2017 Emil Marashliev. All rights reserved.
//

import SwiftyJSON

final class Webservice {
    
    static func load<T>(resource: Resource<T>, completion: @escaping (T?) -> ()) {
        if isExpired() {
            URLCache.shared.removeAllCachedResponses()
            anHourSinceNow()
        }
        var request = URLRequest(url: resource.url)
        request.cachePolicy = .returnCacheDataElseLoad
        URLSession.shared.dataTask(with: request) { data, response, error  in
            guard let data = data else {
                print(error ?? "")
                DispatchQueue.main.async { completion(nil) }
                return
            }
            let result = resource.parse(data, response)
            DispatchQueue.main.async { completion(result) }
            }.resume()
    }
    
    private static func anHourSinceNow() {
        let anHourSinceNow = Date(timeIntervalSinceNow: 3600).timeIntervalSince1970
        UserDefaults.standard.set(anHourSinceNow, forKey: "anHourSinceNow")
    }
    
    private static func isExpired() -> Bool {
        guard let anHour = UserDefaults.standard.value(forKey: "anHourSinceNow") as? TimeInterval else {
            anHourSinceNow()
            return false
        }
        return anHour < Date().timeIntervalSince1970
    }

    
    
}


struct Resource<T> {
    let url: URL
    let parse: (Data, URLResponse?) -> T?
    
    init(url: URL, parseJSON: @escaping ([JSON]) -> T?) {
        self.url = url
        self.parse = { data, _ in
            return parseJSON(JSON(data).arrayValue)
        }
    }
    
    init(url: URL, parseData: @escaping (Data, URLResponse?) -> T?) {
        self.url = url
        self.parse = { data, response in
            return parseData(data, response)
        }
    }
}

