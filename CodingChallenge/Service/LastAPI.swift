//
//  LastAPI.swift
//  CodingChallenge
//
//  Created by mac on 3/18/19.
//  Copyright © 2019 mac. All rights reserved.
//

import Foundation

struct LastAPI {
    
    //root url
    static let base = "http://ws.audioscrobbler.com/2.0/"
    
    
    //content url portions
    static let artist = "?method=artist.search&artist="
    static let album = "?method=album.search&album="
    static let track = "?method=track.search&track="
    static let topAlbum = "?method=artist.gettopalbums&artist="
    
    //app key
    static let key = "&api_key=43070dda2f585e51b62ead8380678e67&format=json&limit="
    
    
    //create a function that will put together our url
    static func getArtistURL(search: String, get amount: Int) -> String {
        return base + artist + search + key + "\(amount)"
    }
    
    static func getAlbumURL(search: String, get amount: Int) -> String {
        return base + album + search + key + "\(amount)"
    }
    
    static func getTrackURL(search: String, get amount: Int) -> String {
        return base + track + search + key + "\(amount)"
    }
    
    static func getTopAlbums(search: String) -> String {
        return base + topAlbum + search + key + "\(5)"
    }
    
}
