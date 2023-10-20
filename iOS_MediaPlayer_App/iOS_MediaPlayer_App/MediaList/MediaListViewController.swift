//
//  MediaListViewController.swift
//  iOS_MediaPlayer_App
//
//  Created by Ankit Sharma on 20/10/23.
//

import UIKit

protocol MediaListBusinessLogic {
    var mediaList: [MediaUIModel] { get }
    func fetchMediaList()
    var baseUrl: URL { get }
}

class MediaListViewController: UIViewController {

    @IBOutlet weak var mediaTableView: UITableView!
    
    var viewModel: MediaListBusinessLogic?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMediaTableView()
        viewModel?.fetchMediaList()
    }

    
    private func setupMediaTableView() {
        mediaTableView.delegate = self
        mediaTableView.dataSource = self
        let nib = UINib(nibName: "MediaListTableViewCell", bundle: .main)
        mediaTableView.register(nib, forCellReuseIdentifier: "MediaListTableViewCell")
    }
    
}

extension MediaListViewController: MediaListDiplayLogic {
    func refreshUI() {
        DispatchQueue.main.async {
            self.mediaTableView.isHidden = false
            self.mediaTableView.reloadData()
        }
    }
    
    func showError(error: ErrorModel) {
        mediaTableView.isHidden = true
        // Implement Error Handling
    }
}

extension MediaListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel?.mediaList.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MediaListTableViewCell", for: indexPath) as? MediaListTableViewCell
        let data = viewModel?.mediaList[indexPath.row]
        cell?.configureData(data: data)
        return cell ?? MediaListTableViewCell()
    }
}
