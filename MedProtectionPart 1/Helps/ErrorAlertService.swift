//
//  ErrorAlertService.swift
//  MedProtectionPart 1
//
//  Created by Georgy on 30.05.2023.
//

import UIKit

enum UserError: String, Error {
    case userNotFound = "Пользователь не найден"
    case wrongPassword = "Неверный пароль"
    case networkError = "Ошибка сети"
    case unknownRole = "Неизвестная роль"
    case noPatientData = "Нет данных о пациенте"
    case databaseError = "Ошибка базы данных"
    case unknownError = "Неизвестная ошибка"
    
    var localizedDescription: String {
        return self.rawValue
    }
}

class ErrorAlertService {
    
    static func showAlert(on viewController: UIViewController, with error: UserError) {
        let alert = UIAlertController(title: "Ошибка", message: error.localizedDescription, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "ОК", style: .default, handler: nil)
        alert.addAction(okAction)
        viewController.present(alert, animated: true, completion: nil)
    }
}

