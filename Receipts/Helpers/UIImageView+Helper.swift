//
//  UIImageView+Helper.swift
//  Receipts
//
//  Created by Emil Marashliev on 26.11.17.
//  Copyright © 2017 Emil Marashliev. All rights reserved.
//

import UIKit

extension UIImageView {

    func image(withURL url: URL, and placeholder: UIImage = #imageLiteral(resourceName: "Placeholder1")) {
        let  size = self.frame.size
        self.image = placeholder.scale(toFit: size)
        let resource = Resource<UIImage?>(url: url, parseData: { data in
            guard data.count > 200 else { return nil }
            let image = UIImage(data: data)?.scale(toFit: size)
            return image
        })
        
        Webservice.load(resource: resource) { [weak self] image in
            if let image = image {
                self?.image = image
            }
        }
    }
}
