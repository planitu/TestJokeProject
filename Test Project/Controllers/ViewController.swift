//
//  ViewController.swift
//  Test Project
//
//  Created by Максим Хоменко on 07.03.2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    private let network = NetworkManager()
    private let storageMeneger = UDStorage()
    
    private var storageCompany = Company(name: "", employees: []) {
        didSet{
            storageCompany.employees.sort { $0.name < $1.name  }
            storageMeneger.saveCompany(company: storageCompany)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.addTarget(self, action: #selector(didPullToRefresh), for: .valueChanged)
        
        if storageMeneger.loadCompany() != nil {
            storageCompany = storageMeneger.loadCompany()!
        }
        
        refreshAlert()
    }
    
    
    private func refreshAlert() {
        
        let label = UILabel(frame: CGRect(origin: CGPoint(x: 60, y: -5), size: CGSize(width: 290, height: 60)))
            label.text = "Потяните ⇩ для обновления данных\n\nСмахните ⇦ для удаления"
            label.textColor = .green
            label.numberOfLines = 0
            label.alpha = 0
            label.shadowColor = .white
            label.font = UIFont(descriptor: UIFontDescriptor(), size: 16)
        tableView.addSubview(label)
        
        UIView.animate(withDuration: 1, delay: 1.5, options: .curveEaseOut) {
            label.alpha = 1
            label.frame.origin = CGPoint(x: 60, y:35)
        } completion: {
            _ in
            UIView.animate(withDuration: 1, delay: 1.2, options: .curveEaseIn) {
                label.alpha = 0.1
                label.frame.origin = CGPoint(x: 60, y: -5)
            } completion: { _ in
                label.removeFromSuperview()
            }
        }
    }
    
    
    private func downloadCompany() {
        network.getModelFromURL(get: Response.self, from: NetworkManager.APIs.avitoTask.rawValue) { model in
            self.storageCompany = model.company
            self.tableView.reloadData()
        }
    }
    
    @objc func didPullToRefresh() {
        downloadCompany()
        self.tableView.refreshControl?.endRefreshing()
    }
}


// MARK: - TableView
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        storageCompany.employees.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "worker") as? WorkerCell else {fatalError("Cell error")}
        
        cell.accessoryType = .disclosureIndicator
        cell.configure(name: storageCompany.employees[indexPath.row].name, phone: storageCompany.employees[indexPath.row].phoneNumber)
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {

        return "\(storageCompany.name)"
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        40
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)

        let detailVC = DetailViewController()
        
        detailVC.worker = storageCompany.employees[indexPath.row]
        
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let action = UIContextualAction(style: .destructive, title: "🗑") { _, _, _ in
            
            self.storageCompany.employees.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        return UISwipeActionsConfiguration(actions: [action])
    }
}
