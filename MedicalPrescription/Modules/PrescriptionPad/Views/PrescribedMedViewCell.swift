//
//  PrescribedMedViewCell.swift
//  MedicalPrescription
//
//  Created by Vivek on 21/06/21.
//

import UIKit

class PrescribedMedViewCell: UITableViewCell {

    //IBOutlet
    @IBOutlet var medicineNameLabel: UILabel!
    @IBOutlet var doseLabel: UILabel!
    
    //Properties
    weak var deleteDelegate: MedicineDeleteDelegate?
    var mediVm: MedicineViewModel! {
        didSet {
            DispatchQueue.main.async {
                self.medicineNameLabel.text = self.mediVm.name
                self.doseLabel.text = "\(self.mediVm.dailyDoses)"
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //MARK:- Button actions
    @IBAction func changeDailyDoses(_ sender: UIButton) {
        switch sender.tag {
        case 111:
            mediVm.modifyDosesTo(num: -1)
        default:
            mediVm.modifyDosesTo(num: 1)
        }
        doseLabel.text = String(describing: mediVm.dailyDoses)
        
        guard mediVm.dailyDoses == 0 else{ return }
        deleteDelegate?.delete(medicine: mediVm)
    }

}
