//
//  WaitingTVC.swift
//  shortcut code challenge UIKit
//
//  Created by Mohsen on 11/23/21.
//


import UIKit

class WaitingTVC: UITableViewCell {

    @IBOutlet weak var waitingIndicator: UIActivityIndicatorView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
