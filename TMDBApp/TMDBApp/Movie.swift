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
    case releaseDate = "release_date"
    case posterPath = "poster_path"
    case backdropPath = "backdrop_path"
    case genreIds = "genre_ids"
    case overview = "overview"
}

class Movie{
    
    var id:Int?
    var title:String?
    var genreIds:[Int]?
    var posterPath:String?
    var backdropPath:String?
    var releaseDate:String?
    var overview:String?
    
    var genres:[Genrer]?
    
    convenience init(withDict dictionary:DictionaryData, andGenres genresArr:[Genrer]) {
        self.init()
        
        if let _id = dictionary[ServerTMDBMovie.id.rawValue] as? Int{
            self.id = _id
        }
        if let _title = dictionary[ServerTMDBMovie.title.rawValue] as? String{
            self.title = _title
        }
        
        if let _genreIds = dictionary[ServerTMDBMovie.genreIds.rawValue] as? [Int]{
            self.genreIds = _genreIds
            self.genres = []
            
            for id in genreIds!{
                let genrer = genresArr.filter({ $0.id == id })
                self.genres?.append(contentsOf: genrer)
            }
        }
        
        if let _posterPath = dictionary[ServerTMDBMovie.posterPath.rawValue] as? String{
            self.posterPath = _posterPath
        }
        if let _backdropPath = dictionary[ServerTMDBMovie.backdropPath.rawValue] as? String{
            self.backdropPath = _backdropPath
        }
        if let _releaseDate = dictionary[ServerTMDBMovie.releaseDate.rawValue] as? String{
            self.releaseDate = _releaseDate
        }
        if let _overview = dictionary[ServerTMDBMovie.overview.rawValue] as? String{
            self.overview = _overview
        }
    }
}

extension Movie {
    
    func genrerFormatedString() -> String{
        if let mGenres = self.genres {
            
            var genresString = ""
            
            let genresNames = mGenres.map { $0.name }
            for (index, name) in genresNames.enumerated(){
                guard let name = name else{
                    break
                }
                genresString = genresString + name
                if index != genresNames.count - 1{
                    genresString = genresString + ", "
                }
            }
            
            return genresString
        }
        return ""
    }
    
}
