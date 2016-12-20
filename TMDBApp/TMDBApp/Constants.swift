//
//  Constants.swift
//  TMDBApp
//
//  Created by Richard Leh on 18/12/2016.
//  Copyright © 2016 Richard Leh. All rights reserved.
//

import Foundation

// MARK: Constants
struct Constants {
    
    // MARK: API TMDB MOVIE
    struct TMDBMovie {
        static let APIScheme = "https"
        static let APIHost = "api.themoviedb.org"
        static let APIPath = "/3"
        static let APIMethod = "/movie/upcoming"
    }
    
    struct TMDBMovieKeys {
        static let APIKEY = "api_key"
        static let Language = "language"
        static let Page = "page"
    }
    
    struct TMDBMovieValues {
        static let APIKEY = "28190e24b6d3d0b73a9b5842bee9d8bf"
        static let Language = "en-US"
        static let Page = "1"
    }
    
    //https://image.tmdb.org/t/p/w1000/8uO0gUM8aNqYLs1OsTBQiXu0fEv.jpg
    // MARK: API TMDB MOVIE IMAGE
    struct TMDBMovieImage {
        static let APIScheme = "https:"
        static let APIHost = "image.tmdb.org"
        static let APIPath = "/t/p/w300/"
        static let APIImageName = "8uO0gUM8aNqYLs1OsTBQiXu0fEv.jpg"
    }
}
