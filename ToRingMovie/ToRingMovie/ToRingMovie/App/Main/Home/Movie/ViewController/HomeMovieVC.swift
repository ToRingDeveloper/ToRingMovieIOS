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
import SwiftyJSON

class HomeMovieVC: UIViewController {
    let MAX_RESPONSE  = 4
    let NUMBER_OF_CELL = 4
    var countResponse = 0
    var titles = ["Popular", "Upcoming", "Now playing", "Top rate"]
    var movieRSPs = [MovieRSP?](repeating: nil, count: 4)
    
    lazy var safeView: UIView = {
        let safeView = UIView()
        return safeView
    }()
    
    lazy var movieTV: UITableView = {
        let movieTV = UITableView()
        movieTV.backgroundColor = UIColor.clear
        movieTV.allowsSelection = false
        movieTV.separatorStyle = UITableViewCellSeparatorStyle.none
        movieTV.showsVerticalScrollIndicator = false
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
        movieTV.register(PopularMovieCell.self, forCellReuseIdentifier: "PopularMovieCell")
        movieTV.register(AnotherMovieCell.self, forCellReuseIdentifier: "AnotherMovieCell")
        movieTV.register(SecondMovieCell.self, forCellReuseIdentifier: "SecondMovieCell")
    }
    
    func loadMovies() {
        resetConfig();
        
        let parameters : Parameters = [
            "api_key": ApiCons.API_KEY,
            "language": ApiCons.API_LANGUAGE,
            "page": ApiCons.FIRST_PAGE,
            "region": ApiCons.API_REGION
        ]
        Alamofire.request(ApiCons.BASE_URL + "movie/popular", method: HTTPMethod.get, parameters: parameters).responseJSON { (response) in
            self.handleResponse(index: 0, response: response)
        }
        Alamofire.request(ApiCons.BASE_URL + "movie/upcoming", method: HTTPMethod.get, parameters: parameters).responseJSON { (response) in
            self.handleResponse(index: 1, response: response)
        }
        Alamofire.request(ApiCons.BASE_URL + "movie/now_playing", method: HTTPMethod.get, parameters: parameters).responseJSON { (response) in
            self.handleResponse(index: 2, response: response)
        }
        Alamofire.request(ApiCons.BASE_URL + "movie/top_rated", method: HTTPMethod.get, parameters: parameters).responseJSON { (response) in
            self.handleResponse(index: 3, response: response)
        }
    }
    
    func resetConfig(){
        countResponse = 0
    }
    
    func handleResponse(index : Int,response : DataResponse<Any>) {
        switch response.result{
        case .success:
            if let statusCode = response.response?.statusCode {
                switch statusCode{
                case ApiCons.SUCCESS_CODE:
                    if let value = response.result.value {
                        parseData(index: index,value: value)
                    }else{
                        handleFailure()
                    }
                    break
                default:
                    handleFailure()
                    break
                }
            }else{
                handleFailure()
            }
            break
        case .failure:
            handleFailure()
            break
        }
    }
    
    func parseData(index : Int, value : Any){
        let jsonString = JSON(value)
        let movieRSP = MovieRSP(json: jsonString)
        self.movieRSPs[index] = movieRSP
        
        countResponse += 1
        if (countResponse == MAX_RESPONSE){
            self.movieTV.reloadData()
            hideLayoutLoading()
        }
    }
    
    func handleFailure() {
        hideLayoutLoading()
    }
    
    func hideLayoutLoading(){
        layoutLoading.stopAnimating()
    }
    
    func showLayoutLoading(){
        layoutLoading.startAnimating()
    }
}

extension HomeMovieVC: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return NUMBER_OF_CELL
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "PopularMovieCell") as! PopularMovieCell
            cell.setData(title: titles[indexPath.row], movieRSP: movieRSPs[indexPath.row])
            cell.addTapItem(tapItem: self)
            return cell
        default:
            if NUMBER_OF_CELL == 2{
                let cell = tableView.dequeueReusableCell(withIdentifier: "AnotherMovieCell") as! AnotherMovieCell
                cell.setData(titles: Array(titles[1..<titles.count]), movieRSPs: Array(movieRSPs[1..<movieRSPs.count]))
                return cell
            }else{
                let cell = tableView.dequeueReusableCell(withIdentifier: "SecondMovieCell") as! SecondMovieCell
                cell.backgroundColor = UIColor.init(rgb: ColorCons.BACKGROUND)
                cell.setData(title: titles[indexPath.row], movieRSP: movieRSPs[indexPath.row])
                return cell
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let fisrtRowHeight = self.safeView.bounds.width * (1/2)
        switch indexPath.row {
            case 0:
                return fisrtRowHeight
            default:
            if NUMBER_OF_CELL == 2{
                return self.safeView.bounds.height
            }else{
                return fisrtRowHeight * 1.2
            }
        }
    }
}

extension HomeMovieVC: TapItem{
    func tapItem(movie: Movie?) {
        let detailMovieVC = DetailMovieViewController()
        detailMovieVC.setMovie(movie: movie)
        self.navigationController?.pushViewController(detailMovieVC, animated: true)
    }
}
