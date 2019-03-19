//
//  Track.swift
//  CodingChallenge
//
//  Created by mac on 3/18/19.
//  Copyright © 2019 mac. All rights reserved.
//

import Foundation

typealias Tracks = [Track]

struct TrackResults: Codable {
    var results: TrackMatches
}

struct TrackMatches: Codable {
    var trackmatches: TrackInfo
}

struct TrackInfo: Codable {
    var track: Tracks
}

class Track: Codable {
    
    var name: String
    var artist: String
    var image: [[String:String]]
    
    init(name: String, artist: String, image: [[String:String]]) {
        
        self.name = name
        self.artist = artist
        self.image = image
        
    }
    
}
