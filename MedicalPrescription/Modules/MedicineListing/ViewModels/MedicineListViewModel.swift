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
    private var medicines: [Medicine]? {
        didSet {
            guard let medicines = medicines else {return}
            let medicinesVMs = medicines.map{MedicineViewModel($0)}
            self.delegate?.didReceiveMedicines(medicines: medicinesVMs)
        }
    }
    weak var delegate: MedicineListDelegate?
}

extension MedicineListViewModel {
    
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
