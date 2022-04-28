//
//  ViewController.swift
//  binge today
//
//  Created by Mukul on 24/04/22.
//

import UIKit

class MovieDetailViewController: UIViewController {
    
    var movieID: Int?
    var movieModel: MovieDetailViewModel?

    @IBOutlet weak var detailTableView: UITableView!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var releaseStatus: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        movieModel = MovieDetailViewModel.init(with: self.movieID)
        movieModel?.delegate = self
        self.detailTableView.sendSubviewToBack(headerView)
        releaseStatus.isHidden = true
    }
    
}

extension MovieDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.detailTableView.dequeueReusableCell(
            withIdentifier: "MovieDetailTableViewCell"
        ) as? MovieDetailTableViewCell else {
            return UITableViewCell()
        }
        
        cell.configure(with: movieModel!)
        
        return cell
    }
}

extension MovieDetailViewController: MovieDetailViewModelDelegate {
    func needToReloadData(status: String?) {
        self.detailTableView.reloadData()
        releaseStatus.isHidden = false
        releaseStatus.text = status
    }
}

