//
//  ViewModel.swift
//  CodingChallenge
//
//  Created by mac on 3/18/19.
//  Copyright © 2019 mac. All rights reserved.
//

import Foundation

protocol ViewModelDelegate: class {
    func updateView()
}

class ViewModel {
    
    var content = [Content]()
    
    var albums = Albums()
    var artists = Artists()
    var tracks = Tracks()
    
    weak var delegate: ViewModelDelegate?
    
    //MARK: Content Limits
    var artistLimit = 5
    var albumLimit = 5
    var trackLimit = 10
    
    //MARK: Content
    func updateLimits() {
        
        
        artistLimit += 5
        albumLimit += 5
        trackLimit += 5
        
    }
    
    func resetLimits() {
        
        artistLimit = 5
        albumLimit = 5
        trackLimit = 10
        
    }
    
    
    var isLoadingMore: Bool {
        if artistLimit + albumLimit + trackLimit < 50 {
            return true
        }
        
        return false
    }
    
    
    func getContent(with search: String) {
        
        ContentService.shared.getContent(search: search, artist: artistLimit, albums: albumLimit, tracks: trackLimit) { [unowned self] content in
            
            self.content = content
            self.updateData()
            self.delegate?.updateView()
            
            print("Received Content: \(self.content.count)")
        }
    }
    
    func updateData() {
        //iterate through content
        
        artists = []
        albums = []
        tracks = []
        
        
        for item in content {
            //check the type of item
            switch item {
                //use let "item name" to create variable
            case .album(let album):
                //append the item to its own array
                albums.append(album)
                
            case .artist(let artist):
                
                artists.append(artist)
                
            case .track(let track):
                
                tracks.append(track)
                
            default:
                break
            }
        }
    }
} // end class
