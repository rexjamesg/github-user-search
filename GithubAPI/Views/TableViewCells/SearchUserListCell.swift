//
//  SearchUserListCell.swift
//  GithubAPI
//
//  Created by Yu Li Lin on 2025/4/30.
//

import UIKit
import Kingfisher

class SearchUserListCell: UITableViewCell {
    
    @IBOutlet var userAvatar: UIImageView!
    @IBOutlet var userNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        userAvatar.setCircle()
    }
    
    func setData(item: SearchUserListItem) {
        print("item.avatarURL", item.avatarURL)
        if let avatatURL = item.avatarURL, let url = URL(string: avatatURL) {
            userAvatar.kf.setImage(with: url)
        }
        
        if let name = item.login {
            userNameLabel.text = name
        }
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
