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
        // let nextViewController = storyboard!.instantiateViewController(withIdentifier: "PatientViewController") as! PatientViewController
        // navigationController?.pushViewController(nextViewController, animated: true)
        let email = "georgin2000155@gmail.com"
        let password = "Test12345"
        APIManager.shared.signIn(email: email, password: password){(result) in
            switch result {
            case .success(let user):
                print("User signed in: \(user.uid)")
                APIManager.shared.checkUserRole { role in
                    if role == "Admin" {
                        // запросить все документы из коллекции 'patients'
                        APIManager.shared.getPost(collection: "patients", docName: "1"){ doc in
                            print(doc!)
                            
                        }
                        // обработать данные
                        
                    } else if role == "User" {
                        // запросить только определенные документы из коллекции 'patients'
                        APIManager.shared.getPost(collection: "patients", docName: "2"){ doc in
                            print(doc!)
                            
                        }
                    }
                }
                
            case .failure(let error):
                print("Error signing in: \(error)")
                // Обрабатывайте ошибку здесь (например, показывайте сообщение об ошибке)
            }
        }
    }
}

