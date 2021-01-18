//
//  MoviesListVC.swift
//  Moviesz
//
//  Created by Godwin  on 14/01/21.
//


import Foundation


enum NetworkError: Swift.Error, CustomStringConvertible {
    
    case apiError(Swift.Error)
    case invalidStatusCode(Int)
    case emptyData
    case invalidRequestURL(URL)
    case decodingError(DecodingError)
    case noInternet(URLError.Code)

    
    public var description: String {
        switch self {
        case let .apiError(error):
            return "Network Error: \(error.localizedDescription)"
        case let .decodingError(decodingError):
            return "Json Decoding Error: \(decodingError.localizedDescription)"
        case .emptyData:
            return "Empty response from the server"
        case let .invalidRequestURL(url):
            return "Invalid URL. Please check the endPoint: \(url.absoluteString)"
        case let .invalidStatusCode(status):
            return "Server is down with status code: \(status)"
        case .noInternet(_):
            return "No Internet"
        }
    }
}
