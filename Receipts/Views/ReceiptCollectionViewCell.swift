//
//  ReceiptCollectionViewCell.swift
//  Receipts
//
//  Created by Emil Marashliev on 20.11.17.
//  Copyright © 2017 Emil Marashliev. All rights reserved.
//

import UIKit

final class ReceiptCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var ingredients: UILabel!
    @IBOutlet weak var minutes: UILabel!
    
    
    func setImage(data: Data) {
        guard let cgImage = UIImage(data: data)?.cgImage else { return }
        
        let width = cgImage.width / 2
        let height = cgImage.height / 2
        let bitsPerComponent = cgImage.bitsPerComponent
        let bytesPerRow = cgImage.bytesPerRow
        let colorSpace = cgImage.colorSpace
        let bitmapInfo = cgImage.bitmapInfo
        
        let context = CGContext(data: nil, width: width,
                                height: height,
                                bitsPerComponent: bitsPerComponent,
                                bytesPerRow: bytesPerRow,
                                space: colorSpace!,
                                bitmapInfo: bitmapInfo.rawValue)
        
        context?.interpolationQuality = .medium
        
        let rect = CGRect(origin: CGPoint.zero, size: CGSize(width: CGFloat(width), height: CGFloat(height)))
        context?.draw(cgImage, in: rect)
        
        let scaledImage = context?.makeImage().flatMap { UIImage(cgImage: $0) }
        image.image = scaledImage
    }
}
