//
//  NetworkManager.swift
//  Music App
//
//  Created by Vivian Zhou on 5/4/23.
//

import Foundation

class NetworkManager {

    static let shared = NetworkManager()

    var url = URL(string: "http://35.245.120.104/music/")!
    var url2 = URL(string: "http://35.245.120.104/create/song/")!
    
    func getAllSongs(completion: @escaping ([Song]) -> Void) {
        //TODO: Get all Messages
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { data, response, err in
            if let data = data {
                print(data)
                do {
                    let decoder = JSONDecoder()
                    let response = try decoder.decode(SongResponse.self, from: data)
                    completion(response.songs)
                }
                catch (let error){
                    print(error.localizedDescription)
                }
            }
        }
        task.resume()

    }
    
    func createSong(name: String, description: String, artistname: String, song_link: String, image: [Image], completion: @escaping (Song) -> Void) {
        
        
        var request = URLRequest(url: url2)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let name: [String: Any] = [
            "name": name,
            "description": description,
            "artistname": artistname,
            "song_link": song_link
        ]
        
        request.httpBody = try? JSONSerialization.data(withJSONObject: name, options: .fragmentsAllowed)
        let task = URLSession.shared.dataTask(with: request) { data, response, err in
            print(response)
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let response = try decoder.decode(Song.self, from: data)
                    completion(response)
                }
                catch (let error) {
                    print(error.localizedDescription)
                }
            }
        
        }
        task.resume()
    }
    
    func createImage(id: Int, image: String, completion: @escaping (Song) -> Void){
        
        var url3 = URL(string: "http://35.245.120.104/image/\(id)/song/")!
        
        var request = URLRequest(url: url3)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let image: [String: Any] = [
            "image_data": image
            
        ]
        print(image)
        request.httpBody = try? JSONSerialization.data(withJSONObject: image, options: .fragmentsAllowed)
        let task = URLSession.shared.dataTask(with: request) { data, response, err in
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let response = try decoder.decode(Song.self, from: data)
                    completion(response)
                }
                catch (let error) {
                    print(error.localizedDescription)
                }
            }
        
        }
        task.resume()
    }
}
