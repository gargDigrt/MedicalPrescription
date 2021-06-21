//
//  MedicinesViewController.swift
//  MedicalPrescription
//
//  Created by Vivek on 21/06/21.
//

import UIKit

class MedicinesViewController: UIViewController{
    
    //IBOutlet
    @IBOutlet var medicineListView: UITableView!
    
    //Variables
    var prescription: [MedicineViewModel] = []
    var medicines: [MedicineViewModel] = []
    lazy var filteredMedicines: [MedicineViewModel] = []
    var searchController: UISearchController!
    var isSearchBarEmpty: Bool {
      return searchController.searchBar.text?.isEmpty ?? true
    }
    var isFiltering: Bool {
      return searchController.isActive && !isSearchBarEmpty
    }

    //Constants
    let viewModel = MedicineListViewModel()
    
    
    //MARK:- View's life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Search Controller setup
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.searchBar.sizeToFit()
        medicineListView.tableHeaderView = searchController.searchBar
        
        //Navigation Bar setup
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "pad"), style: .plain, target: self, action: #selector(moveToPrescriptionPad))
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "new"), style: .plain, target: self, action: #selector(newPrescription))
        
        //APi call for medcines
        getAvailableMedicines()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //Navigation bar visibility
        navigationController?.navigationBar.isHidden = false
    }
    
    //MARK:- Custom behaviour
    private func getAvailableMedicines() {
        DispatchQueue.main.async{
            WaitingLoader.shared.show(onView: self.view)
        }
        viewModel.delegate = self
        viewModel.saveAndGetMedicines()
    }
    
    //MARK:- Selector methods
    @objc func moveToPrescriptionPad() {
        guard let prescriptionVC = storyboard?.instantiateViewController(identifier: PrescriptionViewController.identifier, creator: { coder in
            return PrescriptionViewController(coder: coder, prescription: self.prescription)
        }) else {
            fatalError("Failed to load PrescriptionViewController from storyboard.")
        }
        prescriptionVC.updateDelegate = self
        DispatchQueue.main.async {
            self.navigationController?.show(prescriptionVC, sender: nil)
        }
    }
    
    @objc func newPrescription() {
        filteredMedicines.removeAll()
        medicines = medicines.map({$0.resetDose()})
        DispatchQueue.main.async {
            self.medicineListView.reloadData()
        }
    }
}

//MARK:- ReturnUpdatedDataDelegate
extension MedicinesViewController: ReturnUpdatedDataDelegate {
    func didReceiveUpdatedData(medicines: [MedicineViewModel]) {
        let updated = self.medicines.filter({!medicines.contains($0)})
        self.medicines = medicines + updated
        DispatchQueue.main.async {
            self.medicineListView.reloadData()
        }
    }
}

//MARK:- MedicineListDelegate
extension MedicinesViewController: MedicineListDelegate {
    
    func didReceiveMedicines(medicines: [MedicineViewModel]) {
        self.medicines = medicines
        DispatchQueue.main.async {
            WaitingLoader.shared.hide(fromView: self.view)
            self.medicineListView.reloadData()
        }
    }
    
    func didFailedMedicineRequest(error: Error) {
        DispatchQueue.main.async {
            WaitingLoader.shared.hide(fromView: self.view)
        }
        print(error.localizedDescription)
    }
    
}

//MARK:- MedicineDoseDelegate
extension MedicinesViewController: MedicineDoseDelegate {
    func didUpdateDoseFor(medicine: MedicineViewModel) {
        if !prescription.contains(medicine) {
            prescription.append(medicine)
        }
        prescription = prescription.filter{$0.dailyDoses != 0}
    }
    
}

extension MedicinesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isFiltering ? filteredMedicines.count : medicines.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let medCell = tableView.dequeueReusableCell(withIdentifier: MedicineViewCell.identifier, for: indexPath) as? MedicineViewCell else {
            fatalError("Couldn't dequeue MedicineViewCell!!")
        }
        let medVM = isFiltering ? filteredMedicines[indexPath.row] : medicines[indexPath.row]
        medCell.doseDelegate = self
        medCell.medicineVM = medVM
        return medCell
    }
    
}

extension MedicinesViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {

        if let searchText = searchController.searchBar.text {
            print(searchText)
            filteredMedicines = searchText.isEmpty ? medicines : medicines.filter({(medicine: MedicineViewModel) -> Bool in
                return medicine.name.lowercased().contains(searchText.lowercased())
            })
            DispatchQueue.main.async{
                self.medicineListView.reloadData()
            }
        }
    }
}

