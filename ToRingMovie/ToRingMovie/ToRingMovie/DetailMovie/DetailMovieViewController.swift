//
//  DetailMovieViewController.swift
//  ToRingMovie
//
//  Created by TR on 8/4/18.
//  Copyright © 2018 ToRing. All rights reserved.
//

import UIKit

class DetailMovieViewController: UIViewController {
    lazy var navigationBarView : UIView = {
        let navigationBarView = UIView()
        return navigationBarView
    }()
    
    lazy var backImage : UIImageView = {
        let backImage = UIImageView()
        backImage.contentMode = .center
        backImage.image = #imageLiteral(resourceName: "ic_back")
        return backImage
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        addComponent()
        addEvent()
        // Do any additional setup after loading the view.
    }
    
    func addComponent() {
        self.view.backgroundColor = UIColor.init(rgb: ColorCons.BACKGROUND)
        
        self.view.addSubview(navigationBarView)
        self.navigationBarView.addSubview(backImage)
        
        self.navigationBarView.snp.makeConstraints { (make) in
            make.leading.equalToSuperview()
            make.top.equalToSuperview().offset(20)
            make.trailing.equalToSuperview()
            make.height.equalTo(44)
        }
        
        self.backImage.snp.makeConstraints { (make) in
            make.leading.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.width.equalTo(backImage.snp.height)
        }
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
