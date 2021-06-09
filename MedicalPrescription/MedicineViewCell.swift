//
//  MedicineViewCell.swift
//  MedicalPrescription
//
//  Created by Vivek on 09/06/21.
//

import UIKit

class MedicineViewCell: UITableViewCell {
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var strengthLabel: UILabel!
    @IBOutlet var companyNameLabel: UILabel!
    @IBOutlet var doseValueLabel: UILabel!
    @IBOutlet var itemTypeImageView: UIImageView!
    
    var medicineVM: MedicineViewModel? {
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

    @IBAction func changeDailyDoses(_ sender: UIStepper) {
        
    }
}
