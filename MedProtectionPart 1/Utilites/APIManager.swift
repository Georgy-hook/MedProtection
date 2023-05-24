//
//  APIManager.swift
//  MedProtectionPart 1
//
//  Created by Georgy on 24.05.2023.
//

import Foundation
import Firebase
import FirebaseStorage
import FirebaseDatabase

class APIManager {
    
    static let shared = APIManager()
    
    private func configureFB() -> Firestore {
        var db: Firestore!
        let settings = FirestoreSettings()
        Firestore.firestore().settings = settings
        db = Firestore.firestore()
        return db
    }
    
    func getPost(collection: String, docName: String, completion: @escaping (patients?) -> Void) {
        let db = configureFB()
        db.collection(collection).document(docName).getDocument(completion: { (document, error) in
            if let error = error {
                print(error)
                return
            }
            guard let document = document else {
                print("Empty document")
                return
            }
            
            let analysisData = document.get("analysis") as? [[String: Any]]
            var analysis: [analys] = []
            
            if let analysisData = analysisData {
                for item in analysisData {
                    if let id = item["id"] as? Int,
                       let name = item["name"] as? String,
                       let image = item["image"] as? String {
                        let analysisItem = analys(id: id, name: name, image: image)
                        analysis.append(analysisItem)
                    }
                }
            }
            
            let doc = patients(id: document.get("id") as! Int,
                               name: document.get("name") as! String,
                               surname: document.get("surname") as! String,
                               patronymic: document.get("patronymic") as! String,
                               age: document.get("age") as! Int,
                               personImage: document.get("personImage") as! String,
                               analysis: analysis)
            completion(doc)
        })
    }

}
