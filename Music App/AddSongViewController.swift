//
//  AddSongViewController.swift
//  Music App
//
//  Created by Vivian Zhou on 4/29/23.
//

import UIKit

class AddSongViewController: UIViewController, UINavigationControllerDelegate {

    let nameLabel = UILabel()
    let nameTextField = UITextField()
    let artistLabel = UILabel()
    let artistTextField = UITextField()
    let descLabel = UILabel()
    let descTextView = UITextView()
    let imageLabel = UILabel()
    let songURL = UILabel()
    let songURLTextField = UITextField()
    let songButton = UIButton()
    let songPicker = UIImagePickerController()
    let submitButton = UIButton()
    let backButton = UIButton()
    let userDefault = UserDefault()
    var savedImage = ""
    weak var del: addCell?
    
    init(delegate: addCell){
        super.init(nibName: nil, bundle: nil)
        self.del = delegate
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        songPicker.delegate = self
        
        title = "Add Song"
        let whiteTextAttribute = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = whiteTextAttribute
        view.backgroundColor = .black
        
        nameLabel.text = "Song:"
        nameLabel.font = .systemFont(ofSize: 20)
        nameLabel.textColor = .white
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(nameLabel)
        
        let namePlaceholderText = NSAttributedString(string: " Add Song's Name", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        nameTextField.attributedPlaceholder = namePlaceholderText
        nameTextField.font = .systemFont(ofSize: 20)
        nameTextField.backgroundColor = .black
        nameTextField.textColor = .white
        nameTextField.layer.cornerRadius = 7
        nameTextField.layer.borderWidth = 2.0
        nameTextField.layer.borderColor = UIColor.white.cgColor
        nameTextField.clipsToBounds = true
        nameTextField.textAlignment = .left
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(nameTextField)
        
        artistLabel.text = "Artist:"
        artistLabel.font = .systemFont(ofSize: 20)
        artistLabel.textColor = .white
        artistLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(artistLabel)
        
        let artistPlaceholderText = NSAttributedString(string: " Add Artist's Name", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        artistTextField.attributedPlaceholder = artistPlaceholderText
        artistTextField.font = .systemFont(ofSize: 20)
        artistTextField.textColor = .white
        artistTextField.layer.cornerRadius = 7
        artistTextField.layer.borderWidth = 2.0
        artistTextField.layer.borderColor = UIColor.white.cgColor
        artistTextField.clipsToBounds = true
        artistTextField.textAlignment = .left
        artistTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(artistTextField)
        
        descLabel.text = "Description:"
        descLabel.font = .systemFont(ofSize: 20)
        descLabel.textColor = .white
        descLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(descLabel)
        
        descTextView.text = "Add Description"
        descTextView.font = .systemFont(ofSize: 20)
        descTextView.backgroundColor = .black
        descTextView.textColor = .white
        descTextView.layer.cornerRadius = 7
        descTextView.layer.borderWidth = 2.0
        descTextView.layer.borderColor = UIColor.white.cgColor
        descTextView.textAlignment = .left
        descTextView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(descTextView)
        
        imageLabel.text = "Image:"
        imageLabel.font = .systemFont(ofSize: 20)
        imageLabel.textColor = .white
        imageLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(imageLabel)
        
        
        songURL.text = "Song's MP3 Link:"
        songURL.font = .systemFont(ofSize: 20)
        songURL.textColor = .white
        songURL.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(songURL)
        
        let songURLPlaceholderText = NSAttributedString(string: " Add Song's Link", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        songURLTextField.attributedPlaceholder = songURLPlaceholderText
        songURLTextField.font = .systemFont(ofSize: 20)
        songURLTextField.textColor = .white
        songURLTextField.layer.cornerRadius = 7
        songURLTextField.layer.borderWidth = 2.0
        songURLTextField.layer.borderColor = UIColor.white.cgColor
        songURLTextField.clipsToBounds = true
        songURLTextField.textAlignment = .left
        songURLTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(songURLTextField)
        
        songButton.setTitle("Upload Picture", for: .normal)
        songButton.translatesAutoresizingMaskIntoConstraints = false
        songButton.addTarget(self, action: #selector(uploadPicture), for: .touchUpInside)
        view.addSubview(songButton)
        
        submitButton.setTitle("Submit", for: .normal)
        submitButton.setTitleColor(.white, for: .normal)
        submitButton.addTarget(self, action: #selector(addSongCell), for: .touchUpInside)
        submitButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(submitButton)
        
        backButton.setTitle("← Back", for: .normal)
        backButton.setTitleColor(.systemBlue, for: .normal)
        backButton.addTarget(self, action: #selector(back), for: .touchUpInside)
        backButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(backButton)
        
        setupConstraints()
        
    }
    
    @objc func addSongCell(){
        dismiss(animated: true)
        
        let pictureText = savedImage
//        let newImage = Image(url: pictureText, created_at: "")
        if let songText = nameTextField.text, let descText = descTextView.text, let artistText = artistTextField.text{
            
            
            del?.addSong(picture: pictureText, name: songText, desc: descText, artist: artistText, songURL: "")
        }
//
    }
    
    @objc func uploadPicture(){
        present(songPicker, animated: true)
    }
    
    @objc func back() {
        dismiss(animated: true)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            nameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40)
        ])
                                    
        NSLayoutConstraint.activate([
            nameTextField.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            nameTextField.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 20),
            nameTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7),
            nameTextField.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.05)
        ])
        
        
        NSLayoutConstraint.activate([
            artistLabel.leadingAnchor.constraint(equalTo: nameTextField.leadingAnchor),
            artistLabel.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 20)
        ])
        
