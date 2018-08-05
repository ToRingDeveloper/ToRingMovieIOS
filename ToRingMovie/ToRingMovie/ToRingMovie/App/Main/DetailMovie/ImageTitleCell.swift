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
        return backdropImage
    }()
    
    lazy var posterImage : UIImageView = {
        let posterImage = UIImageView()
        posterImage.contentMode = .scaleAspectFill
        posterImage.layer.cornerRadius = 3
        posterImage.layer.shadowColor = UIColor.init(rgb: ColorCons.BACKGROUND_LIGHT).cgColor
        posterImage.layer.shadowRadius = 5
        posterImage.layer.shadowOffset = CGSize(width: 2, height: 2)
        posterImage.layer.shadowOpacity = 0.9
        posterImage.clipsToBounds = true
        return posterImage
    }()

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addComponent()
    }
    
    func addComponent(){
        self.contentView.addSubview(backdropImage)
        self.contentView.addSubview(posterImage)
        
        self.backdropImage.snp.makeConstraints { (make) in
            make.leading.top.trailing.equalToSuperview()
            make.height.equalTo(backdropImage.snp.width).multipliedBy(0.5)
        }
        self.posterImage.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(10)
            make.bottom.equalToSuperview()
            let height = UIScreen.main.bounds.width * (4/10)
            make.height.equalTo(height)
            make.width.equalTo(posterImage.snp.height).multipliedBy(0.8)
        }
    }
    
    func setData(movie: Movie?){
        self.movie = movie
        let backdropURL = URL(string: GetImageURLUtil.getBackdropImageURL(movie!.backdrop_path))
        self.backdropImage.kf.setImage(with: backdropURL)
        let posterURL = URL(string: GetImageURLUtil.getPosterImageURL(movie!.poster_path))
        self.posterImage.kf.setImage(with: posterURL)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
