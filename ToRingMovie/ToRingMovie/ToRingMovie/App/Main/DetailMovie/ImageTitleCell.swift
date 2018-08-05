//
//  ImageTitleCellCell.swift
//  ToRingMovie
//
//  Created by TR on 8/4/18.
//  Copyright © 2018 ToRing. All rights reserved.
//

import UIKit

class ImageTitleCell: UITableViewCell {
    var movie : Movie?
    
    lazy var backdropImage : UIImageView = {
        let backdropImage = UIImageView()
        backdropImage.contentMode = .scaleAspectFill
        backdropImage.backgroundColor = UIColor.init(rgb: ColorCons.BACKGROUND)
        backdropImage.clipsToBounds = true
        return backdropImage
    }()
    
    lazy var posterImage : UIImageView = {
        let posterImage = UIImageView()
        posterImage.contentMode = .scaleAspectFill
        posterImage.layer.cornerRadius = 3
        posterImage.layer.shadowColor = UIColor.init(rgb: ColorCons.BACKGROUND).cgColor
        posterImage.layer.shadowRadius = 5
        posterImage.layer.shadowOffset = CGSize(width: 2, height: 2)
        posterImage.layer.shadowOpacity = 0.9
        posterImage.backgroundColor = UIColor.init(rgb: ColorCons.BACKGROUND_LIGHT)
        return posterImage
    }()
    
    lazy var releaseYearLabel : UILabel = {
        let releaseYearLabel = UILabel()
        releaseYearLabel.font = UIFont.systemFont(ofSize: TextSizeContant.SMALL)
        releaseYearLabel.textColor = UIColor.init(rgb: ColorCons.TEXT_SECONDARY)
        releaseYearLabel.textAlignment = .center
        releaseYearLabel.layer.borderColor = UIColor.init(rgb: ColorCons.TEXT_SECONDARY).cgColor
        releaseYearLabel.layer.borderWidth = 1
        releaseYearLabel.text = "2017"
        return releaseYearLabel
    }()
    
    lazy var dot : UIView = {
        let dot = UIView()
        dot.backgroundColor = UIColor.init(rgb: ColorCons.TEXT_SECONDARY)
        dot.layer.cornerRadius = 3
        return dot
    }()
    
    lazy var movieNameLabel : UILabel = {
        let movieNameLabel = UILabel()
        movieNameLabel.font = UIFont.boldSystemFont(ofSize: TextSizeContant.NORMAL)
        movieNameLabel.textColor = UIColor.init(rgb: ColorCons.TEXT_PRIMARY)
        movieNameLabel.lineBreakMode = .byWordWrapping
        movieNameLabel.numberOfLines = 0
        return movieNameLabel
    }()

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addComponent()
    }
    
    func addComponent(){
        self.contentView.addSubview(backdropImage)
        self.contentView.addSubview(posterImage)
        self.contentView.addSubview(releaseYearLabel)
        self.contentView.addSubview(dot)
        self.contentView.addSubview(movieNameLabel)
        
        self.backdropImage.snp.makeConstraints { (make) in
            make.leading.top.trailing.equalToSuperview()
            make.height.equalTo(backdropImage.snp.width).multipliedBy(0.5)
        }
        self.posterImage.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(10)
            make.bottom.equalToSuperview()
            let height = UIScreen.main.bounds.width * (4/10)
            make.height.equalTo(height)
            make.width.equalTo(posterImage.snp.height).multipliedBy(185.0/287.0)
        }
        self.releaseYearLabel.snp.makeConstraints { (make) in
            make.left.equalTo(posterImage.snp.right).offset(10)
            make.top.equalTo(backdropImage.snp.bottom).offset(10)
            make.height.equalTo(releaseYearLabel.font.lineHeight + 5)
            make.width.equalTo("2017".width(withConstrainedHeight: releaseYearLabel.font.lineHeight, font: releaseYearLabel.font) + 10)
        }
        self.dot.snp.makeConstraints { (make) in
            make.left.equalTo(releaseYearLabel.snp.right).offset(10)
            make.height.equalTo(6)
            make.width.equalTo(6)
            make.centerY.equalTo(releaseYearLabel.snp.centerY)
        }
        self.movieNameLabel.snp.makeConstraints { (make) in
            make.left.equalTo(posterImage.snp.right).offset(10)
            make.top.equalTo(releaseYearLabel.snp.bottom).offset(5)
            make.trailing.equalToSuperview()
            make.height.equalTo(50)
        }
    }
    
    func setData(movie: Movie?){
        self.movie = movie
        let backdropURL = URL(string: GetImageURLUtil.getBackdropImageURL(movie!.backdrop_path))
        self.backdropImage.kf.setImage(with: backdropURL)
        let posterURL = URL(string: GetImageURLUtil.getPosterImageURL(movie!.poster_path))
        self.posterImage.kf.setImage(with: posterURL)
        self.movieNameLabel.text = movie!.title
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
