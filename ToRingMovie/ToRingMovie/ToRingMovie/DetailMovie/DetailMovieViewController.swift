//
//  DetailMovieViewController.swift
//  ToRingMovie
//
//  Created by TR on 8/4/18.
//  Copyright © 2018 ToRing. All rights reserved.
//

import UIKit

class DetailMovieViewController: UIViewController {
    let NUMBER_OF_ROW = 1
    let IMAGE_TITLE_CELL_ID  = "ImageTitleCell"
    
    var movie: Movie?
    
    func setMovie(movie: Movie?) {
        self.movie = movie
    }
    
    lazy var navigationBarView : UIView = {
        let navigationBarView = UIView()
        return navigationBarView
    }()
    
    lazy var backImage : UIImageView = {
        let backImage = UIImageView()
        backImage.contentMode = .scaleAspectFit
        backImage.image = #imageLiteral(resourceName: "ic_back")
        return backImage
    }()

    lazy var contentTV : UITableView = {
        let contentTV = UITableView()
        contentTV.separatorStyle = .none
        contentTV.allowsSelection = false
        contentTV.backgroundColor = UIColor.init(rgb: ColorCons.BACKGROUND)
        return contentTV
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        addComponent()
        registerCell()
        addEvent()
        // Do any additional setup after loading the view.
    }
    
    func addComponent() {
        self.view.backgroundColor = UIColor.init(rgb: ColorCons.BACKGROUND)
        
        self.view.addSubview(contentTV)
        self.view.addSubview(navigationBarView)
        self.navigationBarView.addSubview(backImage)
        
        self.contentTV.snp.makeConstraints { (make) in
             make.top.equalToSuperview().offset(20)
             make.leading.trailing.bottom.equalToSuperview()
        }
        
        self.navigationBarView.snp.makeConstraints { (make) in
            make.leading.equalToSuperview()
            make.top.equalToSuperview().offset(20)
            make.trailing.equalToSuperview()
            make.height.equalTo(44)
        }
        
        self.backImage.snp.makeConstraints { (make) in
            make.leading.equalToSuperview()
            make.top.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-10)
            make.width.equalTo(backImage.snp.height)
        }
    }
    
    func registerCell(){
        self.contentTV.delegate = self
        self.contentTV.dataSource = self
        self.contentTV.register(ImageTitleCell.self, forCellReuseIdentifier: IMAGE_TITLE_CELL_ID)
    }
    
    func addEvent() {
        let backTap = UITapGestureRecognizer(target: self, action: #selector(backTap(_:)))
        backImage.isUserInteractionEnabled = true
        backImage.addGestureRecognizer(backTap)
    }
    
    @objc func backTap(_ sender: UITapGestureRecognizer){
        self.navigationController?.popViewController(animated: true)
    }
}

extension DetailMovieViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return NUMBER_OF_ROW
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: IMAGE_TITLE_CELL_ID, for: indexPath) as! ImageTitleCell
            cell.backgroundColor = UIColor.init(rgb: ColorCons.BACKGROUND)
            cell.setData(movie: movie)
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "IMAGE_TITLE_CELL_ID", for: indexPath) as! ImageTitleCell
            return cell
        }
    }
}

extension DetailMovieViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return tableView.frame.width * (0.8)
        default:
            return tableView.frame.width
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        return
    }
}
