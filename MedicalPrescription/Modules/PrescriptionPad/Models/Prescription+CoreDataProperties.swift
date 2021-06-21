//
//  Prescription+CoreDataProperties.swift
//  MedicalPrescription
//
//  Created by Vivek on 21/06/21.
//
//

import Foundation
import CoreData


extension Prescription {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Prescription> {
        return NSFetchRequest<Prescription>(entityName: "Prescription")
    }

    @NSManaged public var medicines: [Medicine]?
    @NSManaged public var uuid: String!
    @NSManaged public var meds: NSSet?

}

// MARK: Generated accessors for meds
extension Prescription {

    @objc(addMedsObject:)
    @NSManaged public func addToMeds(_ value: Medicine)

    @objc(removeMedsObject:)
    @NSManaged public func removeFromMeds(_ value: Medicine)

    @objc(addMeds:)
    @NSManaged public func addToMeds(_ values: NSSet)

    @objc(removeMeds:)
    @NSManaged public func removeFromMeds(_ values: NSSet)

}

extension Prescription : Identifiable {

}
