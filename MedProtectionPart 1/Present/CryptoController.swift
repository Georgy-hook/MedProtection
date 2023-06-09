//
//  CryptoController.swift
//  MedProtectionPart 1
//
//  Created by Georgy on 27.02.2023.
//

import UIKit
import ImageCrypto
import CommonCrypto
import Foundation
import Security
class CryptoController: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var nonCyptoImage: UIImageView!
    @IBOutlet weak var cryptoImage: UIImageView!
    
    //MARK: - Variables
    var urlString:String = ""
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        nonCyptoImage.downloaded(from: URL(string: urlString)!)
    }
    
    //MARK: - Actions
    @IBAction func CryptThis(_ sender: Any) {
        guard let image = nonCyptoImage.image else{
            return
        }
        let encryptor = ImageEncryptor()
        encryptor.encrypt(image, using: "sdfsdfsdgfsfgsg"){ result in
            switch result {
            case .success(let image):
                DispatchQueue.main.async {
                    self.cryptoImage.image = image.uiImage
                }
                
                // do what you want with the encrypted image.
            case .failure(let error):
                print(error)
            }
            
        }
        encryptor.encrypt(image.pngData()!, using: "sdfsdfsdgfsfgsg"){ result in
            print(result)
            
        }
    }
}

// MARK: - ImagePicker Delegate
extension CryptoController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            nonCyptoImage.image = image
        }
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Загрузка изображения в ImageView
    
    @IBAction func downloadImage(_ sender: Any) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        cryptoImage.image = UIImage(named: "test1")
        present(imagePicker, animated: true, completion: nil)
    }
}
