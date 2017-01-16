//
//  MovieTableViewCell.swift
//  TMDBApp
//
//  Created by Richard Leh on 16/01/2017.
//  Copyright © 2017 Richard Leh. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {

    @IBOutlet weak var titleMovieLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func fill(withMovie movie:Movie){
        titleMovieLabel.text = movie.title
        //genreLabel.text = movie.genreIds
        releaseDateLabel.text = movie.releaseDate
    }
}
