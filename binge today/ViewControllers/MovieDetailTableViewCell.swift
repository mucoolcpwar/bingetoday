//
//  MovieDetailTableViewCell.swift
//  binge today
//
//  Created by Mukul on 24/04/22.
//

import UIKit
import Kingfisher

class MovieDetailTableViewCell: UITableViewCell {

    @IBOutlet weak var movieName: UILabel!
    @IBOutlet weak var tagline: UILabel!
    @IBOutlet weak var yearOfRelease: UILabel!
    @IBOutlet weak var adult: UILabel!
    @IBOutlet weak var runtime: UILabel!
    @IBOutlet weak var rating: UILabel!
    @IBOutlet weak var voteCount: UILabel!

    @IBOutlet weak var genre: UILabel!
    @IBOutlet weak var languages: UILabel!
    @IBOutlet weak var budget: UILabel!
    @IBOutlet weak var revenue: UILabel!

    @IBOutlet weak var overview: UITextView!

    @IBOutlet weak var miniPoster: UIImageView!
    @IBOutlet weak var headerPoster: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(with model: MovieDetailViewModel) {
        movieName.text = model.movieName
        tagline.text = model.tagline
        yearOfRelease.text = model.yearOfRelease
        adult.text = model.adult
        runtime.text = model.runtime
        rating.text = model.rating
        voteCount.text = model.voteCount

        genre.text = model.genre
        languages.text = model.languages
        budget.text = model.budget
        revenue.text = model.revenue

        overview.text = model.overview
        adjustUITextViewHeight(arg: overview)

        miniPoster.kf.setImage(with: model.miniPoster)
        headerPoster.kf.setImage(with: model.headerPoster)
    }

    func adjustUITextViewHeight(arg : UITextView) {
        arg.sizeToFit()
        arg.isScrollEnabled = false
    }
}
