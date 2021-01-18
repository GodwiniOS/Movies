//
//  MoviesListVC.swift
//  Moviesz
//
//  Created by Godwin  on 14/01/21.
//


import Foundation


protocol NetworkService {
    @discardableResult
    func dataRequest<T: Decodable>(_ endPoint: APIEndPoint,
                                   objectType: T.Type,
                                   completion: @escaping (Result<T, NetworkError>) -> Void) -> URLSessionDataTask
    
}

final class NetworkAPIClient: NetworkService {

    private let session: URLSession
    let urlCache =  URLCache.shared

    static var defaultSession: URLSession = {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 30
        if #available(iOS 11.0, *) {
            configuration.waitsForConnectivity = true
        }
        return URLSession(configuration: configuration)
    }()

    init(session: URLSession = NetworkAPIClient.defaultSession) {
        self.session = session
        urlCache.removeAllCachedResponses()
    }

    //MARK: DataRequest
    @discardableResult
    func dataRequest<T: Decodable>(_ endPoint: APIEndPoint,
                                   objectType: T.Type,
                                   completion: @escaping (Result<T, NetworkError>) -> Void) -> URLSessionDataTask {

        var request: URLRequest
        do {
            request = try endPoint.request(with: URL(string: endPoint.path)!)
        } catch {
            completion(.failure(error as! NetworkError))
            return URLSessionDataTask()
        }
        
        
        let dataTask = session.dataTask(with: request) { (data, response, error) in
        
            
            if let err = error as? URLError, err.code  == URLError.Code.notConnectedToInternet {
                completion(Result.failure(NetworkError.noInternet(err.code)))
                return
            }
        
            
            if let error = error as NSError?, error.domain == NSURLErrorDomain {
                completion(Result.failure(NetworkError.apiError(error)))
                return
            }
            
            guard let data = data, let response = response as? HTTPURLResponse else {
                completion(Result.failure(NetworkError.emptyData))
                return
            }
            
            guard response.statusCode == 200 else {
                completion(Result.failure(NetworkError.invalidStatusCode(response.statusCode)))
                return
            }

            guard let responseString = self.printJSON(data: data) else {
                return completion(Result.failure(.emptyData))
            }
            
//            print(responseString)
            
            do {
                let jsonObject = try JSONDecoder().decode(objectType, from: data)
                completion(Result.success(jsonObject))
            } catch {
                completion(Result.failure(NetworkError.decodingError(error as! DecodingError)))
            }
        }
        dataTask.resume()
        return dataTask
    }
}


extension NetworkAPIClient {
    
    func printJSON(data: Foundation.Data) -> String? {
        
        if let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] {
            
            if let jsonData  = try? JSONSerialization.data(withJSONObject: json, options: .prettyPrinted) {
                return String.init(data: jsonData, encoding: .utf8)
            }
        }
        return nil
    }
}
