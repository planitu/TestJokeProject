//
//  WorkerCell.swift
//  Test Project
//
//  Created by Максим Хоменко on 07.03.2022.
//

import UIKit

class WorkerCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    
    func configure(name: String, phone: String) {
        
        nameLabel.text = name
        phoneLabel.text = phone
    }
}
