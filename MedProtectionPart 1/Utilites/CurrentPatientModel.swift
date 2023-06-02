//
//  CurrentPatientModel.swift
//  MedProtectionPart 1
//
//  Created by Georgy on 22.04.2023.
//

import Foundation
import UIKit
struct CurrentPatient {// Структура с данными карточки пациента
    var name : String
    var surname : String
    var patronymic: String
    var age: Int
    var urlImage: String
    init(name: String, surname: String, patronymic: String, age: Int, urlImage: String) {
        self.name = name
        self.surname = surname
        self.patronymic = patronymic
        self.age = age
        self.urlImage = urlImage
    }
}
