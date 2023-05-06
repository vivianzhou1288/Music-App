//
//  Song.swift
//  Music App
//
//  Created by Vivian Zhou on 4/29/23.
//

import Foundation
import UIKit

struct Song: Codable {
    var id: Int
    var name: String
    var description: String
    var artistname: String
    var song_link: String
    var image: [Image]
    var asURL: Bool? = false

//    init(id: Int, name: String, description: String, artistname: String, song_link: String, image: [String]) {
//        self.image = image
//        self.name = name
//        self.description = description
//        self.artistname = artistname
//    }
}

struct SongResponse: Codable {
    var songs: [Song]
}
