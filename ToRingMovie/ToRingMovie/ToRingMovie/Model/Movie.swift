//
//  Movie.swift
//  ToRingMovie
//
//  Created by TR on 6/28/18.
//  Copyright © 2018 ToRing. All rights reserved.
//

import UIKit
import SwiftyJSON

class Movie: NSObject {
    init(json : JSON) {
        self.vote_count = json["vote_count"].intValue
        self.id = json["id"].intValue
        self.video = json["video"].boolValue
        self.vote_average = json["vote_average"].doubleValue
        self.title = json["title"].stringValue
        self.popularity = json["popularity"].floatValue
        self.poster_path = json["poster_path"].stringValue
        self.original_language = json["original_language"].stringValue
        self.original_title = json["original_title"].stringValue
        self.backdrop_path = json["backdrop_path"].stringValue
        self.adult = json["adult"].boolValue
        self.overview = json["overview"].stringValue
        self.release_date = json["release_date"].stringValue
    }
    
    var vote_count: Int
    var id: Int
    var video: Bool
    var vote_average: Double
    var title: String
    var popularity: Float
    var poster_path: String
    var original_language: String
    var original_title: String
    //    var genre_id
    var backdrop_path: String
    var adult: Bool
    var overview: String
    var release_date: String
}

