//
//  PrescriptionViewController.swift
//  MedicalPrescription
//
//  Created by Vivek on 21/06/21.
//

import UIKit

protocol ReturnUpdatedDataDelegate: class {
    func didReceiveUpdatedData(medicines: [MedicineViewModel])
}

protocol MedicineDeleteDelegate: class {
    func delete(medicine: MedicineViewModel)
}


class PrescriptionViewController: UIViewController {

    @IBOutlet var prescriptionPadView: UIView!
    @IBOutlet var prescribedMedicineTableView: UITableView!
    private var prescription = [MedicineViewModel]()
    weak var updateDelegate: ReturnUpdatedDataDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.async{
            self.prescriptionPadView.layer.addCornerRadiusShadow(cornerRadiusValue: 30)
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.isHidden = true
    }
    
    //Dependancy Injection
    init?(coder: NSCoder, prescription: [MedicineViewModel]) {
        self.prescription = prescription
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("You must create this view controller with CityViewModel.")
    }
    
    @IBAction func backButtonTapped(_ : UIButton) {
        DispatchQueue.main.async {
            self.navigationController?.popViewController(animated: true)
            self.updateDelegate?.didReceiveUpdatedData(medicines: self.prescription)
        }
    }
    
    @IBAction func saveButtonTapped(_ : UIButton) {
        
    }
}

extension PrescriptionViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return prescription.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PrescribedMedViewCell.identifier, for: indexPath) as? PrescribedMedViewCell else {
            fatalError("Couldn't dequeue PrescribedMedViewCell type cell")
        }
        cell.mediVm = prescription[indexPath.row]
        cell.deleteDelegate = self
        return cell
    }
    
    
}



extension PrescriptionViewController: MedicineDeleteDelegate {
    func delete(medicine: MedicineViewModel) {
        prescription = prescription.filter{$0.name != medicine.name}
        DispatchQueue.main.async {
            self.prescribedMedicineTableView.reloadData()
        }
    }
    
    
}
