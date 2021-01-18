//
//  MoviesListVC.swift
//  Moviesz
//
//  Created by Godwin  on 14/01/21.
//

import Foundation

protocol MovieListVMDelegate: AnyObject {
    func reloadData(isFirstPage: Bool)
    func showError(error: String)
}




class MovieListViewModel {
    
    // MARK: - Properties
    weak var delegate : MovieListVMDelegate?
    var interacter:APIInteracter!
    
    var movieCount: Int {
            return movies.count
    }
        
    var movies : [MovieModel] = []
    
    var selectedVC: ViewControllerType = .top_rated
    var pageNumber: Int = 1
    
    // MARK: - Methods
    init() {
        interacter = APIInteracter(presenter: self)
        interacter.interaction = self
        getMovieList()
    }
    
    func getMovie(_ index: Int) -> MovieModel {
        if movies.count-1 == index {
            // PagingNation
            pageNumber += 1
            getMovieList()
        }
        return movies[index]
    }

    
    func noOfRows(in section: Int) -> Int {
        movies.count
    }
    

    func getMovieList() {
        if let vc = viewControllerType ,vc == .upcoming {
            viewControllerType = .top_rated
        } else {
            viewControllerType = .upcoming
        }
        selectedVC = viewControllerType!
        interacter.getMovieList(type: selectedVC, pageNumber: pageNumber)
    }
    
}




extension MovieListViewModel: APIResponse {
    
    func getMovieList(movies: [MovieModel]) {
        self.movies += movies
        delegate?.reloadData(isFirstPage: pageNumber == 1)
    }
    
    func getMovieListFailed(with error: NetworkError) {
        delegate?.showError(error: error.localizedDescription)
    }
}
