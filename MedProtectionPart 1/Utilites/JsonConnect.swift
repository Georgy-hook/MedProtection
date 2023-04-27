//
//  JsonConnect.swift
//  MedProtectionPart 1
//
//  Created by Georgy on 12.02.2023.
//

import Foundation
import RealmSwift
import UIKit
class Connect{
    let realm = try!Realm(configuration: .init(schemaVersion: 3))
    let url = URL(string: "http://med-expep.ru/MedProtectAdmin/BaseJson3.json")
    func getData(from url:URL){
        
        let task = URLSession(configuration: .ephemeral).dataTask(with: url){data,response,error in
            
            guard let data = data, error == nil else{
                print("something wrong")
                return
            }
            //have data
            DispatchQueue.main.async{
                var result:baseJson?
                
                do {
                    result = try JSONDecoder().decode(baseJson.self, from: data)
                    try! self.realm.write{
                        self.realm.deleteAll()
                        for i in 0..<result!.patient.count {
                            let patientObj = Patient()
                            patientObj.id = i
                            patientObj.firstName = result!.patient[i].name
                            patientObj.lastName = result!.patient[i].surname
                            patientObj.age = result!.patient[i].age
                            patientObj.patronymic = result!.patient[i].patronymic
                            patientObj.personImage = result!.patient[i].personImage
                            for j in 0..<result!.patient[i].analysis.count{
                                let analysObj = Analys()
                                analysObj.id = j
                                analysObj.name = result!.patient[i].analysis[j].name
                                analysObj.urlImage = result!.patient[i].analysis[j].image
                                patientObj.analysis.append(analysObj)
                                self.realm.add(analysObj)
                            }
                            self.realm.add(patientObj)
                        }
                    }
                    print(result!.patient[1].patronymic)
                }
                catch{
                    print("failed to convert \(error.localizedDescription)")
                }
            }
            
        }
        task.resume()
    }
    
}
