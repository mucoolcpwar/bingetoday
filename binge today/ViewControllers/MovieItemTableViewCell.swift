//
//  MovieItemTableViewCell.swift
//  binge today
//
//  Created by Mukul on 24/04/22.
//

import UIKit
import Kingfisher
import SwiftUI

class MovieItemTableViewCell: UITableViewCell {

    static let identifier = "MovieItemTableViewCell"
    @IBOutlet weak var posterImageView: UIImageView!
    
    func configure(with model: MovieListViewModel, index: Int) {
        if !model.topMoviesModels.isEmpty {
            self.posterImageView.kf.setImage(with: model.topMoviesModels[index].posterURL)
        }
    }
}
