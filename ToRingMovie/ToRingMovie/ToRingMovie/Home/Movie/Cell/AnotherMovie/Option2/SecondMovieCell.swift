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
        titleLabel.font = UIFont.boldSystemFont(ofSize: TextSizeContant.SMALL)
        titleLabel.textColor = UIColor.init(rgb: ColorCons.TEXT_PRIMARY)
        return titleLabel
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
        self.contentView.addSubview(movieCV)
        
        self.titleLabel.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(5)
            make.top.equalToSuperview().offset(5)
            make.trailing.equalToSuperview()
            make.height.equalTo(titleLabel.font.lineHeight)
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
