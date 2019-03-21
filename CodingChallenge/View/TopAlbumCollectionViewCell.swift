//
//  TopAlbumCollectionViewCell.swift
//  CodingChallenge
//
//  Created by mac on 3/20/19.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit

class TopAlbumCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var mainImage: UIImageView!
    
    @IBOutlet weak var mainLabel: UILabel!
    
    
    static let identifier = "TopAlbum"
    
    func configure(top: TopAlbums) {
        mainLabel.text = top.name
        
        for image in top.image where image.values.contains(where: {$0.contains("large")}) {
            
            if let url = URL(string: image.values.first!) {
                //optional binding to receive data from url
                guard let data = try? Data(contentsOf: url) else {
                    return
                }
                //transform image data to image
                let imageData = UIImage(data: data)
                
                //update UI on main thread ONLY
                DispatchQueue.main.async {
                    self.mainImage.image = imageData
                }
            }
        }
    }
    
    
}
