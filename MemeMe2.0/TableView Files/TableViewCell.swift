//
//  TableViewCell.swift
//  ProtoMeme
//
//  Created by Carlos Wilson on 12/12/20.
//  Copyright © 2020 Carlos Wilson. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    // MARK: Properties

    @IBOutlet weak var bottomMemeText: UILabel!
    @IBOutlet weak var topMemeText: UILabel!
    @IBOutlet weak var memeImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
