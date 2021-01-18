//
//  MoviesListVC.swift
//  Moviesz
//
//  Created by Godwin  on 14/01/21.
//


import UIKit


class MovieTableViewCell: UITableViewCell {

    let backGroundView = UIView()
    let titleLabel = UILabel()
    let subTitlelabel = UILabel()
    let releaseYearLabel = UILabel()
    
    let ratingLabel = UILabel()
    let movieBannerImage = UIImageView()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        prepareTableViewCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func prepareTableViewCell() {
        

        // prepare Background
        backgroundColor = .clear
        selectionStyle = .none
        contentView.backgroundColor = .clear
        contentView.superview?.backgroundColor = .clear
        contentView.prepareHeight(constant: 160)
        contentView.addSubview(backGroundView)

        backGroundView.prepareLayout(.leading,constant: 10)
        backGroundView.prepareLayout(.trailing,constant: -10)
        backGroundView.prepareLayout(.top,constant: 10)
        backGroundView.prepareLayout(.bottom)
        backGroundView.cornerRadius(color: .lightGray)

        // prepare completedButton
        backGroundView.addSubview(movieBannerImage)
        movieBannerImage.prepareLayout(.leading,constant: 15)
        movieBannerImage.prepareLayout(.top,constant: 15)
        movieBannerImage.prepareLayout(.bottom,constant: -15)
        movieBannerImage.prepareHeight(constant: 120)
        movieBannerImage.prepareWidth(constant: 100)
        movieBannerImage.backgroundColor = .lightGray
        movieBannerImage.contentMode = .scaleAspectFill
        movieBannerImage.clipsToBounds = true

        // prepare importantButton
        backGroundView.addSubview(ratingLabel)
        ratingLabel.prepareLayout(.trailing, constant: -5)
        ratingLabel.prepareLayout(.bottom,constant: -5)
        ratingLabel.prepareHeight(constant: 40)
        ratingLabel.prepareWidth(constant: 60)
        ratingLabel.prepareTextField(size: .title)
        ratingLabel.textColor = .blue
        

        // prepare Title label
        backGroundView.addSubview(titleLabel)
        titleLabel.prepareLayout(.leading,constant: 130)
        titleLabel.prepareLayout(.top,constant: 15)
        titleLabel.prepareLayout(.trailing,constant: -15)
        titleLabel.prepareTextField(size: .title)
        titleLabel.backgroundColor = .lightGray
        titleLabel.numberOfLines = 0

        // prepare Title label
        backGroundView.addSubview(subTitlelabel)
        subTitlelabel.prepareLayout(.leading,constant: 130)
        subTitlelabel.prepareLayout(.trailing,constant: -15)
        subTitlelabel.prepareLayout(.top,constant: 50)
        subTitlelabel.prepareHeight(constant: 60)

        subTitlelabel.backgroundColor = .lightGray
        subTitlelabel.prepareTextField(size: .subtite)
        subTitlelabel.numberOfLines = 0


        // prepare Title label
        backGroundView.addSubview(releaseYearLabel)
        releaseYearLabel.prepareLayout(.leading,constant: 130)
        releaseYearLabel.prepareLayout(.bottom,constant: -15)
        releaseYearLabel.prepareLayout(.trailing,constant: -15)
        releaseYearLabel.prepareTextField(size: .subtite)
        releaseYearLabel.backgroundColor = .lightGray

    }
    
    func prepareCell(movie: MovieModel){

        titleLabel.text = movie.title
        subTitlelabel.text = movie.overview
        releaseYearLabel.text = "Release data: \(movie.release_date!)"
        releaseYearLabel.backgroundColor = .clear
        subTitlelabel.backgroundColor = .clear
        subTitlelabel.textColor = .gray
        titleLabel.backgroundColor = .clear
        guard let path = movie.poster_path,
              let rating = movie.vote_average else { return }
        ratingLabel.text = rating.text + " ★"
        let url = "https://image.tmdb.org/t/p/w500/" + path
        movieBannerImage.loadImageFrom(urlString: url)
    }
}
