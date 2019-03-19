//
//  Artist.swift
//  CodingChallenge
//
//  Created by mac on 3/18/19.
//  Copyright © 2019 mac. All rights reserved.
//

import Foundation

typealias Artists = [Artist]

struct ArtistResults: Codable {
    let results: ArtistMatches
}

struct ArtistMatches: Codable {
    let artistmatches: ArtistInfo
}

struct ArtistInfo: Codable {
    let artist: Artists
}

class Artist: Codable {
    var name: String
    var image: [[String:String]]
    
    init(name: String, image: [[String:String]]) {
        self.name = name
        self.image = image
    }
}
