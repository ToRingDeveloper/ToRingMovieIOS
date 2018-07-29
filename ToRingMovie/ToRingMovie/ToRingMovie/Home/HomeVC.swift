//
//  HomeController.swift
//  ToRingMovieIOS
//
//  Created by TR on 7/20/18.
//  Copyright © 2018 ToRing. All rights reserved.
//

import UIKit

class HomeVC: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        addComponent()
    }
    
    func addComponent() {
//        let attributesSelected = [
//            NSAttributedStringKey.foregroundColor : UIColor(named: "AppColor")
//        ]
//        let attributesNormal = [
//            NSAttributedStringKey.foregroundColor : UIColor(named: "SecondaryTextColor")
//        ]
//        UITabBarItem.appearance().setTitleTextAttributes(attributesNormal , for: UIControlState.normal)
//        UITabBarItem.appearance().setTitleTextAttributes(attributesSelected, for: UIControlState.selected)
//        self.tabBar.barTintColor = UIColor(named: "Background")
//        self.tabBar.tintColor = UIColor(named: "AppColor")
//        self.tabBar.unselectedItemTintColor = UIColor(named: "Background")
        self.tabBar.isTranslucent = false
        
        let homeMovieVC = HomeMovieVC()
        homeMovieVC.tabBarItem = UITabBarItem(title: "Movie", image: #imageLiteral(resourceName: "ic_movie_normal"), selectedImage: #imageLiteral(resourceName: "ic_movie_selected"))
        let homeTVVC = HomeTVVC()
        homeTVVC.tabBarItem = UITabBarItem(title: "TVShow", image: #imageLiteral(resourceName: "ic_tvshow_normal"), selectedImage: #imageLiteral(resourceName: "ic_tvshow_selected"))
        
        self.viewControllers = [homeMovieVC, homeTVVC]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
