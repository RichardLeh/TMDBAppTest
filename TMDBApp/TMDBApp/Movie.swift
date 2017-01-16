//
//  Movie.swift
//  TMDBApp
//
//  Created by Richard Leh on 18/12/2016.
//  Copyright © 2016 Richard Leh. All rights reserved.
//

import Foundation

enum ServerTMDBMovie:String{
    case id = "id"
    case title = "title"
    case releaseDate = "releaseDate"
    case posterPath = "poster_path"
    case genreIds = "genre_ids"
    case overview = "overview"
}

class Movie{
    
    var id:Int?
    var title:String?
    var genreIds:[Int]?
    var posterPath:String?
    var releaseDate:String?
    var overview:String?
    
    var genres:[Genrer]?
    
    // including movie name, poster or backdrop image, genre and release date.
    // name, poster image, genre, overview and release date
    convenience init(withDict dictionary:DictionaryData) {
        self.init()
        
        if let _id = dictionary[ServerTMDBMovie.id.rawValue] as? Int{
            self.id = _id
        }
        if let _title = dictionary[ServerTMDBMovie.title.rawValue] as? String{
            self.title = _title
        }
        if let _genreIds = dictionary[ServerTMDBMovie.genreIds.rawValue] as? [Int]{
            self.genreIds = _genreIds
        }
        if let _posterPath = dictionary[ServerTMDBMovie.genreIds.rawValue] as? String{
            self.posterPath = _posterPath
        }
        if let _releaseDate = dictionary[ServerTMDBMovie.releaseDate.rawValue] as? String{
            self.releaseDate = _releaseDate
        }
        if let _overview = dictionary[ServerTMDBMovie.overview.rawValue] as? String{
            self.overview = _overview
        }
    }
}
