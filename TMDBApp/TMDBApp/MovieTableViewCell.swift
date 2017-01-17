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
        self.selectionStyle = .none
        self.contentView.backgroundColor = UIColor.init(hexString: Colors.defaultDarkBlue.rawValue)
        titleMovieLabel.textColor = UIColor.init(hexString: Colors.defaultGreen.rawValue)
    }
    
    func fill(withMovie movie:Movie){
        if let backdropPath = movie.backdropPath,
            let url = Requests.sharedInstance().gerURL(forImagePath: backdropPath){
            
            coverImageView.af_setImage(withURL: url)
        }
        
        titleMovieLabel.text = movie.title
        
        releaseDateLabel.text = movie.releaseDate?.dateStringFormated
        
        genreLabel.text = movie.genrerFormatedString()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        clear()
    }
    
    func clear(){
        
        coverImageView.image = nil
        
        titleMovieLabel.text = ""
        releaseDateLabel.text = ""
        genreLabel.text = ""
    }

}
