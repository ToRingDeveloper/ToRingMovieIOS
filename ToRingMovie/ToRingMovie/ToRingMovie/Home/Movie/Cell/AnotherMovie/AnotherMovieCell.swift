//
//  AnotherMovieCell.swift
//  ToRingMovieIOS
//
//  Created by TR on 7/22/18.
//  Copyright © 2018 ToRing. All rights reserved.
//

import UIKit

class AnotherMovieCell: UITableViewCell {
    var titles : [String]?
    var movieRSPs : [MovieRSP?]?
    var typeVCDataSource : TypeVCDataSource?
    
    lazy var safeView : UIView = {
        let safeView  = UIView()
        return safeView
    }()
    
    lazy var typeCV : UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = 0
        flowLayout.scrollDirection = .horizontal
        let typeCV = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        typeCV.backgroundColor = UIColor.init(rgb: ColorCons.BACKGROUND)
        return typeCV
    }()

    lazy var movieCV : UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = 5
        flowLayout.scrollDirection = .horizontal
        let movieCV = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        movieCV.backgroundColor = UIColor.init(rgb: ColorCons.BACKGROUND)
        return movieCV
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addComponent()
        registerCell()
    }
    
    func setData(titles: [String], movieRSPs: [MovieRSP?]){
        self.titles = titles
        self.movieRSPs = movieRSPs
        typeVCDataSource?.titles = titles
        typeCV.reloadData()
        movieCV.reloadData()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addComponent(){
        self.contentView.addSubview(safeView)
        self.safeView.addSubview(typeCV)
        self.safeView.addSubview(movieCV)
        
        self.safeView.snp.makeConstraints { (make) in
            make.leading.equalToSuperview()
            make.top.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        self.typeCV.snp.makeConstraints { (make) in
            make.leading.equalToSuperview()
            make.top.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(40)
        }

        self.movieCV.snp.makeConstraints { (make) in
            make.leading.equalToSuperview()
            make.top.equalTo(typeCV.snp.bottom)
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    func registerCell() {
        typeCV.register(TypeCell.self, forCellWithReuseIdentifier: "TypeCell")
        typeVCDataSource = TypeVCDataSource()
        typeCV.dataSource = typeVCDataSource
        typeCV.delegate = typeVCDataSource
        
        movieCV.register(TypeCell.self, forCellWithReuseIdentifier: "AnotherMoviePageCell")
        movieCV.dataSource = self
        movieCV.delegate = self
    }
}

extension AnotherMovieCell : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let count = movieRSPs?.count{
            return count
        }else{
            return 0
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AnotherMoviePageCell", for: indexPath)
        cell.backgroundColor = UIColor.blue
        return cell
    }
}

extension AnotherMovieCell: UICollectionViewDelegate{

}

class TypeVCDataSource: UITableViewCell{
    var titles : [String]?
}

extension TypeVCDataSource : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let count = titles?.count{
            return count
        }else{
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let  cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TypeCell", for: indexPath) as! TypeCell
        cell.setData(title: titles![indexPath.row])
        return cell
    }
}

extension TypeVCDataSource: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width/3, height: collectionView.frame.height)
    }
}
