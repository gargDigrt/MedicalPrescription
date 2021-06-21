//
//  DatabaseManager.swift
//  MedicalPrescription
//
//  Created by Vivek on 13/06/21.
//

import Foundation
import CoreData

class DatabaseManager {
    
    class func fetchMedicinesFromDB(_ completion: @escaping(_ medicines: [Medicine])->()) {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Medicine")
        request.returnsObjectsAsFaults = false
        
        do {
            let result = try PersistentStorage.shared.context.fetch(request)
            guard let medicines = result as? [Medicine] else {return completion([])}
            completion(medicines)
        }catch let error{
            print("Couldn't fetch Medicines from DB",error.localizedDescription)
            completion([])
        }
    }
    
    class func saveMedicinesToDB(completion: @escaping (_ success: Bool,_ error: Error?) -> ()) {
        let urlText = MedicineRequests.medicine.getEndPoint()
        let resource = Resource<[Medicine]>(urlText)
        
        HTTPClient.shared.load(resource: resource) { result in
            switch result {
            case .success(_):
                deleteOldRecords()
                PersistentStorage.shared.saveContext()
                completion(true, nil)
            case .failure(let error):
                completion(false, error)
            }
        }
    }
    
    private class func deleteOldRecords() {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Medicine")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: request)
        
        do {
            try PersistentStorage.shared.context.execute(deleteRequest)
        } catch  let err{
            print(err.localizedDescription)
        }
    }
}
