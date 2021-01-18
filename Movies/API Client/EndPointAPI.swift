//
//  MoviesListVC.swift
//  Moviesz
//
//  Created by Godwin  on 14/01/21.
//


import Foundation

struct APIEndPoint {
    
    var path: String
    var method: HTTPType
    var parameters: Codable?
    var headers: [String: String]? {
        
        return [
            "Accept": "application/json",
            "Content-Type": "application/json"
        ]
    }
    
    
    enum HTTPType: String {
        case GET, POST
    }
    
    
    func request(with baseURL: URL) throws -> URLRequest {
        let finalURL = path.contains("http") ? URL(string: path) : baseURL.appendingPathComponent(path)
        
        guard let components = URLComponents(url: finalURL!, resolvingAgainstBaseURL: false) else {
            fatalError("Unable to create URL components")
        }

        guard let url = components.url else {
            let URL = baseURL
            throw NetworkError.invalidRequestURL(URL.appendingPathComponent(path))
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        if let parameters = parameters {
            let requestJSON = try? parameters.encode()
            request.httpBody = requestJSON
        }
        
        var headers = request.allHTTPHeaderFields ?? [:]
        headers["Content-Type"] = "application/json"
//        headers["api_key"] = "61a7976d77210f1e1893b89cd640fa88"
//        headers["language"] = "en-US"

        request.allHTTPHeaderFields = headers
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        return request
    }
}


extension Encodable {
    func encode(with encoder: JSONEncoder = JSONEncoder()) throws -> Foundation.Data {
        encoder.keyEncodingStrategy = .useDefaultKeys
        return try encoder.encode(self)
    }
}

extension Decodable {
    static func decode(with decoder: JSONDecoder = JSONDecoder(), from data: Foundation.Data) throws -> Self {
        return try decoder.decode(Self.self, from: data)
    }
}
