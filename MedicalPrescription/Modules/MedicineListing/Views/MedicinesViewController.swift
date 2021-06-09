//
//  MedicinesViewController.swift
//  MedicalPrescription
//
//  Created by Vivek on 09/06/21.
//

import UIKit

class MedicinesViewController: UIViewController{
    
    @IBOutlet var medicineListView: UITableView!
    
    let viewModel = MedicineListViewModel(apiService: APIServices())
    var medicines: [MedicineViewModel] = []
    lazy var filteredMedicines: [MedicineViewModel] = []
    var searchController: UISearchController!
    
    var isSearchBarEmpty: Bool {
      return searchController.searchBar.text?.isEmpty ?? true
    }

    var isFiltering: Bool {
      return searchController.isActive && !isSearchBarEmpty
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        viewModel.delegate = self
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self

        searchController.searchBar.sizeToFit()
        medicineListView.tableHeaderView = searchController.searchBar
        
        getAvailableMedicines()
    }
    
    
    private func getAvailableMedicines() {
        DispatchQueue.main.async{
            WaitingLoader.shared.show(onView: self.view)
        }
        viewModel.getAvailableMedicines()
    }
    
}

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
        
        medCell.medicineVM = medVM
        return medCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
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
    


//Tablet
//Suspension
//Syrup
//Drops
//Oral Drops
//Tube
//Liquid
//KIT
//Capsule
