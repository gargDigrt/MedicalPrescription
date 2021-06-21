//
//  Medicine+CoreDataClass.swift
//  MedicalPrescription
//
//  Created by Vivek on 14/06/21.
//
//

import Foundation
import CoreData

@objc(Medicine)
public class Medicine: NSManagedObject, Codable {
    
    enum CodingKeys: String, CodingKey {
        case company, dose, id, name, strength, type
        case strengthType = "strengthtype"
    }
    
    required convenience public init(from decoder: Decoder) throws {
        guard let entity = NSEntityDescription.entity(forEntityName: "Medicine", in: PersistentStorage.shared.context) else { fatalError("cannot create entity") }
        
        self.init(entity: entity, insertInto: PersistentStorage.shared.context)
        let values = try decoder.container(keyedBy:  CodingKeys.self)
        self.company = try values.decodeIfPresent(String.self, forKey: .company)
        self.type = try values.decodeIfPresent(String.self, forKey: .type)
        self.strength = try values.decodeIfPresent(String.self, forKey: .strength)
        self.strengthType = try values.decodeIfPresent(String.self, forKey: .strengthType)
        self.name = try values.decodeIfPresent(String.self, forKey: .name)
        self.id = try values.decode(Int32.self, forKey: .id)
        dose = 0
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.id, forKey: .id)
        try container.encodeIfPresent(self.name, forKey: .name)
        try container.encodeIfPresent(self.dose, forKey: .dose)
        try container.encode(self.strength, forKey: .strength)
        try container.encode(self.strengthType, forKey: .strengthType)
        try container.encode(self.type, forKey: .type)
    }
}
