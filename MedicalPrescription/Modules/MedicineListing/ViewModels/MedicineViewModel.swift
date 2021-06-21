//
//  MedicineViewModel.swift
//  MedicalPrescription
//
//  Created by Vivek on 09/06/21.
//

import Foundation

class MedicineViewModel{
    
    private var medicine: Medicine
    
    init(_ medicine: Medicine) {
        self.medicine = medicine
    }
}

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


extension MedicineViewModel: Hashable {
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(ObjectIdentifier(self))
    }
}

extension MedicineViewModel: Equatable {
    
    static func == (lhs: MedicineViewModel, rhs: MedicineViewModel) -> Bool {
        return lhs.medicine == rhs.medicine
    }
}
