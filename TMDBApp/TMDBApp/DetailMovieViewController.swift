//
//  DetailMovieViewController.swift
//  TMDBApp
//
//  Created by Richard Leh on 16/01/2017.
//  Copyright © 2017 Richard Leh. All rights reserved.
//

import UIKit

class DetailMovieViewController: UIViewController {

    var movie:Movie?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = movie?.title
        self.navigationItem.backBarButtonItem?.title = ""
        //self.navigationController?.navigationBar.topItem?.title = "";
        //self.navigationController?.navigationBar.backItem?.title = ""
        
        // Do any additional setup after loading the view.
        print(movie?.id)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
