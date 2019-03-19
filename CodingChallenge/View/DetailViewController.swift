//
//  DetailViewController.swift
//  CodingChallenge
//
//  Created by mac on 3/19/19.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var subLabel: UILabel!
    
    var content = Content.empty

    override func viewDidLoad() {
        super.viewDidLoad()
        
        contentToObject()

    }
    
    func contentToObject() {
        
        switch content {
            
        case .artist(let artist):
            configure(artist: nil, name: artist.name, image: artist.image)
        case .album(let album):
            configure(artist: album.artist, name: album.name, image: album.image)
        case .track(let track):
            configure(artist: track.artist, name: track.name, image: track.image)
            
        default:
            break
        }
    }
    
    
    func configure(artist: String?, name: String, image: [[String:String]]) {
        mainLabel.text = name
        
        if let artistName = artist {
            subLabel.text = artistName
        }
        
        for dictionary in image where dictionary.values.contains(where: {$0.contains("large")}) {
            
            let url = URL(string: dictionary.values.first!)
            
            guard let data = try? Data(contentsOf: url!) else {
                return
            }
            
            let imageData = UIImage(data: data)
            
            print(Thread.isMainThread)
            
            mainImage.image = imageData
            
        }
    }
    



}
