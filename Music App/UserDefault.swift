//
//  UserDefault.swift
//  Music App
//
//  Created by Vivian Zhou on 5/4/23.
//

import Foundation

public class UserDefault {
    
    let key = "SongKey"
    
    func saveData(song: [Song]) {
        do{
            let encodedSonglist = try JSONEncoder().encode(song)
            UserDefaults.standard.set(encodedSonglist, forKey: key)
        }
        catch{
            print("Unable")
        }
    }
    
    func getData() -> [Song]{
        if let data = UserDefaults.standard.data(forKey: key){
            do{
                let decodedSonglist = try JSONDecoder().decode([Song].self, from: data)
                let songs: [Song] = decodedSonglist
                return songs
            }catch{
                print("Unable")
            }
        }
        return []
    }
    
}
