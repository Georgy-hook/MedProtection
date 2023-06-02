//
//  ViewController.swift
//  MedProtectionPart 1
//
//  Created by Georgy on 11.02.2023.
//

import UIKit

class AutorizationViewController: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    //MARK: - Actions
    @IBAction func autorizationButtonTapped(_ sender: UIButton) {
        sender.isEnabled = false  // Отключить кнопку
        let email = loginTextField.text!
        let password = passwordTextField.text!
        APIManager.shared.signIn(email: email, password: password) { (result) in
            switch result {
            case .success(let user):
                print("User signed in: \(user.uid)")
                APIManager.shared.checkUserRole { role in
                    APIManager.shared.loadData(for: role!){
                        // Переход к следующему контроллеру после загрузки данных
                        if role == "Admin"{
                            let nextViewController = self.storyboard!.instantiateViewController(withIdentifier: "PatientViewController") as! PatientViewController
                            self.navigationController?.pushViewController(nextViewController, animated: true)
                            sender.isEnabled.toggle()
                        } else{
                            guard let patient = RealmService.shared.getPatient(at: 0) else{
                                ErrorAlertService.showAlert(on: self, with: .databaseError)
                                sender.isEnabled.toggle()
                                return
                            }
                            
                            // Создаем новый view controller, передавая ему пациента.
                            guard let nextViewController = self.storyboard?.instantiateViewController(identifier: "AnalysisViewController", creator: { coder in
                                AnalysisViewController(coder: coder, patient: patient)
                            }) else {
                                ErrorAlertService.showAlert(on: self, with: .databaseError)
                                sender.isEnabled.toggle()
                                return
                            }
                            
                            self.navigationController?.pushViewController(nextViewController, animated: true)
                            sender.isEnabled.toggle()
                        }
                    }
                    
                }
            case .failure(let error):
                print("Error signing in: \(error)")
                ErrorAlertService.showAlert(on: self, with: .userNotFound)
                sender.isEnabled.toggle()
            }
        }
    }
}
