//
//  APIServices.swift
//  MedicalPrescription
//
//  Created by Vivek on 21/06/21.
//

import Foundation

/// APIServices
/// Contains methods for API service requests
class HTTPClient {
    
    static let shared = HTTPClient()
    
    // MARK: - Services
    /// Method to request URLRequest
    /// - Parameters:
    ///   - resource: Resource of generic type
    ///   - completion: Result object
    func load<T>(resource: Resource<T>, completion: @escaping(Result<T, NetworkingError>) -> Void) {
        
        URLSession.shared.dataTask(with: resource.urlRequest){ data, response, error in
            
            guard let data = data, error == nil else {
                completion(.failure(.domainError))
                return
            }
            let decoded = try? JSONDecoder().decode(T.self, from: data)
            if let result = decoded {
                completion(.success(result))
            } else {
                completion(.failure(.decodingError))
            }
        }.resume()
    }
    
    
}
