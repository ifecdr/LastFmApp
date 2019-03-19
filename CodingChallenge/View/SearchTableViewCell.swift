//
//  SearchTableViewCell.swift
//  CodingChallenge
//
//  Created by mac on 3/18/19.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit

class SearchTableViewCell: UITableViewCell {

    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var subTitle: UILabel!
    
    static let identifier = "CellID"
    
    override func prepareForReuse() {
        mainImage.image = nil
    }
    
    //MARK: Artist
    
    func configureArtist(artist: Artist) {
        title.text = artist.name
        subTitle.isHidden = true
        
        //iterate through array of dictionarys and get value that contains key of "large"
        for image in artist.image where image.values.contains(where: {$0.contains("large")}) {
            
            let url = URL(string: image.values.first!)!
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
    } // end func
    
    
    
    
    //MARK: Albums
    
    func configureAlbum(album: Album) {
        
        title.text = album.name
        subTitle.text = album.artist
        
        //iterate through array of dictionarys and get value that contains key of "large"
        for image in album.image where image.values.contains(where: {$0.contains("large")}) {
            
            let url = URL(string: image.values.first!)!
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
    
    
    //MARK: Track
    func configureTrack(track: Track) {
        
        title.text = track.name
        subTitle.text = track.artist
        
        //iterate through array of dictionarys and get value that contains key of "large"
        for image in track.image where image.values.contains(where: {$0.contains("large")}) {
            
            let url = URL(string: image.values.first!)!
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
    
    

} // end class
