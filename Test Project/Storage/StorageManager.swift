//
//  Storage Manager.swift
//  Test Project
//
//  Created by Максим Хоменко on 07.03.2022.
//

import Foundation

class UDStorage {
    
    enum Keys: String {
        case storageKeyCompany
    }
    
    func loadCompany() -> Company? {
        
        guard let dataFromStorage = UserDefaults.standard.data(forKey: Keys.storageKeyCompany.rawValue),
        let result = try? JSONDecoder().decode(Company.self, from: dataFromStorage) else { return nil }
        
        return result
    }
    
    
    func saveCompany(company: Company) {
        
        guard let dataForStorage = try? JSONEncoder().encode(company) else {return}
        
        UserDefaults.standard.set(dataForStorage, forKey: Keys.storageKeyCompany.rawValue)
    }
}
