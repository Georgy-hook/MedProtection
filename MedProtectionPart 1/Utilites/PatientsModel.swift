//
//  PatientsModel.swift
//  MedProtectionPart 1
//
//  Created by Georgy on 22.04.2023.
//

import Foundation
struct baseJson : Codable{
    let patient: [patients]
}
struct patients : Codable{
    var id: Int
    var name: String
    var surname: String
    var patronymic: String
    var age: Int
    var personImage:String
    var analysis: [analys]
}
struct analys : Codable{
    var id: Int
    var name: String
    var image: String
}
