//
//  Employee.swift
//  Test Project
//
//  Created by Максим Хоменко on 07.03.2022.
//

import Foundation

struct Response: Codable {
    let company: Company
}


struct Company: Codable {
    let name: String
    var employees: [Employee]
}


struct Employee: Codable {
    let name: String
    let phoneNumber: String
    let skills: [String]

    enum CodingKeys: String, CodingKey {
        case name
        case phoneNumber = "phone_number"
        case skills
    }
}
