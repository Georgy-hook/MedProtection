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
    // Функция для заполнения Label которые являются представлением карточки пациента
    func fillPatientInformationWith(Labelname fName: inout UILabel,
             labelSurname fSurname: inout UILabel,
             labelPatronomyc fPatronymic: inout UILabel,
             labelAge fAge: inout UILabel,
             imagePatient:inout UIImageView){
        fName.text = "Имя: \(name)"
        fSurname.text = "Фамилия: \(surname)"
        fPatronymic.text = "Отчество: \(patronymic)"
        fAge.text = "Возраст: \(age)"
        imagePatient.downloaded(from: URL(string: urlImage)!)
    }
}
