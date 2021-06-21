//
//  MedicineRequests.swift
//  MedicalPrescription
//
//  Created by Vivek on 21/06/21.
//

import Foundation

/// Enum to generate Movie Request
enum MedicineRequests {
    
    //Reuest Subtype
    case medicine
    
    
    /// Method to generate end point on the basis of subtype
    /// - Returns: This will return final endpoint for URL
    func getEndPoint() -> String {
        var nextString = ""
        switch self {
        case .medicine:
            nextString = "/medicines"
        }
        
        let finalUrlString = AppConfig.apiBaseURL + nextString
        return finalUrlString
    }
}
