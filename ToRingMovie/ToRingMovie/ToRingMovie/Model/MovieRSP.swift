//
//  MovieRSP.swift
//  ToRingMovie
//
//  Created by TR on 6/28/18.
//  Copyright © 2018 ToRing. All rights reserved.
//

import UIKit
import SwiftyJSON

class MovieRSP: NSObject {
    init(json : JSON) {
        self.page = json["page"].intValue
        self.total_pages = json["total_pages"].intValue
        self.total_results = json["total_results"].intValue
        self.results = [Movie]()
        if let jsonArray = json["results"].array {
            for i in 0..<jsonArray.count{
                results.append(Movie(json: jsonArray[i]))
            }
        }
    }
    
    var page : Int
    var total_pages : Int
    var total_results : Int
    var results : [Movie]
}

