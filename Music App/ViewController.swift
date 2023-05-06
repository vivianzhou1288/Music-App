import UIKit

class ViewController: UIViewController {

    var song: [Song] = []
    var shownSongsData: [Song] = []
    let refreshControl = UIRefreshControl()
    
    let tableView = UITableView()
    let reuseID = "my cell"
    var currentIndex = IndexPath()
    let userDefault = UserDefault()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        var url = URL(string: "http://35.245.120.104/")
        let formatParameter = URLQueryItem(name: "format", value: "json")
        url?.append(queryItems:[formatParameter])

        title = "Playlist"
        let whiteTextAttribute = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = whiteTextAttribute
        view.backgroundColor = .black

//        let hypeboy = Song(id: 0, name: "Hype Boy", description: "NewJeans 1st EP", artistname: "NewJeans", song_link: "sdafkj", image: ["hypeboy"])
//        let candy = Song(songPicName: "candy", name: "Candy", desc: "Delight", artist: "Baekhyun")
        
        song = []

//        if userDefault.getData().isEmpty{
//            song = [hypeboy]
//        } else {
//            song = userDefault.getData()
//        }
//        updateSong()

        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        
        //TODO: Initialize TableView
        self.view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .black
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: reuseID)
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none

        setupConstraints()
        configureItems()
        createSmartData()
    }
    
    func setupConstraints() {
        //TODO: Setup constraints
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor)
        ])
    }
    
    func createSmartData() {
        NetworkManager.shared.getAllSongs { songs in
            DispatchQueue.main.async {
                self.song = songs
                self.tableView.reloadData()
            }
        }
    }
    private func configureItems() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add, target: self, action: #selector(clickedButton)
        )
    }
    
    @objc func clickedButton(){
        present(AddSongViewController(delegate: self), animated: true)
    }
    
//    @objc func updateSong(){
//        userDefault.saveData(song: song)
//        tableView.reloadData()
//    }
//
//    @objc func deleteSong(){
//        var newSongs: [Song] = userDefault.getData()
//        if (song.count != 0){
//            newSongs.remove(at: currentIndex.row)
//        }
//        song = newSongs
//        updateSong()
//    }
    
    @objc func refreshData() {
        //TODO: Refresh Data
//        NetworkManager.shared.getAllMessages { messages in
//            DispatchQueue.main.async {
//                self.shownMessagesData = messages
//                self.messageTableView.reloadData()
//                self.refreshControl.endRefreshing()
//            }
//        }
    }
}

extension ViewController: updateCell {
    func updateName(name: String, artist: String) {
        song[currentIndex.row].name = name
        song[currentIndex.row].artistname = artist
        tableView.reloadData()
//        updateSong()
    }
}

extension ViewController: addCell{
    func addSong(picture: String, name: String, desc: String, artist: String, songURL: String) {
        var newSong: Song
        if (name != ""){
            let image = Image(url: "data:image/png;base64," + picture, created_at: "")
            let withoutImage = Image(url: picture, created_at: "")
            newSong = Song(id: 0, name: name, description: desc, artistname: artist, song_link: songURL, image: [withoutImage])
            newSong.asURL = true
        
            NetworkManager.shared.createSong(name: name, description: desc, artistname: artist, song_link: songURL, image: [image]) { songs in
            }
            
            NetworkManager.shared.createImage(id: newSong.id, image: newSong.image[0].url) { songs in
    //            print(newSong.id)
            }
            
            song.append(newSong)
            tableView.reloadData()
        }
    }
    
}

extension ViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.currentIndex = indexPath
        let currentSong = song[indexPath.row]
        let vc = DetailViewController(song: currentSong)
        vc.del = self
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return song.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: reuseID, for: indexPath) as? CustomTableViewCell{
            let currentSong = song[indexPath.row]
            cell.updateFrom(song: currentSong)
            cell.backgroundColor = .black
            return cell
        }
        else{
            return UITableViewCell()
        }
    }
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            tableView.beginUpdates()
            song.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.endUpdates()
//            updateSong()
        }
    }
}


