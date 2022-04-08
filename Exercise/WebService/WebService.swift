//
//  WebService.swift
//  Exercise
//
//  Created by Ankush Mahajan on 07/04/22.
//

import Foundation
import Alamofire

enum NetworkError: Error {
    case decodingError
    case domainError
    case urlError
}

enum HttpMethod: String {
    case get = "GET"
    case post = "POST"
}

struct Resource<T: Codable> {
    let url: URL
    var httpMethod: HttpMethod = .get
    var body: Data? = nil
}

extension Resource {
    init(url: URL) {
        self.url = url
    }
}

class Webservice {
    
    func load<T>(resource: Resource<T>, completion: @escaping (Result<T, NetworkError>) -> Void) {
        
        AF.request(resource.url).responseString { response in
            debugPrint(response.value as Any)
            
            let data = response.value?.data(using: .utf8) ?? Data()
            
            do {
                let model = try JSONDecoder().decode(T.self, from: data)
                debugPrint(model)
                completion(.success(model))
                
            } catch let error {
                debugPrint(error.localizedDescription)
                completion(.failure(.decodingError))
            }
            
        }
        
    }
    
}

