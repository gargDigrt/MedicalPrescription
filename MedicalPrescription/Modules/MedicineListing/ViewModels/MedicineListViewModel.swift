//
//  MedicineViewModel.swift
//  MedicalPrescription
//
//  Created by Vivek on 09/06/21.
//

import Foundation

protocol MedicineListDelegate: class {
    func didReceiveMedicines(medicines: [MedicineViewModel])
    func didFailedMedicineRequest(error: Error)
}

class MedicineListViewModel {
    
    //Properties
    weak var delegate: MedicineListDelegate?
    
    // Private properties
    private var medicines: [Medicine]? {
        didSet {
            guard let medicines = medicines else {return}
            let medicinesVMs = medicines.map{MedicineViewModel($0)}
            self.delegate?.didReceiveMedicines(medicines: medicinesVMs)
        }
    }
}

extension MedicineListViewModel {
    
    /// This will get all medicine from server and then save into database
    func saveAndGetMedicines() {
        DatabaseManager.saveMedicinesToDB() { success, error in
            if error != nil {
                self.delegate?.didFailedMedicineRequest(error: error!)
            }
            DatabaseManager.fetchMedicinesFromDB { medicines in
                self.medicines = medicines
            }
        }
    }
}
