//
//  SecondMovieItemCell.swift
//  ToRingMovie
//
//  Created by TR on 8/3/18.
//  Copyright © 2018 ToRing. All rights reserved.
//

import UIKit

class SecondMovieItemCell: UICollectionViewCell {
    var title : String?
    var movie : Movie?
    
    lazy var safeView : UIView = {
        let safeView = UIView()
        safeView.layer.cornerRadius = 3
        safeView.layer.shadowRadius = 5
        safeView.layer.shadowOffset = CGSize(width: 5, height: 5)
        safeView.layer.shadowColor = UIColor.init(rgb: ColorCons.BACKGROUND_LIGHT).cgColor
        safeView.backgroundColor = UIColor.init(rgb: ColorCons.BACKGROUND_LIGHT)
        safeView.clipsToBounds = true
        return safeView
    }()
    
    lazy var iconImage : UIImageView = {
        let iconImage = UIImageView()
        return iconImage
    }()
    
    lazy var statusLabel : UILabel = {
        let statusLabel = UILabel()
        statusLabel.font = UIFont.systemFont(ofSize: TextSizeContant.MINI)
        statusLabel.textColor = UIColor.init(rgb: ColorCons.TEXT_SECONDARY)
        statusLabel.numberOfLines = 1
        return statusLabel
    }()
    
    lazy var titleLabel : UILabel = {
        let titleLabel = UILabel()
        titleLabel.font = UIFont.boldSystemFont(ofSize: TextSizeContant.SMALL)
        titleLabel.textColor = UIColor.init(rgb: ColorCons.TEXT_PRIMARY)
        titleLabel.numberOfLines = 1
        return titleLabel
    }()
    
    lazy var movieImage  : UIImageView = {
        let movieImage = UIImageView()
        movieImage.contentMode = .scaleAspectFill
        movieImage.clipsToBounds = true
        return movieImage
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addComponent()
    }
    
    func addComponent(){
        self.contentView.addSubview(safeView)
        self.safeView.addSubview(movieImage)
        self.safeView.addSubview(iconImage)
        self.safeView.addSubview(statusLabel)
        self.safeView.addSubview(titleLabel)
        
        self.safeView.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(5)
            make.top.equalToSuperview().offset(5)
            make.trailing.equalToSuperview().offset(-5)
            make.bottom.equalToSuperview().offset(-5)
        }
        
        self.statusLabel.snp.makeConstraints { (make) in
            make.left.equalTo(iconImage.snp.right).offset(5)
            make.trailing.equalToSuperview().offset(-5)
            make.bottom.equalToSuperview().offset(-5)
            make.height.equalTo(self.statusLabel.font.lineHeight)
        }
        
        self.iconImage.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(5)
            make.bottom.equalTo(statusLabel.snp.bottom)
            make.top.equalTo(statusLabel.snp.top)
            make.width.equalTo(iconImage.snp.height)
        }
        
        self.titleLabel.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(5)
            make.trailing.equalToSuperview().offset(-5)
            make.bottom.equalTo(statusLabel.snp.top).offset(-5)
            make.height.equalTo(self.titleLabel.font.lineHeight)
        }
        
        self.movieImage.snp.makeConstraints { (make) in
            make.leading.equalToSuperview()
            make.top.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalTo(titleLabel.snp.top).offset(-5)
        }
    }
    
    func  setData(title: String, movie: Movie?) {
        self.movie = movie
        let url = URL(string: GetImageURLUtil.getBackdropImageURL(movie!.poster_path))
        self.movieImage.kf.setImage(with: url)
        self.titleLabel.text = movie?.title
        switch title {
        case "Upcoming":
            self.iconImage.backgroundColor = UIColor.green
            self.statusLabel.text = movie!.release_date
        case "Now playing":
            self.iconImage.backgroundColor = UIColor.blue
            self.statusLabel.text = movie!.vote_count.formatWithSeparator() + " votes"
        case "Top rate":
            self.iconImage.backgroundColor = UIColor.init(rgb: ColorCons.APP_COLOR)
            self.statusLabel.text = movie!.vote_average.formatWithSeparator()
        default:
            break
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
