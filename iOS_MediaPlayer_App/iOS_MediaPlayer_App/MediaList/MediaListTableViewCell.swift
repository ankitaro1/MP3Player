//
//  MediaListTableViewCell.swift
//  iOS_MediaPlayer_App
//
//  Created by Ankit Sharma on 20/10/23.
//

import UIKit

class MediaListTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var artistLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureData(data: MediaUIModel?) {
        titleLabel.text = data?.title
        artistLabel.text = "-by " + (data?.artistName ?? "")
    }
}

