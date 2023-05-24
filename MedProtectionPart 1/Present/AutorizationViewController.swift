//
//  ViewController.swift
//  MedProtectionPart 1
//
//  Created by Georgy on 11.02.2023.
//

import UIKit

class AutorizationViewController: UIViewController {
    

    @IBAction func autorizationButtonTapped(_ sender: Any) {
        let nextViewController = storyboard!.instantiateViewController(withIdentifier: "PatientViewController") as! PatientViewController
        navigationController?.pushViewController(nextViewController, animated: true)
    }
}

