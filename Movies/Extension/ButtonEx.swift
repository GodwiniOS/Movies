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

}


extension String {
    func lang() -> String {
        if self == "hi" {
            return "Hindi"
        } else {
            return "English"
        }
        
    }
}

