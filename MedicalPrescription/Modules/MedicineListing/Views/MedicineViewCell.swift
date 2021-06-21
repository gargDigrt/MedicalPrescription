//
//  MedicineViewCell.swift
//  MedicalPrescription
//
//  Created by Vivek on 09/06/21.
//

import UIKit

protocol MedicineDoseDelegate: class {
    func didUpdateDoseFor(medicine: MedicineViewModel)
}

class MedicineViewCell: UITableViewCell {
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var strengthLabel: UILabel!
    @IBOutlet var companyNameLabel: UILabel!
    @IBOutlet var doseValueLabel: UILabel!
    
    weak var doseDelegate: MedicineDoseDelegate!
    var medicineVM: MedicineViewModel! {
        didSet {
            guard let viewModel = medicineVM else {return}
            nameLabel.text = viewModel.name
            strengthLabel.text = viewModel.strength
            companyNameLabel.text = viewModel.company
            doseValueLabel.text = "\(viewModel.dailyDoses)"
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

    @IBAction func changeDailyDoses(_ sender: UIButton) {
        switch sender.tag {
        case 111:
            medicineVM?.modifyDosesTo(num: -1)
        default:
            medicineVM?.modifyDosesTo(num: 1)
        }
        doseValueLabel.text = String(describing: medicineVM.dailyDoses)
        self.doseDelegate?.didUpdateDoseFor(medicine: medicineVM)
    }
}
