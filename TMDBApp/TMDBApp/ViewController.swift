//
//  ViewController.swift
//  TMDBApp
//
//  Created by Richard Leh on 17/12/2016.
//  Copyright © 2016 Richard Leh. All rights reserved.
//

import UIKit
import Alamofire
import SVProgressHUD

enum jsonResult:String {
    case results    = "results"
    case genres     = "genres"
    case totalPages = "total_pages"
}

class ViewController: UIViewController {

    @IBOutlet weak var tableView:UITableView!
    let tableCellIdentifier:String = "MovieCell"
    let noResultsCellIdentifier:String = "NoResultCell"
    
    // collections
    var movies = [Movie]()
    var genres = [Genrer]()
    
    // control pages
    var currentPage = 1
    var totalPages = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nav = self.navigationController?.navigationBar
        nav?.tintColor = UIColor.white
        
        let defBgColor = UIColor.init(hexString: Colors.defaultDarkBlue.rawValue)
        nav?.barTintColor = defBgColor
        
        let defColor = UIColor.init(hexString: Colors.defaultGreen.rawValue)
        nav?.titleTextAttributes = [NSForegroundColorAttributeName:defColor]
        
        SVProgressHUD.setBackgroundColor(UIColor(hexString: Colors.defaultDarkBlue.rawValue))
        SVProgressHUD.setForegroundColor(UIColor(hexString: Colors.defaultGreen.rawValue))
        
        self.title = "TMDBApp"
        self.getGenres()
    }
    
    fileprivate func getMovies(fromJson json:DictionaryData){
        print(json)
    }
    fileprivate func getGenres(){
        
        self.showProgress()
        
        Requests.sharedInstance().requestGenrer{ [weak self] (result, error) in
            
            guard result != nil, let resultDict = result as? DictionaryData else{
                self?.showError(error.debugDescription)
                return
            }
            self?.parseGenrer(resultDict)
            
            self?.getMovies()
        }
    }
    
    fileprivate func getMovies(){
        
        self.showProgress()
        
        Requests.sharedInstance().requestUpcomingMovies(fromPage: currentPage){ [weak self] (result, error) in
            
            guard result != nil, let resultDict = result as? DictionaryData else{
                self?.showError(error.debugDescription)
                return
            }
            print("resultDict c ", resultDict.count)
            self?.parseMovie(resultDict)
            
            self?.tableView?.reloadData()
            
            self?.dismissProgress()
        }
    }
    
    fileprivate func parseGenrer(_ data:DictionaryData){
        guard let results = data[jsonResult.genres.rawValue] as? [DictionaryData] else {
            return
        }
        for result in results{
            let genrer = Genrer(withDict: result)
            genres.append(genrer)
        }
    }
    
    fileprivate func parseMovie(_ data:DictionaryData){
        guard let results = data[jsonResult.results.rawValue]    as? [DictionaryData],
              let total   = data[jsonResult.totalPages.rawValue] as? Int else {
            return
        }
        print(totalPages, total)
        totalPages = (totalPages > total) ? totalPages : total
        print(totalPages, total)
        
        for result in results{
            let movie = Movie(withDict: result, andGenres: self.genres)
            movies.append(movie)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func showError(_ error: String){
        print(error)
        updatesOnMain{
            // TODO
            // FIX.ME("Atualizar a UI")
        }
    }
    
    // MARK: Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Segues.detailMovieSegue.rawValue  {
            if let viewController = segue.destination as? DetailMovieViewController {
                if let movie = sender as? Movie{
                    viewController.movie = movie
                }
            }
        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (movies.count == 0) ? 1 : movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if movies.count > 0 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: tableCellIdentifier, for: indexPath) as! MovieTableViewCell
            let movie = movies[indexPath.row]
            cell.fill(withMovie: movie)
            
            //print("page ", currentPage, totalPages)
            if movies.count == indexPath.row + 1 && currentPage + 1 <= totalPages {
                print("page ", currentPage, totalPages)
                currentPage = currentPage + 1
                self.getMovies()
            }
            
            return cell
        }
        
        return tableView.dequeueReusableCell(withIdentifier: noResultsCellIdentifier, for: indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 260
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let movie = movies[indexPath.row]
        self.performSegue(withIdentifier: Segues.detailMovieSegue.rawValue, sender: movie)
    }
}
