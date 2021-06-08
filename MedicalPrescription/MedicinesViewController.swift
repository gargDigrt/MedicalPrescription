//
//  MedicinesViewController.swift
//  MedicalPrescription
//
//  Created by Vivek on 06/06/21.
//

import UIKit

class MedicinesViewController: UIViewController {
    
   lazy var medicineListView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .red
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "basicCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setupView()
        getAvailableMedicines()
    }

    private func setupView() {
        view.addSubview(medicineListView)
        medicineListView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        medicineListView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        medicineListView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        medicineListView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        DispatchQueue.main.async {
            self.medicineListView.reloadData()
        }
    }
    
    private func getAvailableMedicines() {
        let urlText = MedicineRequests.medicine.getEndPoint()
        let resource = Resource<[Medicine]>(urlText)
        
        WaitingLoader.shared.show(onView: view)
        APIServices.shared.load(resource: resource) { result in
            //Hide the waiting loader first
            DispatchQueue.main.async {
                WaitingLoader.shared.hide(fromView: self.view)
            }
            //Check for the result
            switch result {
            case .success(let medicines):
                print(medicines.count)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

}


extension MedicinesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "basicCell", for: indexPath)
        cell.textLabel?.text = "4242bk24bk"
        return cell
    }
    
    
}
