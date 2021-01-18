//
//  MoviesListVC.swift
//  Moviesz
//
//  Created by Godwin  on 14/01/21.
//


import UIKit

extension UITableView {

    func registerCell() {
        self.register(MovieTableViewCell.self, forCellReuseIdentifier: "MovieTableViewCell")
    }
}

