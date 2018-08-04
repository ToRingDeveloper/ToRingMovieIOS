//
//  AnotherMoveItemCell.swift
//  ToRingMovie
//
//  Created by TR on 8/3/18.
//  Copyright © 2018 ToRing. All rights reserved.
//

import UIKit

class AnotherMoveItemCell: UICollectionViewCell {
    var movie: Movie?
    
    lazy var safeView : UIView = {
        let safeView  = UIView()
        return safeView
    }()
    
    lazy var movieImage : UIImageView = {
        let movieImage = UIImageView()
        return movieImage
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addComponent()
    }
    
    func addComponent() {
        self.contentView.addSubview(safeView)
        self.safeView.addSubview(movieImage)
        
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
    }
    
    func setData(movie : Movie?) {
        self.movie = movie
        let url = URL(string: GetImageURLUtil.getPosterImageURL((movie?.backdrop_path)!))
        self.movieImage.kf.setImage(with: url)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
