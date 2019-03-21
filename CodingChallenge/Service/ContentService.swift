//
//  ContentService.swift
//  CodingChallenge
//
//  Created by mac on 3/18/19.
//  Copyright © 2019 mac. All rights reserved.
//

import Foundation

typealias ArtistHandler = (Artists) -> Void
typealias AlbumHandler = (Albums) -> Void
typealias TrackHandler = (Tracks) -> Void

typealias ContentHandler = ([Content]) -> Void
typealias TopAlbumHandler = ([TopAlbums]) -> Void

final class ContentService {
    
    //create singleton
    static let shared = ContentService()
    
    private init() {}
    
    
    func getContent(search: String, artist: Int, albums: Int, tracks: Int, completion: @escaping ContentHandler) {
        
        var myContent = [Content]()
        let dispatchGroup = DispatchGroup()
        
        //MARK: Albums
        dispatchGroup.enter()
        
        getAlbums(search: search, limit: albums) { albums in
            //loop through albums
            for album in albums {
                //append album through enum
                myContent.append(.album(album))
            }
            dispatchGroup.leave()
        }
        
        
        //MARK: Artists
    
        dispatchGroup.enter()
        getArtists(search: search, limit: artist) { artists in
            
            for artist in artists {
                myContent.append(.artist(artist))
                
            }
            dispatchGroup.leave()
        }
        
        
        //MARK: Tracks
        
        dispatchGroup.enter()
        getTracks(search: search, limit: tracks) { tracks in
            for track in tracks {
                myContent.append(.track(track))
            }
            
            dispatchGroup.leave()
        }
        
        
        dispatchGroup.notify(queue: .global()) {
            //pass array to completion handler
            completion(myContent)
        }
        
    }
    
    
    //MARK: service call for artist
    
    func getArtists(search: String, limit: Int, completion: @escaping ArtistHandler) {
        
        if let url = URL(string: LastAPI.getArtistURL(search: search, get: limit)) {
            
            //init array of artist
            var artistArray = Artists()
            
            URLSession.shared.dataTask(with: url) { (d, _, e) in
                
                if let error = e {
                    print("Error: \(error)")
                }
                
                if let data = d {
                    
                    do {
                        let responseData = try JSONDecoder().decode(ArtistResults.self, from: data)
                        
                        var name: String!
                        
                        //iterate through our results
                        for artist in responseData.results.artistmatches.artist {
                            
                            name = artist.name
                            
                            //loop through our dictionaries
                            for dictionary in artist.image {
                                //loop for values
                                for value in dictionary.values {
                                    //check if value is equal to large
                                    if value == "large" {
                                        //init artist and append to array
                                        let artist = Artist(name: name, image: [dictionary])
                                        artistArray.append(artist)
                                        
                                    }
                                }
                            }
                        }
                        
                        //pass array to completion
                        completion(artistArray)
                        
                    } catch {
                        
                        print("Error: \(error)")
                        
                    }
                }
                //call resume on task or it will NOT fire
                }.resume()
        }
        
    } // end func
    
    
    
    //MARK: ALBUMS
    
    func getAlbums(search: String, limit: Int, completion: @escaping AlbumHandler) {
        
        if let url = URL(string: LastAPI.getAlbumURL(search: search, get: limit)) {
            
            //init array of artist
            var albumArray = Albums()
            
            URLSession.shared.dataTask(with: url) { (d, _, e) in
                
                if let error = e {
                    print("Error: \(error)")
                }
                
                if let data = d {
                    
                    do {
                        
                        let responseData = try JSONDecoder().decode(AlbumResults.self, from: data)
                        
                        var name: String!
                        var artist: String!
                        
                        //iterate through our results
                        for album in responseData.results.albummatches.album {
                            
                            name = album.name
                            artist = album.artist
                            
                            //loop through our dictionaries
                            for dictionary in album.image {
                                //loop for values
                                for value in dictionary.values {
                                    //check if value is equal to large
                                    if value == "large" {
                                        //init artist and append to array
                                        let album = Album(name: name, artist: artist, image: [dictionary])
                                        albumArray.append(album)
                                    }
                                }
                            }
                        }
                        
                        //pass array to completion
                        completion(albumArray)
                        
                    } catch {
                        
                        print("Error: \(error)")
                        
                    }
                }
                //call resume on task or it will NOT fire
                }.resume()
        }
        
    }
    
    
    
    
    
    //MARK: TRACKS
    
    func getTracks(search: String, limit: Int, completion: @escaping TrackHandler) {
        
        
        if let url = URL(string: LastAPI.getTrackURL(search: search, get: limit)) {
            
            //init array of artist
            var trackArray = Tracks()
            
            URLSession.shared.dataTask(with: url) { (d, _, e) in
                
                if let error = e {
                    print("Error: \(error)")
                }
                
                if let data = d {
                    
                    do {
                        
                        let responseData = try JSONDecoder().decode(TrackResults.self, from: data)
                        
                        var name: String!
                        var artist: String!
                        
                        //iterate through our results
                        for track in responseData.results.trackmatches.track {
                            
                            name = track.name
                            artist = track.artist
                            
                            //loop through our dictionaries
                            for dictionary in track.image {
                                //loop for values
                                for value in dictionary.values {
                                    //check if value is equal to large
                                    if value == "large" {
                                        //init artist and append to array
                                        let track = Track(name: name, artist: artist, image: [dictionary])
                                        trackArray.append(track)
                                    }
                                }
                            }
                        }
                        
                        //pass array to completion
                        completion(trackArray)
                        
                    } catch {
                        
                        print("Error: \(error)")
                        
                        
                    }
                }
                //call resume on task or it will NOT fire
                }.resume()
        }
    }
    
    
    //MARK: TOP ALBUMS
    
    func getTopAlbums(for artist: String, completion: @escaping TopAlbumHandler) {
        
        if let url = URL(string: LastAPI.getTopAlbums(search: artist) ) {
            
            var topAlbumArray = [TopAlbums]()
            
            URLSession.shared.dataTask(with: url) { (d, response, e) in
                
                if let error = e {
                    print(error)
                    completion([])
                }
                
                if let data = d {
                    
                    do {
                        
                        let responseData = try JSONDecoder().decode(TopAlbumsResult.self, from: data)
                        
                        
                        for top in responseData.topalbums.album {
                            
                            var name: String!
                            var imageDict: [[String:String]]!
                            
                            for dictionary in top.image {
                                for value in dictionary.values {
                                    if value == "large" {
                                        //set values for object
                                        imageDict = [dictionary]
                                        name = top.name
                                    }
                                }
                            }
                            //init object and appending to array
                            topAlbumArray.append(TopAlbums(name: name, image: imageDict))
                        }
                        
                        completion(topAlbumArray)
                        
                    } catch {
                        
                        print("Error: \(error)")
                        
                    }
                }
            }.resume()
        
        }
        
    } // end func
    
    
    
    
} // end class
