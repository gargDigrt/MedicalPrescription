//
//  Medicine.swift
//  MedicalPrescription
//
//  Created by Vivek on 09/06/21.
//

import Foundation

struct Medicine: Codable {
    let id: Int
    let name: String
    let type: String
    let company: String
    let strength: String?
    let strengthtype: String?
}
