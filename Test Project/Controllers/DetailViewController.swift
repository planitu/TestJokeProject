//
//  DetailViewController.swift
//  Test Project
//
//  Created by Максим Хоменко on 07.03.2022.
//

import UIKit

class DetailViewController: UIViewController {
    
    var worker: Employee!

    var nameLabel: UILabel!
    var phoneLabel: UILabel!
    var skillsLabel: UILabel!
    var workerLabelStack: UIStackView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        title = "Подробно"
        navigationController?.navigationBar.tintColor = .black
        
        nameLabel = UILabel()
        phoneLabel = UILabel()
        skillsLabel = UILabel()
        
        nameLabel.text = "\n  Имя: " + worker.name
        nameLabel.numberOfLines = 0
        nameLabel.textColor = .black
        phoneLabel.text = "  Телефон: " + worker.phoneNumber
        phoneLabel.textColor = .black
        skillsLabel.numberOfLines = 0
        skillsLabel.text = "  Навыки: \n\n"
        skillsLabel.textColor = .black

        for i in worker.skills {
            skillsLabel.text! += "   - \(i)\n"
        }
        
        workerLabelStack = UIStackView(arrangedSubviews: [nameLabel, phoneLabel, skillsLabel])
        workerLabelStack.spacing = 20
        workerLabelStack.distribution = .fillProportionally
        workerLabelStack.axis = .vertical
        workerLabelStack.layer.borderColor = UIColor.lightGray.cgColor
        workerLabelStack.layer.borderWidth = 5
        workerLabelStack.layer.cornerRadius = 15
        
        view.addSubview(workerLabelStack)
        
        workerLabelStack.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            workerLabelStack.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            workerLabelStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            workerLabelStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32)
        ])
    }
}
