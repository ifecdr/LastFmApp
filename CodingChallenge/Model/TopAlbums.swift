//
//  TopAlbums.swift
//  CodingChallenge
//
//  Created by mac on 3/20/19.
//  Copyright © 2019 mac. All rights reserved.
//

import Foundation


struct TopAlbumsResult: Codable {
    var topalbums: AlbumsDetail
}

struct AlbumsDetail: Codable {
    var album: [TopAlbums]
}

class TopAlbums: Codable {
    
    var name: String
    var image: [[String:String]]
    
    init(name: String, image: [[String:String]]) {
        self.name = name
        self.image = image
    }
}
