//
//  SearchUserListView.swift
//  GithubAPI
//
//  Created by Yu Li Lin on 2025/4/30.
//

import UIKit

class SearchUserListView: UIView {
    @IBOutlet var contentView: UIView!
    @IBOutlet var tableView: UITableView! {
        didSet {
            let nib = UINib(nibName: "\(SearchUserListCell.self)", bundle: nil)
            tableView.register(nib, forCellReuseIdentifier: "\(SearchUserListCell.self)")
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}

extension SearchUserListView {
    func commonInit() {
        translatesAutoresizingMaskIntoConstraints = false
        Bundle(for: SearchUserListView.self).loadNibNamed("\(SearchUserListView.self)",
                                                 owner: self,
                                                 options: nil)
        contentView.frame = bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        addSubview(contentView)
    }
}
