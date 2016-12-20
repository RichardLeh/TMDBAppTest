//
//  Movie.swift
//  TMDBApp
//
//  Created by Richard Leh on 18/12/2016.
//  Copyright © 2016 Richard Leh. All rights reserved.
//

import Foundation

class Movie{
    
    fileprivate var _id:Int
    fileprivate var _name:String
    fileprivate var _gender:String
    fileprivate var _imageURL:String
    fileprivate var _releaseDate:String
    
    init(with id:Int, name: String, gender: String, imageURL:String, releaseDate:String) {
        self._id = id
        self._name = name
        self._gender = gender
        self._imageURL = imageURL
        self._releaseDate = releaseDate
    }
    
    func id() -> Int{
        return self._id
    }
    func name() -> String{
        return self._name
    }
    func gender() -> String{
        return self._gender
    }
    func imageURL() -> String{
        return self._imageURL
    }
    func releaseDate() -> String{
        return self._releaseDate
    }
    
}
