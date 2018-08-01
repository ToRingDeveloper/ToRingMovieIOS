//
//  PopularMovieCell.swift
//  ToRingMovieIOS
//
//  Created by TR on 7/22/18.
//  Copyright © 2018 ToRing. All rights reserved.
//

import UIKit

class PopularMovieCell: UITableViewCell {
    var movieRSP : MovieRSP?
    
    lazy var safeView: UIView = {
        let safeView = UIView()
        return safeView
    }()
    
    func setData(movieRSP : MovieRSP?) {
        self.movieRSP = movieRSP
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
