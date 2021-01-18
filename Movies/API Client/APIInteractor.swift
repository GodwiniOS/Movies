//
//  MoviesListVC.swift
//  Moviesz
//
//  Created by Godwin  on 14/01/21.
//


import Foundation

protocol APIServices: AnyObject {
    func getMovieList(type: ViewControllerType,pageNumber: Int)
}

protocol APIResponse: AnyObject {
    func getMovieList(movies: [MovieModel])
    func getMovieListFailed(with error: NetworkError)
}

class APIInteracter : APIServices {
    
    // MARK:- Properties

    weak var interaction:APIResponse!
    
    let domainURL = "https://api.themoviedb.org/3/movie/"
    let key = "?api_key=61a7976d77210f1e1893b89cd640fa88"
    let language = "&language=en-US&page="
    var pageNumber: Int = 1
    
    init(presenter:APIResponse) {
        self.interaction = presenter
    }
    

    
    func getMovieList(type: ViewControllerType,pageNumber: Int){
        
        let url = domainURL + type.rawValue + key + language + pageNumber.text
        let endPoint = APIEndPoint(path: url,
                                              method: .GET,
                                              parameters: nil)
        
        NetworkAPIClient().dataRequest(endPoint, objectType: ResponseBase.self) { [weak self] (result: Result<ResponseBase, NetworkError>) in
            guard let self = self else { return }
            switch result {
            case let .success(response):
                self.interaction.getMovieList(movies: response.results ?? [])
                self.pageNumber += 1
            case let .failure(error):
                self.interaction.getMovieListFailed(with: error)
            }
        }
    }
}
