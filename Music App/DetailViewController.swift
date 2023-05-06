//
//  DetailViewController.swift
//  Music App
//
//  Created by Vivian Zhou on 4/29/23.
//

import UIKit
import AVFoundation

class DetailViewController: UIViewController {

    let picImageView = UIImageView()
    let nameLabel = UILabel()
    let nameTextLabel = UITextField()
    let descLabel = UILabel()
    let descTextLabel = UITextView()
    let artistLabel = UILabel()
    let artistTextLabel = UITextField()
    let userDefault = UserDefault()
//    let submitButton = UIButton()
    let playButton = UIButton()
    var player = AVPlayer()
    var played = 0
    

    weak var del: updateCell?
    let song: Song
    

    init(song: Song) {
        self.song = song
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black

        title = "Song"
        let whiteTextAttribute = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = whiteTextAttribute
        view.backgroundColor = .black
        
        let url = URL(string: "https://s3.amazonaws.com/kargopolov/kukushka.mp3")
        let playerItem:AVPlayerItem = AVPlayerItem(url: url!)
        player = AVPlayer(playerItem: playerItem)
        let playerLayer=AVPlayerLayer(player: player)
        playerLayer.frame=CGRect(x:0, y:0, width:10, height:50)
        self.view.layer.addSublayer(playerLayer)
        
        
//        picImageView.image = UIImage(named: song.image[0].url)
//        print(song.image[0].url)
        if !song.image.isEmpty{
            picImageView.load(urlString: song.image[0].url)
        }
        picImageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(picImageView)
        
        nameLabel.text = "Song:"
        nameLabel.font = .systemFont(ofSize: 20)
        nameLabel.textColor = .white
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(nameLabel)

        nameTextLabel.text = song.name
        nameTextLabel.font = .systemFont(ofSize: 20)
        nameTextLabel.backgroundColor = .black
        nameTextLabel.textColor = .white
        nameTextLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(nameTextLabel)
        
        artistLabel.text = "Artist:"
        artistLabel.font = .systemFont(ofSize: 20)
        artistLabel.textColor = .white
        artistLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(artistLabel)
        
        artistTextLabel.text = song.artistname
        artistTextLabel.font = .systemFont(ofSize: 20)
        artistTextLabel.textColor = .white
        artistTextLabel.textAlignment = .center
        artistTextLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(artistTextLabel)
        
        descLabel.text = "Description:"
        descLabel.font = .systemFont(ofSize: 20)
        descLabel.textColor = .white
        descLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(descLabel)
        
        descTextLabel.text = song.description
        descTextLabel.font = .systemFont(ofSize: 20)
        descTextLabel.textColor = .white
        descTextLabel.textAlignment = .center
        descTextLabel.backgroundColor = .black
        descTextLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(descTextLabel)
        
        
        playButton.setImage(UIImage(named: "play"), for: .normal)
        playButton.addTarget(self, action: #selector(clickedPlay), for: .touchUpInside)
        playButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(playButton)
        playButton.tag = 0

//        submitButton.setTitle("Submit", for: .normal)
//        submitButton.setTitleColor(.white, for: .normal)
//        submitButton.addTarget(self, action: #selector(changeSongCell), for: .touchUpInside)
//        submitButton.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(submitButton)

        setupConstraints()
    }

//    @objc func changeSongCell() {
//        navigationController?.popViewController(animated: true)
//        if let text1 = nameTextField.text, let text2 = albumTextField.text, let text3 = artistTextField.text{
//            del?.updateName(name: text1, album: text2, artist: text3)
//        }
//    }
    
    @objc func clickedPlay(sender: UIButton){
        print(played)
        if(played == 0){
            playButton.setImage(UIImage(named: "pause"), for: .normal)
            // play music
            played = 1
            
        }
        else{
            playButton.setImage(UIImage(named: "play"), for: .normal)
            //pause music
            played = 0
        }
        if player.rate == 0
        {
            player.play()
            //playButton!.setImage(UIImage(named: "player_control_pause_50px.png"), forState: UIControlState.Normal)
            playButton.setTitle("Pause", for: UIControl.State.normal)
        } else {
            player.pause()
            //playButton!.setImage(UIImage(named: "player_control_play_50px.png"), forState: UIControlState.Normal)
            playButton.setTitle("Play", for: UIControl.State.normal)
        }
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            picImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            picImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            picImageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.45),
            picImageView.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.45)
        ])
        
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 60),
            nameLabel.topAnchor.constraint(equalTo: picImageView.bottomAnchor, constant: 40),
            nameLabel.bottomAnchor.constraint(equalTo: nameTextLabel.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            nameTextLabel.topAnchor.constraint(equalTo: nameLabel.topAnchor),
            nameTextLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            artistLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 60),
            artistLabel.topAnchor.constraint(equalTo: artistTextLabel.topAnchor),
            artistLabel.bottomAnchor.constraint(equalTo: artistTextLabel.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            artistTextLabel.topAnchor.constraint(equalTo: nameTextLabel.bottomAnchor, constant: 10),
            artistTextLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
        
        NSLayoutConstraint.activate([
            descLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            descLabel.topAnchor.constraint(equalTo: artistTextLabel.bottomAnchor, constant: 30)
        ])
        
        NSLayoutConstraint.activate([
            descTextLabel.topAnchor.constraint(equalTo: descLabel.bottomAnchor, constant: 20),
            descTextLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            descTextLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            descTextLabel.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.3)
        ])
        
        NSLayoutConstraint.activate([
            playButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            playButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            playButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.33),
            playButton.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.33)
        ])

//        NSLayoutConstraint.activate([
//            submitButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30),
//            submitButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
//        ])
    }
}

protocol updateCell: UIViewController {
    func updateName(name: String, artist: String)
}

extension UIImageView {
    func load(urlString: String){
        guard let url = URL(string: urlString) else{
            return
        }
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url){
                if let image = UIImage(data: data){
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
