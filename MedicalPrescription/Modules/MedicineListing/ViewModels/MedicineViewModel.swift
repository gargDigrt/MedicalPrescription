//
//  MedicineViewModel.swift
//  MedicalPrescription
//
//  Created by Vivek on 09/06/21.
//

import Foundation

class MedicineViewModel{
    
    //Private Property
    private var medicine: Medicine
    
    //Initializer
    init(_ medicine: Medicine) {
        self.medicine = medicine
    }
}

//MARK:- Properties
extension MedicineViewModel {
    var name: String {
        return medicine.name ?? "NA"
    }
    
    var type: String {
        return medicine.type ?? "NA"
    }
    
    var company: String {
        return medicine.company ?? "NA"
    }
    var strength: String {
        return medicine.strength ?? "NA"
    }
    var dailyDoses: Int {
        return Int(medicine.dose)
    }
}

//MARK:- Custom Methods
extension MedicineViewModel {
    
    func modifyDosesTo(num: Int) {
        let newValue = medicine.dose + Int32(num)
        medicine.dose = newValue<0 ? 0 : newValue
    }
    
    func resetDose() -> MedicineViewModel{
        medicine.dose = 0
        return self
    }
    
    func saveToDB(prescriptionID: String) {
        DatabaseManager.savePrescriptionWith(id: prescriptionID, medicine: medicine)
    }
}

//MARK:- Equitable Protocol
extension MedicineViewModel: Equatable {
    static func == (lhs: MedicineViewModel, rhs: MedicineViewModel) -> Bool {
        return lhs.medicine == rhs.medicine
    }
}
