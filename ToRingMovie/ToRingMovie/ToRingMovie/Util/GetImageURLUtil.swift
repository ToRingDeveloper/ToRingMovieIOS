//
//  GetImageUrlUtil.swift
//  ToRingMovieIOS
//
//  Created by TR on 7/26/18.
//  Copyright © 2018 ToRing. All rights reserved.
//

import UIKit

class GetImageURLUtil: NSObject {
    static func getBackdropImageURL(_ sufImageURL: String) -> String {
        return "https://image.tmdb.org/t/p/w780/\(sufImageURL)"
    }
}
