//
//  DetailMovieViewController.swift
//  TMDBApp
//
//  Created by Richard Leh on 16/01/2017.
//  Copyright © 2017 Richard Leh. All rights reserved.
//

import UIKit

class DetailMovieViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleMovieLabel: UILabel!
    @IBOutlet weak var releaseLabel: UILabel!
    @IBOutlet weak var genrerLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    
    var movie:Movie?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.updateUI()
        self.fillView()
    }
    
    fileprivate func updateUI(){
        
        self.title = movie?.title
        
        self.view.backgroundColor = UIColor.init(hexString: Colors.defaultDarkBlue.rawValue)
        contentView.backgroundColor = UIColor.init(hexString: Colors.defaultDarkBlue.rawValue)
        scrollView.backgroundColor = UIColor.init(hexString: Colors.defaultDarkBlue.rawValue)
        
        titleMovieLabel.textColor = UIColor.init(hexString: Colors.defaultGreen.rawValue)
    }
    
    fileprivate func fillView(){
        if let posterPath = movie?.posterPath,
            let url = Requests.sharedInstance().gerURL(forImagePath: posterPath){
            
            posterImageView.af_setImage(withURL: url)
        }
        
        titleMovieLabel.text = movie?.title
        releaseLabel.text = movie?.releaseDate?.dateStringFormated
        genrerLabel.text = movie?.genrerFormatedString()
        overviewLabel.text = movie?.overview
        
        Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self.updateSizeScroll), userInfo: nil, repeats: false);
    }
    
    func updateSizeScroll(){
        self.scrollView.contentSize = CGSize(width: 0, height: contentView.frame.size.height)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
