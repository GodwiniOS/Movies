//
//  MoviesListVC.swift
//  Moviesz
//
//  Created by Godwin  on 14/01/21.
//


import UIKit

enum FontSize: CGFloat {
    
    case title = 16
    case subtite = 10
}


enum ViewControllerType: String {
    case upcoming
    case top_rated
    
    var title: String {
        switch self {
        case .upcoming: return "Upcoming Movies"
        case .top_rated: return "Top Rated Movies"
        }
    }
}

var viewControllerType : ViewControllerType? = nil

enum AppTitle: String {

    case topRatedMovieTitle    = "Top Rated Movies"
    case upComingMovieTitle    = "Upcoming Movies"
}


