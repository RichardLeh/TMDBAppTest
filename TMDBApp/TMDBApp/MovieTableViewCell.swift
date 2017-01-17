//
//  MovieTableViewCell.swift
//  TMDBApp
//
//  Created by Richard Leh on 16/01/2017.
//  Copyright © 2017 Richard Leh. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class MovieTableViewCell: UITableViewCell {

    @IBOutlet weak var titleMovieLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var coverImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        titleMovieLabel.textColor = UIColor.init(hexString: Colors.defaultDarkBlue.rawValue)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func fill(withMovie movie:Movie){
        if let backdropPath = movie.backdropPath,
            let url = Requests.sharedInstance().gerURL(forImagePath: backdropPath){
            
            coverImageView.af_setImage(withURL: url)
        }
        
        titleMovieLabel.text = movie.title
        releaseDateLabel.text = movie.releaseDate?.dateStringFormated
        
        if let mGenres = movie.genres {
            
            var genresString = ""
            
            let genresNames = mGenres.map { $0.name }
            for (index, name) in genresNames.enumerated(){
                guard let name = name else{
                    return
                }
                genresString = genresString + name
                if index != genresNames.count - 1{
                    genresString = genresString + ", "
                }
            }
            
            genreLabel.text = genresString
        }
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        clear()
    }
    
    func clear(){
        
        coverImageView.image = nil
        
        titleMovieLabel.text = ""
        releaseDateLabel.text = ""
    }

}
