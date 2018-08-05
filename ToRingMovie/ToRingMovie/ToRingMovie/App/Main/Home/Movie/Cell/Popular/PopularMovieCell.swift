//
//  PopularMovieCell.swift
//  ToRingMovieIOS
//
//  Created by TR on 7/22/18.
//  Copyright © 2018 ToRing. All rights reserved.
//

import UIKit

protocol TapItem {
    func tapItem(movie: Movie?)
}

class PopularMovieCell: UITableViewCell {
    var title: String?
    var movieRSP : MovieRSP?
    var tapItemProtocol: TapItem?
    
    lazy var safeView: UIView = {
        let safeView = UIView()
        return safeView
    }()
    
    lazy var movieCV : UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = UICollectionViewScrollDirection.horizontal
        flowLayout.minimumLineSpacing = 0
        let movieCV = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        movieCV.isPagingEnabled = true
        movieCV.showsHorizontalScrollIndicator = false
        return movieCV
    }()
    
    lazy var pageControl : UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.numberOfPages = 0
        pageControl.pageIndicatorTintColor = UIColor.gray
        pageControl.transform = CGAffineTransform(scaleX: 0.8, y: 0.8);
        pageControl.currentPageIndicatorTintColor = UIColor.init(rgb: ColorCons.APP_COLOR)
        return pageControl
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addComponent()
        registerCell()
    }
    
    func registerCell() {
        movieCV.dataSource = self
        movieCV.delegate = self
        
        movieCV.register(PopularMovieItemCell.self, forCellWithReuseIdentifier: "PopularMovieItemCell")
    }
    
    func addComponent(){
        self.contentView.addSubview(safeView)
        self.safeView.addSubview(movieCV)
        self.safeView.addSubview(pageControl)
        
        safeView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        movieCV.snp.makeConstraints { (make) in
            make.leading.equalToSuperview()
            make.top.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        pageControl.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
            make.top.equalToSuperview().offset(5)
            make.height.equalTo(20)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setData(title: String?, movieRSP : MovieRSP?) {
        self.title = title
        self.movieRSP = movieRSP
        movieCV.reloadData()
        if let count = movieRSP?.results.count{
            pageControl.numberOfPages = count
        }else{
            pageControl.numberOfPages = 0
        }
    }
    
    func addTapItem(tapItem : TapItem) {
        self.tapItemProtocol = tapItem
    }
}

extension PopularMovieCell: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let count = movieRSP?.results.count{
            return count
        }else{
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PopularMovieItemCell", for: indexPath) as! PopularMovieItemCell
        if  let movie = movieRSP?.results[indexPath.row]{
            cell.setData(type: title,movie: movie)
        }
        return cell
    }
}


extension PopularMovieCell: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
}

extension PopularMovieCell: UICollectionViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //Change the current page
        let witdh = scrollView.frame.width - (scrollView.contentInset.left * 2)
        let index = scrollView.contentOffset.x / witdh
        let roundedIndex = Darwin.round(index)
        pageControl.currentPage = Int(roundedIndex)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        tapItemProtocol?.tapItem(movie: movieRSP?.results[indexPath.row])
    }
}

