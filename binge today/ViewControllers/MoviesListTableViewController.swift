//
//  MoviesListTableViewController.swift
//  binge today
//
//  Created by Mukul on 24/04/22.
//

import UIKit

class MoviesListTableViewController: UITableViewController {

    var movieModel: MovieListViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        movieModel = MovieListViewModel.init()
        movieModel?.delegate = self
        self.title = "Top Movies"
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var numberOfRows = 0
        if let value = movieModel?.topMoviesModels.count {
            if value > 10 {
                numberOfRows = 10
            } else {
                numberOfRows = value
            }
        }
        return numberOfRows
    }
        
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = self.tableView.dequeueReusableCell(
            withIdentifier: "MovieItemTableViewCell"
        ) as? MovieItemTableViewCell else {
            return UITableViewCell()
        }
        
        cell.configure(with: movieModel!, index: indexPath.row)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movieDetailVC = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "MovieDetailViewController") as? MovieDetailViewController
        movieDetailVC?.movieID = movieModel?.topMoviesModels[indexPath.row].id
        self.navigationController?.pushViewController(movieDetailVC!, animated: true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension MoviesListTableViewController: MovieListViewModelDelegate {
    func needToReloadData() {
        self.tableView.reloadData()
    }
}
