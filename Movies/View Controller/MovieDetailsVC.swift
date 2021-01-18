//
//  MoviesListVC.swift
//  Moviesz
//
//  Created by Godwin  on 14/01/21.
//

import UIKit


class MovieDetailsVC: UIViewController{

    
    // MARK: - Properties
    let backgroundView = UIView()
    
    let titleLabel = UILabel()
    let subTitlelabel = UILabel()
    
    let ratingLabel = UILabel()
    let voteAveragelabel = UILabel()
    let voteCountLabel = UILabel()
    let languageLabel = UILabel()
    let releaseYearLabel = UILabel()
    let maximumDateLabel = UILabel()
    let minimumDateLabel = UILabel()

    
    
    
    let movieBannerImage = UIImageView()
    // MARK: - Methods
    override func viewDidLoad() {
        prepareView()
    }
    
    
    
    private func prepareView() {
        // Prepare Ui properties Constraints and positions

        
        // prepare ListTable
        view.addSubview(backgroundView)
        view.backgroundColor = .white
        backgroundView.prepareLayout(.top,constant: topbarHeight() + 10)
        backgroundView.prepareLayout(.bottom,constant: -10)
        backgroundView.prepareLayout(.leading,constant: 10)
        backgroundView.prepareLayout(.trailing,constant: -10)
        backgroundView.backgroundColor = .white
        backgroundView.cornerRadius(color: .lightGray)

        // prepare completedButton
        backgroundView.addSubview(movieBannerImage)
        movieBannerImage.prepareLayout(.leading,constant: 15)
        movieBannerImage.prepareLayout(.top,constant:  15)
        let height =  UIScreen.main.bounds.size.height/2
        let width =  UIScreen.main.bounds.size.width/2
        movieBannerImage.prepareHeight(constant: height)
        movieBannerImage.prepareWidth(constant: width)
        movieBannerImage.backgroundColor = .lightGray
        movieBannerImage.contentMode = .scaleAspectFill
        movieBannerImage.clipsToBounds = true
        movieBannerImage.cornerRadius(color: .lightGray)


        // prepare Title label
        backgroundView.addSubview(titleLabel)
        titleLabel.prepareLayout(.leading,constant: 15)
        titleLabel.prepareLayout(.trailing,constant: -15)
        titleLabel.prepareLayout(.top,constant: height + 60)
        titleLabel.prepareTextField(size: .title)

        // prepare Title label
        backgroundView.addSubview(subTitlelabel)
        subTitlelabel.prepareLayout(.leading,constant: 15)
        subTitlelabel.prepareLayout(.trailing,constant: -15)
        subTitlelabel.prepareLayout(.bottom,constant: -15)
        subTitlelabel.prepareLayout(.top,constant: height  + 60)
        subTitlelabel.prepareHeight(constant: 80)
        subTitlelabel.prepareTextField(size: .subtite)
        subTitlelabel.numberOfLines = 0
        
        // prepare Title label
        backgroundView.addSubview(releaseYearLabel)
        releaseYearLabel.prepareLayout(.leading,constant:  width + 25)
        releaseYearLabel.prepareLayout(.trailing,constant: -15)
        releaseYearLabel.prepareLayout(.top,constant:  10)
        releaseYearLabel.prepareTextField(size: .title)
        releaseYearLabel.numberOfLines = 0

        
        
        backgroundView.addSubview(ratingLabel)
        ratingLabel.prepareLayout(.leading,constant:  width + 25)
        ratingLabel.prepareLayout(.trailing,constant: -15)
        ratingLabel.prepareLayout(.top,constant:  60)
        ratingLabel.prepareTextField(size: .title)
        ratingLabel.textColor = .blue
        ratingLabel.numberOfLines = 0

        
        backgroundView.addSubview(voteAveragelabel)
        voteAveragelabel.prepareLayout(.leading,constant:  width + 25)
        voteAveragelabel.prepareLayout(.trailing,constant: -15)
        voteAveragelabel.prepareLayout(.top,constant: 90)
        voteAveragelabel.prepareTextField(size: .title)
        voteAveragelabel.numberOfLines = 0
        
        
        backgroundView.addSubview(voteCountLabel)
        voteCountLabel.prepareLayout(.leading,constant:  width + 25)
        voteCountLabel.prepareLayout(.trailing,constant: -15)
        voteCountLabel.prepareLayout(.top,constant: 140)
        voteCountLabel.prepareTextField(size: .title)
        voteCountLabel.numberOfLines = 0
        
        backgroundView.addSubview(languageLabel)
        languageLabel.prepareLayout(.leading,constant:  width + 25)
        languageLabel.prepareLayout(.trailing,constant: -15)
        languageLabel.prepareLayout(.top,constant: 170)
        languageLabel.prepareTextField(size: .title)
        languageLabel.numberOfLines = 0
        
        
        
        backgroundView.addSubview(maximumDateLabel)
        maximumDateLabel.prepareLayout(.leading,constant:  width + 25)
        maximumDateLabel.prepareLayout(.trailing,constant: -15)
        maximumDateLabel.prepareLayout(.top,constant: 200)
        maximumDateLabel.prepareTextField(size: .title)
        maximumDateLabel.numberOfLines = 0
        maximumDateLabel.isHidden = true
        
        
        backgroundView.addSubview(minimumDateLabel)
        minimumDateLabel.prepareLayout(.leading,constant:  width + 25)
        minimumDateLabel.prepareLayout(.trailing,constant: -15)
        minimumDateLabel.prepareLayout(.top,constant: 240)
        minimumDateLabel.prepareTextField(size: .title)
        minimumDateLabel.numberOfLines = 0
        maximumDateLabel.isHidden = false

    }

    func prepareData(movie: MovieModel) {
        
        titleLabel.text = movie.original_title
        title =  movie.title
        titleLabel.textColor = .blue
        subTitlelabel.text = movie.overview
        releaseYearLabel.text = "Release date: \(movie.release_date!)"
        releaseYearLabel.backgroundColor = .clear
        subTitlelabel.backgroundColor = .clear
        titleLabel.backgroundColor = .clear
        
        
        
        
        
        guard let path = movie.poster_path,
              let rating = movie.vote_average else { return }
        ratingLabel.text = "Ratings : " + rating.text + "★"
        
        voteAveragelabel.text = "Vote Average: " + movie.vote_average!.text
        voteCountLabel.text = "Vote Count: " + movie.vote_count!.text
        languageLabel.text = "Language: " + movie.original_language!.lang()
        let url = "https://image.tmdb.org/t/p/w500/" + path
        movieBannerImage.loadImageFrom(urlString: url)
    }
}
