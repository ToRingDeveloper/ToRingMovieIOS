//
//  AnotherMoviePageCell.swift
//  ToRingMovie
//
//  Created by TR on 8/2/18.
//  Copyright © 2018 ToRing. All rights reserved.
//

import UIKit

class AnotherMoviePageCell: UICollectionViewCell {
    var movieRSP : MovieRSP?
    
    lazy var movieCV : UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
        let movieCV = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        movieCV.backgroundColor = .red
        movieCV.isScrollEnabled = false
        return movieCV
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addComponent()
        registerCell()
    }
    
    func addComponent(){
        self.contentView.addSubview(movieCV)
        
        self.movieCV.snp.makeConstraints { (make) in
            make.leading.equalToSuperview()
            make.top.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    func registerCell(){
        movieCV.dataSource = self
        movieCV.delegate = self
        movieCV.register(AnotherMoveItemCell.self, forCellWithReuseIdentifier: "AnotherMoveItemCell")
    }
    
    func setData(movieRSP: MovieRSP?){
        self.movieRSP = movieRSP
        self.movieCV.reloadData()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension AnotherMoviePageCell: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let count = movieRSP?.results.count{
            return count
        }else{
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AnotherMoveItemCell", for: indexPath) as! AnotherMoveItemCell
        cell.backgroundColor = .blue
        cell.setData(movie: movieRSP?.results[indexPath.row])
        return cell
    }
    
    
}

extension AnotherMoviePageCell: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width/3, height: collectionView.frame.width/2)
    }
}
