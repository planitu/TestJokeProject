//
//  JokeViewController.swift
//  Test Project
//
//  Created by Максим Хоменко on 07.03.2022.
//

import UIKit
import Haptica

class JokeViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var buttonDownload: UIButton!
    
    let network = NetworkManager()

    private var jokeStorage: [String] = []
    private var isAlertShown = false

    
    override func viewDidLoad() {
        super.viewDidLoad()

        buttonDownload.layer.cornerRadius = 13
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(UINib(nibName: "JokeCell", bundle: nil), forCellReuseIdentifier: "myJokeCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard !isAlertShown else { return }
        jokeAlert()
        isAlertShown = true
    }
    
    
    private func jokeAlert() {
        
        let alert = UIAlertController(title: "Внимание!", message: "Данный раздел содержит шутки взятые со случайного ресурса. Разработчик за содержание ответственности не несёт.", preferredStyle: .alert)
        let actionOK = UIAlertAction(title: "Ok", style: .cancel)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            alert.addAction(actionOK)
        }
        present(alert, animated: true)
    }
    
    
    @IBAction func didTapButton(_ sender: UIButton) {
        
        Haptic.impact(.soft).generate()
        network.getModelFromURL(get: JokeChuck.self, from: NetworkManager.APIs.jokeChuck.rawValue) { model in
            
            self.jokeStorage.insert(model.joke, at: 0)
            self.addJokeInTable()
        }
    }
    
    private func addJokeInTable() {
        tableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: .fade)
    }
}


extension JokeViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        jokeStorage.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "myJokeCell", for: indexPath) as! JokeCell
        
        cell.firstLabel.text = jokeStorage[indexPath.row]
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let action = UIContextualAction(style: .destructive, title: "🗑") { _, _, _ in
            
            self.jokeStorage.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            Haptic.impact(.rigid).generate()
        }
        return UISwipeActionsConfiguration(actions: [action])
    }
}