        NSLayoutConstraint.activate([
            artistTextField.leadingAnchor.constraint(equalTo: artistLabel.leadingAnchor),
            artistTextField.topAnchor.constraint(equalTo: artistLabel.bottomAnchor, constant: 10),
            artistTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7),
            artistTextField.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.05)
        ])
        
        NSLayoutConstraint.activate([
            descLabel.leadingAnchor.constraint(equalTo: nameTextField.leadingAnchor),
            descLabel.topAnchor.constraint(equalTo: artistTextField.bottomAnchor, constant: 20)
        ])
        
        NSLayoutConstraint.activate([
            descTextView.leadingAnchor.constraint(equalTo: nameTextField.leadingAnchor),
            descTextView.topAnchor.constraint(equalTo: descLabel.bottomAnchor, constant: 15),
            descTextView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.3),
            descTextView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            descTextView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7)
        ])
        
        NSLayoutConstraint.activate([
            imageLabel.leadingAnchor.constraint(equalTo: descTextView.leadingAnchor),
            imageLabel.topAnchor.constraint(equalTo: descTextView.bottomAnchor, constant: 20)
        ])
        
        NSLayoutConstraint.activate([
            songButton.leadingAnchor.constraint(equalTo: imageLabel.leadingAnchor),
            songButton.topAnchor.constraint(equalTo: imageLabel.bottomAnchor, constant: 20)
        ])
        
        NSLayoutConstraint.activate([
            songURL.leadingAnchor.constraint(equalTo: songButton.leadingAnchor),
            songURL.topAnchor.constraint(equalTo: songButton.bottomAnchor, constant: 20)
        ])
        
        NSLayoutConstraint.activate([
            songURLTextField.leadingAnchor.constraint(equalTo: songURL.leadingAnchor),
            songURLTextField.topAnchor.constraint(equalTo: songURL.bottomAnchor, constant: 15),
            songURLTextField.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.05),
            songURLTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            songURLTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7)
        ])
        
        NSLayoutConstraint.activate([
            submitButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            submitButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            backButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 5)
        ])
    }
}

extension AddSongViewController: UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {

        guard let image = info[.originalImage] as? UIImage else{
            dismiss(animated: true)
            return
        }
        savedImage = (image.jpegData(compressionQuality: 0.5)?.base64EncodedString() ?? "")
        
        dismiss(animated: true)
//        print(savedImage)
    

    }
}

protocol addCell: UIViewController {
    func addSong(picture: String, name: String, desc: String, artist: String, songURL: String)
}

