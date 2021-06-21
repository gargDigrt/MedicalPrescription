//
//  Medicine+CoreDataProperties.swift
//  MedicalPrescription
//
//  Created by Vivek on 21/06/21.
//
//

import Foundation
import CoreData


extension Medicine {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Medicine> {
        return NSFetchRequest<Medicine>(entityName: "Medicine")
    }

    @NSManaged public var company: String?
    @NSManaged public var dose: Int32
    @NSManaged public var id: Int32
    @NSManaged public var name: String?
    @NSManaged public var strength: String?
    @NSManaged public var strengthType: String?
    @NSManaged public var type: String?
    @NSManaged public var ofPrescription: Prescription?

}

extension Medicine : Identifiable {

}
