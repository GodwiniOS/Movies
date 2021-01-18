//
//  MoviesListVC.swift
//  Moviesz
//
//  Created by Godwin  on 14/01/21.
//


import UIKit

extension UIButton {


    
    func setTitle(_ title: AppTitle) {
        setTitle(title.rawValue, for: .normal)
    }
    
    func prepareFavButton() {
        titleLabel?.font = UIFont.systemFont(ofSize: 30)
    }
}


//extension UIColor {
//    var theme {
//        return
//    }
//}
