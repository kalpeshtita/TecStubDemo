//
//  DogListCell.swift
//  TecStubDemo
//
//  Created by Kalpesh Tita on 04/01/21.
//  Copyright © 2021 Tita. All rights reserved.
//

import UIKit

class DogListCell: UITableViewCell {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var lifeSpan: UILabel!
    @IBOutlet weak var dogImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
