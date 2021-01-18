//
//  MoviesListVC.swift
//  Moviesz
//
//  Created by Godwin  on 14/01/21.
//

import UIKit

class MoviesListVC: UIViewController {

    // MARK: - Properties
    var movielistTV = UITableView()
    var movieListVM = MovieListViewModel()
    var refreshControl = UIRefreshControl()

    
    // MARK: - Methods
    override func viewWillAppear(_ animated: Bool) {
        prepareView()
    }

    private func prepareView() {
        

        self.navigationController?.navigationBar.topItem?.title = self.movieListVM.selectedVC.title

        // prepare ListTable
        view.addSubview(movielistTV)
        movielistTV.prepareLayout(.top,constant: topbarHeight())
        movielistTV.prepareLayout(.bottom)
        movielistTV.prepareLayout(.leading)
        movielistTV.prepareLayout(.trailing)
        movielistTV.registerCell()
        movielistTV.delegate = self
        movielistTV.dataSource = self
        movielistTV.separatorStyle = .none
        
        refreshControl.attributedTitle = NSAttributedString(string: "refreshing")
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        movielistTV.addSubview(refreshControl)
        
        movieListVM.delegate = self
        }
    

        
    @objc func refresh(_ sender: AnyObject) {
        movieListVM.pageNumber = 1
        movieListVM.getMovieList()
    }
    

    
    
    func reloadTable(animation: Bool = true){

        DispatchQueue.main.async {

        self.refreshControl.endRefreshing()

        guard animation else {
            // without animation
            self.movielistTV.reloadData()
            return
        }
        // with animation
            UIView.transition(with: self.movielistTV,
                          duration: 0.5,
                          options: .transitionCrossDissolve,
                          animations: {
                            self.movielistTV.reloadData()
                          })
        }
    }
}


extension MoviesListVC: UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        movieListVM.movieCount
    }
    
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let movieTVC = tableView.dequeueReusableCell(withIdentifier: "MovieTableViewCell", for: indexPath) as! MovieTableViewCell
        movieTVC.prepareCell(movie: movieListVM.getMovie(indexPath.row))
        return movieTVC
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = MovieDetailsVC()
        vc.prepareData(movie: movieListVM.getMovie(indexPath.row))
        navigationController?.pushViewController(vc, animated: true)
    }
}



extension MoviesListVC: MovieListVMDelegate {
    func reloadData(isFirstPage: Bool) {
        reloadTable(animation: isFirstPage)
    }
    
    
    func showError(error: String) {
        showToast(message: error)
        DispatchQueue.main.async {
            self.refreshControl.endRefreshing()
        }
    }
}
