//
//  UIImageView+Helper.swift
//  Receipts
//
//  Created by Emil Marashliev on 26.11.17.
//  Copyright © 2017 Emil Marashliev. All rights reserved.
//

import UIKit

extension UIImageView {

    func image(withURL url: URL?, and placeholder: UIImage = #imageLiteral(resourceName: "Placeholder1")) {
        let  size = self.frame.size
        image = placeholder.scale(toFit: size)
        guard let url = url else { return }
        let resource = Resource<UIImage?>(url: url, parseData: { [unowned self] data, response in
            guard self.validateImage(response: response) else { return nil }
            let image = UIImage(data: data)?.scale(toFit: size)
            return image
        })
        
        Webservice.load(resource: resource) { [weak self] image in
            if let image = image {
                self?.image = image
            }
        }
    }
    
    private func validateImage(response: URLResponse?) -> Bool {
        if let httpResponse = response as? HTTPURLResponse,
            let contentType = httpResponse.allHeaderFields["Content-Type"] as? String,
            let contentLengthString = httpResponse.allHeaderFields["Content-Length"] as? String,
            let contentLength = Int(contentLengthString) {
            
            return contentType.contains("image") && contentLength > 200
        }
        return false
    }
}
