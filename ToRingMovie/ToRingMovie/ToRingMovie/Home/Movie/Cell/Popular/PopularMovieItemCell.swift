//
//  PopularMovieItemCellCollectionViewCell.swift
//  ToRingMovie
//
//  Created by TR on 8/1/18.
//  Copyright © 2018 ToRing. All rights reserved.
//

import UIKit
import Kingfisher
import Cosmos

class PopularMovieItemCell: UICollectionViewCell {
    var movie: Movie?
    
    lazy var safeView : UIView = {
        let safeView  = UIView()
        return safeView
    }()
    
    lazy var movieImage : UIImageView = {
        let movieImage = UIImageView()
        movieImage.contentMode = UIViewContentMode.scaleAspectFill
        return movieImage
    }()
    
    lazy var ratingBar :  CosmosView = {
        let ratingBar = CosmosView()
        ratingBar.settings.filledBorderWidth = 1
        ratingBar.settings.filledColor = UIColor.init(rgb: ColorCons.APP_COLOR)
        ratingBar.settings.emptyBorderColor = UIColor.init(rgb: ColorCons.APP_COLOR)
        ratingBar.settings.filledBorderColor = UIColor.init(rgb: ColorCons.APP_COLOR)
        ratingBar.settings.starSize = 15
        ratingBar.settings.starMargin = 5
        ratingBar.settings.fillMode = .precise
        ratingBar.settings.updateOnTouch = false
        return ratingBar
    }()
    
    lazy var voteCountLabel : UILabel = {
        let voteCountLabel = UILabel()
        voteCountLabel.textColor = UIColor.init(rgb: ColorCons.TEXT_SECONDARY)
        voteCountLabel.font  = UIFont.systemFont(ofSize: TextSizeContant.SMALL)
        voteCountLabel.textAlignment = .right
        voteCountLabel.numberOfLines = 1
        return voteCountLabel
    }()
    
    lazy var titleLabel : UILabel = {
        let titleLabel = UILabel()
        titleLabel.textColor = UIColor.init(rgb: ColorCons.TEXT_PRIMARY)
        titleLabel.font  = UIFont.boldSystemFont(ofSize: TextSizeContant.NORMAL)
        titleLabel.numberOfLines = 1
        titleLabel.textAlignment = .right
        return titleLabel
    }()
    
    lazy var gradientLayer : CAGradientLayer = {
        let gradientLayer = CAGradientLayer()
        let height = 10 + titleLabel.font.lineHeight + 5 + 15 + 10
        gradientLayer.frame = CGRect(x: 0, y: 0, width: self.contentView.frame.width, height: height)
        let color1 = UIColor.clear.cgColor
        let color2 = UIColor.init(rgb:ColorCons.BACKGROUND).cgColor
        gradientLayer.colors = [color1, color2]
        gradientLayer.locations = [0.0, 1.0]
        return gradientLayer
    }()
    
    lazy var viewContent : UIView = {
        let viewContent = UIView()
        viewContent.layer.insertSublayer(gradientLayer, at: 0)
        return viewContent
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addComponent()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addComponent() {
        self.contentView.addSubview(safeView)
        self.safeView.addSubview(movieImage)
        self.safeView.addSubview(viewContent)
        self.safeView.addSubview(titleLabel)
        self.safeView.addSubview(ratingBar)
        self.safeView.addSubview(voteCountLabel)
        
        self.safeView.snp.makeConstraints { (make) in
            make.leading.equalToSuperview()
            make.top.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        self.movieImage.snp.makeConstraints { (make) in
            make.leading.equalToSuperview()
            make.top.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }

        self.ratingBar.snp.makeConstraints { (make) in
            make.trailing.equalToSuperview().offset(-10)
            make.bottom.equalToSuperview().offset(-10)
            make.height.equalTo(15)
            make.width.equalTo(95)
        }
        
        self.voteCountLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(10)
            make.right.equalTo(ratingBar.snp.left).offset(-10)
            make.bottom.equalTo(ratingBar.snp.bottom)
            make.top.equalTo(ratingBar.snp.top)
        }
        
        self.titleLabel.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
            make.bottom.equalTo(ratingBar.snp.top)
            make.height.equalTo(titleLabel.font.lineHeight)
        }
        
        self.viewContent.snp.makeConstraints { (make) in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
            make.top.equalTo(titleLabel.snp.top).offset(-10)
        }
    }
    
    func setData(movie : Movie) {
        self.movie = movie
        let url = URL(string:  GetImageURLUtil.getBackdropImageURL(movie.backdrop_path))
        self.movieImage.kf.setImage(with: url)
        self.titleLabel.text = movie.title
        self.ratingBar.rating = movie.vote_average/2
        self.voteCountLabel.text = "\(movie.vote_count.formatWithSeparator()) votes"
    }
}
