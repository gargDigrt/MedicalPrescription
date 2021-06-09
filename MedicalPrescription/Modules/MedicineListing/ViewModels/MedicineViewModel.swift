//
//  MedicineViewModel.swift
//  MedicalPrescription
//
//  Created by Vivek on 09/06/21.
//

import Foundation

struct MedicineViewModel {
    
    private var medicine: Medicine
    
    init(_ medicine: Medicine) {
        self.medicine = medicine
    }
}

extension MedicineViewModel {
    var name: String {
        return medicine.name
    }
    
    var type: String {
        return medicine.type
    }
    
    var company: String {
        return medicine.company
    }
    var strength: String {
        return medicine.strength ?? ""
    }
    var dailyDoses: Int {
        return medicine.dailyDoses
    }
}
