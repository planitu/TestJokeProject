//
//  JokeCell.swift
//  Test Project
//
//  Created by Максим Хоменко on 07.03.2022.
//

import UIKit

class JokeCell: UITableViewCell {

 
    @IBOutlet weak var firstLabel: UILabel!
    
    override func prepareForReuse() {
        
        firstLabel.text = ""
    }
}
