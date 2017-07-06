//
//  ToDoCell.swift
//  ToDoApp
//
//  Created by MikhailB on 06/07/2017.
//  Copyright © 2017 Mikhail. All rights reserved.
//

import UIKit

protocol ToDoCellDelegate {
    func checkmarkButtonPressed(cell: UITableViewCell)
}

class ToDoCell: UITableViewCell {
    
    //MARK: - IBOutles
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dueDateLabel: UILabel!
    @IBOutlet weak var isCompleteButton: UIButton!
    
    var delegate: ToDoCellDelegate?
    
    func toDoCellConfiguration(title: String, dueDateString: String, isComplete: Bool) {
        self.titleLabel.text = title
        self.dueDateLabel.text = dueDateString
        self.isCompleteButton.isSelected = isComplete
        if self.isCompleteButton.isSelected {
            self.isCompleteButton.setImage(#imageLiteral(resourceName: "Checked"), for: .selected)
        } else {
            self.isCompleteButton.setImage(#imageLiteral(resourceName: "Unchecked"), for: .normal)
        }
        print(self.isCompleteButton.isSelected)
    }
    
    @IBAction func isCompleteButtonPressed(_ sender: UIButton) {
        if sender.isSelected {
            sender.setImage(#imageLiteral(resourceName: "Unchecked"), for: .normal)
            delegate?.checkmarkButtonPressed(cell: self)
        } else {
            sender.setImage(#imageLiteral(resourceName: "Checked"), for: .selected)
            delegate?.checkmarkButtonPressed(cell: self)
        }
    }
}
