//
//  HomeMovieVC.swift
//  ToRingMovieIOS
//
//  Created by ToRing on 7/20/18.
//  Copyright © 2018 ToRing. All rights reserved.
//

import UIKit
import SnapKit
import Alamofire

class HomeMovieVC: UIViewController {
    lazy var safeView: UIView = {
        let safeView = UIView()
        return safeView
    }()
    
    lazy var movieTV: UITableView = {
        let movieTV = UITableView()
        movieTV.backgroundColor = UIColor.clear
        movieTV.allowsSelection = false
        return movieTV
    }()
    
    lazy var layoutLoading: UICustomLoadingView = {
        let layoutLoading = UICustomLoadingView()
        layoutLoading.startAnimating()
        layoutLoading.hidesWhenStopped = true
        return layoutLoading
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        addComponent()
        registerCell()
        loadMovies()
    }
    
    func addComponent() {
        self.view.addSubview(safeView)
        self.safeView.addSubview(movieTV)
        self.safeView.addSubview(layoutLoading)
        
        // add constrain
        self.safeView.snp.makeConstraints { (make) in
            make.leading.equalToSuperview()
            make.top.equalToSuperview().offset(20)
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        self.movieTV.snp.makeConstraints { (make) in
            make.leading.equalToSuperview()
            make.top.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        self.layoutLoading.snp.makeConstraints { (make) in
            make.leading.equalToSuperview()
            make.top.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    func registerCell() {
        self.movieTV.dataSource = self
        self.movieTV.delegate = self
        movieTV.register(PopularMovieCell.self, forCellReuseIdentifier: "popular_cell")
        movieTV.register(AnotherMovieCell.self, forCellReuseIdentifier: "anther_cell")
    }
    
    func loadMovies() {
        
    }
}

extension HomeMovieVC: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "popular_cell") as! PopularMovieCell
            cell.backgroundColor = .red
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "anther_cell") as! AnotherMovieCell
            cell.backgroundColor = .blue
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let fisrtRowHeight = self.safeView.bounds.width * (1/2)
        switch indexPath.row {
            case 0:
                return fisrtRowHeight
            default:
                return self.safeView.bounds.height - fisrtRowHeight
        }
    }
}
