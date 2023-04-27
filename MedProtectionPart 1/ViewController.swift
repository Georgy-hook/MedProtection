//
//  ViewController.swift
//  MedProtectionPart 1
//
//  Created by Georgy on 11.02.2023.
//

import UIKit
import RealmSwift

class ViewController: UIViewController {
    // Инициализация кэша
    @IBOutlet weak var testImage: UIImageView!
    lazy var cacheObjects: NSCache<AnyObject, UIImage> = {
        let cache = NSCache<AnyObject, UIImage>()
        
        return cache

    }()
    
    // Функция получения картинки по URL
    func getImage(from url: URL, completion: @escaping (UIImage?) -> Void){
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
            else { return }
            DispatchQueue.main.async() {
                completion(image)
            }
        }.resume()
    }
    
    // Подключение к Realm базе
    let realm = try!Realm(configuration: .init(schemaVersion: 1))
    var patientRealm = try! Realm().objects(Patient.self)
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        Connect().getData(from: Connect().url!)
    }


    @IBAction func getImage(_ sender: Any) {
          getImage(from: URL(string: "http://med-expep.ru/testImages/IM-001.jpeg")!){
            [self] (image) in
              testImage.image = image
        }
    }
}

