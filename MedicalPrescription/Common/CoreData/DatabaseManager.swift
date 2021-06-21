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
                deleteOldRecordsForEntity(name: "Medicine")
                PersistentStorage.shared.saveContext()
                completion(true, nil)
            case .failure(let error):
                completion(false, error)
            }
        }
    }
    
    class func fetchPrescriptionWith(id: String) -> Prescription? {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Prescription")
        request.predicate = NSPredicate(format: "uuid LIKE '%@'", id)
        
        do {
            let result = try PersistentStorage.shared.context.fetch(request)
            guard let prescriptions = result as? [Prescription] else {return nil}
            return prescriptions.count>0 ? prescriptions.first! : nil
        }catch let error{
            print("Couldn't fetch Prescription from DB",error.localizedDescription)
            return nil
        }
    }
    
    class func savePrescriptionWith(id: String, medicine: Medicine) {
        if let prescription = fetchPrescriptionWith(id: id) {
            prescription.addToMeds(medicine)
        } else {
            let entity = NSEntityDescription.entity(forEntityName: "Prescription", in: PersistentStorage.shared.context)!
            let prescription = NSManagedObject(entity: entity, insertInto: PersistentStorage.shared.context)
            prescription.setValue([medicine], forKey: "medicines")
            prescription.setValue(id, forKey: "uuid")
            PersistentStorage.shared.saveContext()
        }
    }
    
    private class func deleteOldRecordsForEntity(name: String) {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: name)
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: request)
        
        do {
            try PersistentStorage.shared.context.execute(deleteRequest)
        } catch  let err{
            print(err.localizedDescription)
        }
    }
}
