//
//  Album.swift
//  CodingChallenge
//
//  Created by mac on 3/18/19.
//  Copyright © 2019 mac. All rights reserved.
//

import Foundation

typealias Albums = [Album]

struct AlbumResults: Codable {
    let results: AlbumMatches
}

struct AlbumMatches: Codable {
    let albummatches: AlbumInfo
}


struct AlbumInfo: Codable {
    let album: Albums
}


class Album: Codable {
    
    var name: String
    var artist: String
    var image: [[String:String]]
    
    init(name: String, artist: String, image: [[String:String]]) {
        self.name = name
        self.artist = artist
        self.image = image
    }
}
