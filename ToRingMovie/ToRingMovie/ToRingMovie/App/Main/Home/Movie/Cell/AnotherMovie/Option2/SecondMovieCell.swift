//
//  AnotherMovieCellCell.swift
//  ToRingMovie
//
//  Created by TR on 8/3/18.
//  Copyright © 2018 ToRing. All rights reserved.
//

import UIKit

class SecondMovieCell: UITableViewCell {
    var title : String?
    var movieRSP : MovieRSP?
    
    lazy var titleLabel : UILabel = {
        let titleLabel = UILabel()
        titleLabel.font = UIFont.boldSystemFont(ofSize: TextSizeContant.MINI)
        titleLabel.textColor = UIColor.init(rgb: ColorCons.TEXT_PRIMARY)
        return titleLabel
    }()
    
    lazy var seeAllLabel : UILabel = {
        let seeAllLabel = UILabel()
        seeAllLabel.font = UIFont.boldSystemFont(ofSize: TextSizeContant.MINI)
        seeAllLabel.textColor = UIColor.init(rgb: ColorCons.APP_COLOR)
        seeAllLabel.text = "See All"
        return seeAllLabel
    }()
    
    lazy var iconNextImage : UIImageView = {
        let iconNextImage = UIImageView()
        iconNextImage.contentMode = .scaleAspectFit
        iconNextImage.image = #imageLiteral(resourceName: "ic_next")
        return iconNextImage
    }()
    
    lazy var movieCV : UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = 0
        flowLayout.scrollDirection = .horizontal
        let movieCV = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        movieCV.backgroundColor = UIColor.init(rgb: ColorCons.BACKGROUND)
        return movieCV
    }()
    
    
    func setData(title :String, movieRSP : MovieRSP?) {
        self.title = title
        self.movieRSP = movieRSP
        self.titleLabel.text = title
        self.movieCV.reloadData()
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addComponent()
        registerCell()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addComponent() {
        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(iconNextImage)
        self.contentView.addSubview(seeAllLabel)
        self.contentView.addSubview(movieCV)
        
        self.titleLabel.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(5)
            make.top.equalToSuperview().offset(10)
            make.trailing.equalToSuperview()
            make.height.equalTo(titleLabel.font.lineHeight)
        }
        
        self.iconNextImage.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.top)
            make.trailing.equalToSuperview().offset(-5)
            make.bottom.equalTo(titleLabel.snp.bottom)
            make.width.equalTo(iconNextImage.snp.height)
        }
        
        self.seeAllLabel.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.top).offset(-5)
            make.trailing.equalToSuperview()
            make.bottom.equalTo(titleLabel.snp.bottom).offset(5)
            let height = seeAllLabel.font.lineHeight
            let width = "See All".width(withConstrainedHeight: height, font: seeAllLabel.font) + height + 7
            make.width.equalTo(width)
        }
        
        self.movieCV.snp.makeConstraints { (make) in
            make.leading.equalToSuperview()
            make.top.equalTo(self.titleLabel.snp.bottom).offset(5)
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview().offset(-10)
        }
    }
    
    func registerCell() {
        self.movieCV.dataSource = self
        self.movieCV.delegate = self
        self.movieCV.register(SecondMovieItemCell.self, forCellWithReuseIdentifier: "SecondMovieItemCell")
    }
}

extension SecondMovieCell: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let count = movieRSP?.results.count{
            return count
        }else{
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SecondMovieItemCell", for: indexPath) as! SecondMovieItemCell
        cell.setData(title: title! ,movie: movieRSP!.results[indexPath.row])
        return cell
    }
    
    
}

extension SecondMovieCell: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width/3, height: collectionView.frame.height)
    }
}
