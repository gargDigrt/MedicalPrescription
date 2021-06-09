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
    private var apiService: APIServices?
    weak var delegate: MedicineListDelegate?
    
    init(apiService: APIServices) {
        self.apiService = apiService
    }
}

extension MedicineListViewModel {
    
    func getAvailableMedicines() {
        let urlText = MedicineRequests.medicine.getEndPoint()
        let resource = Resource<[Medicine]>(urlText)
        
        self.apiService?.load(resource: resource) { [weak self] result in
            guard let notNIlSelf = self else {return}
            switch result {
            case .success(let medicines):
                notNIlSelf.medicines = medicines
            case .failure(let error):
                self?.delegate?.didFailedMedicineRequest(error: error)
            }
        }
    }
}
