//
//  ViewController.swift
//  MedProtectionPart 1
//
//  Created by Georgy on 11.02.2023.
//

import UIKit

class AutorizationViewController: UIViewController {
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBAction func autorizationButtonTapped(_ sender: Any) {
        let email = "georgin2000155@gmail.com"
        let password = "Test12345"
        APIManager.shared.signIn(email: email, password: password) { (result) in
            switch result {
            case .success(let user):
                print("User signed in: \(user.uid)")
                APIManager.shared.checkUserRole { role in
                    APIManager.shared.loadData(for: role!){
                        // Переход к следующему контроллеру после загрузки данных
                        let nextViewController = self.storyboard!.instantiateViewController(withIdentifier: "PatientViewController") as! PatientViewController
                        self.navigationController?.pushViewController(nextViewController, animated: true)
                    }
                    
                }
            case .failure(let error):
                print("Error signing in: \(error)")
                // Обрабатывайте ошибку здесь (например, показывайте сообщение об ошибке)
            }
        }
    }
}
