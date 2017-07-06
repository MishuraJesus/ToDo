//
//  ToDoCell.swift
//  ToDoApp
//
//  Created by MikhailB on 06/07/2017.
//  Copyright © 2017 Mikhail. All rights reserved.
//

import UIKit

class ToDoCell: UITableViewCell {
    
    //MARK: - IBOutles
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dueDateLabel: UILabel!
    @IBOutlet weak var isCompleteButton: UIButton!
    
    func toDoCellConfiguration(title: String, dueDateString: String, isComplete: Bool) {
        self.titleLabel.text = title
        self.dueDateLabel.text = dueDateString
        isComplete ? isCompleteButton.setImage(#imageLiteral(resourceName: "Checked"), for: .selected) : isCompleteButton.setImage(#imageLiteral(resourceName: "Unchecked"), for: .normal)
    }
}
