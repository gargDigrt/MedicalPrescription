//
//  Constants.swift
//  MedicalPrescription
//
//  Created by Vivek on 21/06/21.
//

import Foundation

enum AppConfig {
    
    static let apiBaseURL = "https://6082d0095dbd2c001757a8de.mockapi.io/api"
}

enum Storyboard: String {
    case main
    
    func name() -> String {return rawValue.capitalized}
}

enum NetworkingError: Error {
    case domainError
    case decodingError
    case connectivityError
    
}

enum HttpMethod: String {
    case get
    case post
}

let DEFAULT_PARAMS:[String: String] = [:]
