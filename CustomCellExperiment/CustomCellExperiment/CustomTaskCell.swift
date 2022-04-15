//
//  CustomCell.swift
//  CustomCellExperiment
//
//  Created by Carlos Wilson on 23/09/21.
//

import UIKit

class CustomTaskCell: UITableViewCell {
    @IBOutlet weak var viewImage: UIImageView!
    @IBOutlet weak var label: UILabel!
    
    func update(task: Task) {
        label.text = task.title
        
        viewImage.image = UIImage(systemName: "paperplane.fill")
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yy hh:mma"
        // dateLabel.text = dateFormatter.string(from: task.date)
        
    }
}
