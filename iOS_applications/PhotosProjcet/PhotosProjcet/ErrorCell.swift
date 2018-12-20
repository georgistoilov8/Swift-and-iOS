//
//  ErrorCell.swift
//  PhotosProjcet
//
//  Created by Georgi Stoilov on 20.12.18.
//  Copyright © 2018 Georgi Stoilov. All rights reserved.
//

import UIKit

class ErrorCell: UITableViewCell {

    @IBOutlet weak var onErrorLabel: UILabel!
    
    @IBOutlet weak var settingsButton: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func tapSettings(_ sender: Any) {
      UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
