//
//  CustomTableViewCell.swift
//  Music App
//
//  Created by Vivian Zhou on 4/29/23.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
    let songPic = UIImageView()
    let name = UILabel()
    let artist = UILabel()
    let artistLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = .black
        
        songPic.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(songPic)
        
        name.translatesAutoresizingMaskIntoConstraints = false
        name.font = UIFont(name: "HelveticaNeue-Bold", size: 15)
        name.textColor = .white
        self.contentView.addSubview(name)
        
        artist.translatesAutoresizingMaskIntoConstraints = false
        artist.font = UIFont.systemFont(ofSize: 10)
        artist.textColor = .lightGray
        self.contentView.addSubview(artist)
        
        artistLabel.translatesAutoresizingMaskIntoConstraints = false
        artistLabel.text = "Artist: "
        artistLabel.font = UIFont.systemFont(ofSize: 10)
        artistLabel.textColor = .lightGray
        self.contentView.addSubview(artistLabel)
        
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpConstraints(){
        NSLayoutConstraint.activate([
            songPic.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 20),
            songPic.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 10),
            songPic.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
            songPic.widthAnchor.constraint(equalTo: self.contentView.widthAnchor, multiplier: 0.27),
            songPic.heightAnchor.constraint(equalTo: songPic.widthAnchor)
        ])
        
        
        NSLayoutConstraint.activate([
            name.topAnchor.constraint(equalTo: songPic.topAnchor, constant: 25),
            name.leadingAnchor.constraint(equalTo: songPic.trailingAnchor, constant: 30),
        ])
        
        NSLayoutConstraint.activate([
            artistLabel.leadingAnchor.constraint(equalTo: songPic.trailingAnchor, constant: 30),
            artistLabel.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 10)
        ])
        
        NSLayoutConstraint.activate([
            artist.leadingAnchor.constraint(equalTo: artistLabel.trailingAnchor, constant: 2),
            artist.topAnchor.constraint(equalTo: artistLabel.topAnchor),
        ])
    }
    
    func updateFrom(song: Song){
        name.text = song.name
        if !song.image.isEmpty{
            
            if let a = song.asURL, a{
                print("it works")
                if let dataDecoded: Data = Data(base64Encoded: song.image[0].url, options: .ignoreUnknownCharacters){
                    songPic.image = UIImage(data: dataDecoded)
                }
            }
            else{
                let url = URL(string: song.image[0].url)
                
                DispatchQueue.global().async{
                    if let data = try? Data(contentsOf: url!){
                        DispatchQueue.main.async { [weak self] in
                            self?.songPic.image = UIImage(data: data)
                        }
                    }
                }
                
            }
            
            
        } else {
            songPic.image = UIImage()
        }
            artist.text = song.artistname
            
    }
        
}

