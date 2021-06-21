//
//  Extensions.swift
//  MedicalPrescription
//
//  Created by Vivek on 21/06/21.
//

import UIKit

extension UITableViewCell {
    
    static var identifier: String {
        return String(describing: self)
    }
}


extension UIViewController {
    
    static var identifier: String {
        return String(describing: self)
    }
}
