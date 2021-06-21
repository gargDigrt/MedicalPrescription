//
//  Resource.swift
//  MedicalPrescription
//
//  Created by Vivek on 09/06/21.
//

import Foundation


/// A model class for the resource to form a URLRequest
struct Resource<T: Codable> {
    var urlRequest: URLRequest

    // MARK: - Initializer
    
    
    /// This will make a network call
    /// - Parameters:
    ///   - url: Url for the web service to be called
    ///   - params: Parameters for the web service call.
    ///   - method: method type GET/POST
    init(_ url: String,_ params: [String: String] = DEFAULT_PARAMS,_ method: HttpMethod = .get) {
        var urlComp = URLComponents(string: url)!
        var queries:[URLQueryItem] = []
        for key in params.keys{
           let newQuery = URLQueryItem(name: key, value: params[key])
            queries.append(newQuery)
        }
        urlComp.queryItems = queries
        urlRequest = URLRequest(url: urlComp.url!)
        urlRequest.httpMethod = method.rawValue
    }
}
