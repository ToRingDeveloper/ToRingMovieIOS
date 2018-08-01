//
//  PopularMovieItemCellCollectionViewCell.swift
//  ToRingMovie
//
//  Created by TR on 8/1/18.
//  Copyright © 2018 ToRing. All rights reserved.
//

import UIKit
import Kingfisher

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
    
    lazy var viewContent : UIView = {
        let viewContent = UIView()
        return viewContent
    }()
    
    lazy var titleLabel : UILabel = {
        let titleLabel = UILabel()
        titleLabel.textColor = UIColor.init(rgb: ColorCons.TEXT_PRIMARY)
        titleLabel.font  = UIFont.boldSystemFont(ofSize: TextSizeContant.NORMAL)
        titleLabel.textAlignment = .right
        return titleLabel
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
        self.viewContent.addSubview(titleLabel)
        
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
        
        self.viewContent.snp.makeConstraints { (make) in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(50)
        }
        
        self.titleLabel.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(10)
            make.top.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
            make.bottom.equalToSuperview().offset(-10)
        }
    }
    
    func setData(movie : Movie) {
        self.movie = movie
        let url = URL(string:  GetImageURLUtil.getBackdropImageURL(movie.backdrop_path))
        self.movieImage.kf.setImage(with: url)
        self.titleLabel.text = movie.title
        
        
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = CGRect(x: 0, y: 0, width: self.contentView.frame.width, height: 50)
        let color1 = UIColor.clear.cgColor
        let color2 = UIColor.init(rgb:ColorCons.BACKGROUND).cgColor
        gradientLayer.colors = [color1, color2]
        gradientLayer.locations = [0.0, 1.0]
        viewContent.layer.addSublayer(gradientLayer)
    }
}
