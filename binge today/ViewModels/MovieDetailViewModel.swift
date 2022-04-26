//
//  MovieDetailViewModel.swift
//  binge today
//
//  Created by Mukul on 24/04/22.
//

import Foundation
protocol MovieDetailViewModelDelegate {
    func needToReloadData(status: String?)
}

class MovieDetailViewModel {
    
    var movie: MovieModel?
    var delegate : MovieDetailViewModelDelegate?
    
    var movieName: String?
    var tagline: String?
    var yearOfRelease: String?
    var adult: String?
    var runtime: String?
    var rating: String?
    var voteCount: String?
    
    var genre:String?
    var languages:String?
    var budget:String?
    var revenue:String?
    
    var releaseStatus:String?
    var overview: String?
    
    var miniPoster: URL?
    var headerPoster: URL?
    
    init (){}
    
    init(with movieID: Int?) {
        self.callAPI(movieID: movieID)
    }
    
    func callAPI(movieID: Int?){
        APIService.shared.getMovieDetails(movieID: movieID!) { movieModel in
            self.movie = movieModel
            self.assignValues(movie: movieModel)
            self.delegate?.needToReloadData(status: self.releaseStatus)
        }
    }
    
    func assignValues(movie: MovieModel){
        movieName = movie.original_title
        tagline = movie.tagline
        yearOfRelease = stringToDate(dateString: movie.release_date)
        if let adultValue = movie.adult {
            adult = adultValue ? "A" : "UA"
        }
        if let runtimeValue = movie.runtime {
            runtime = "\(runtimeValue)"
        }
        if let ratingValue = movie.vote_average {
            rating = "\(ratingValue)"
        }
        if let voteCountValue = movie.vote_count {
            voteCount = "\(voteCountValue)"
        }
        if let genreArray = movie.genres.map({$0.map{$0.name}}) {
            genre = (genreArray.map{String($0!)}).joined(separator: ", ")
        }
        if let languagesArray = movie.spoken_languages.map({$0.map{$0.english_name}}) {
            languages = (languagesArray.map{String($0!)}).joined(separator: ", ")
        }
        if let budgetValue = movie.budget {
            budget = String("Budget: \(formatNumber(budgetValue))")
        }
        
        if let revenueValue = movie.revenue {
            revenue = String("Revenue: \(formatNumber(revenueValue))")
        }
        
        releaseStatus = movie.status
        overview = movie.overview
        
        miniPoster = URL(string: "https://image.tmdb.org/t/p/original" + (movie.poster_path!))
        headerPoster = URL(string: "https://image.tmdb.org/t/p/original" + (movie.backdrop_path!))
    }
    
    func stringToDate (dateString: String?) -> String?{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.date(from:dateString!)!
        return String(date.get(.year))
    }
}

extension Date {
    func get(_ component: Calendar.Component, calendar: Calendar = Calendar.current) -> Int {
        return calendar.component(component, from: self)
    }
}

public extension Int {
    var asWord: String? {
        let numberValue = NSNumber(value: self)
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        return formatter.string(from: numberValue)
    }
}

extension Double {
    func reduceScale(to places: Int) -> Double {
        let multiplier = pow(10, Double(places))
        let newDecimal = multiplier * self // move the decimal right
        let truncated = Double(Int(newDecimal)) // drop the fraction
        let originalDecimal = truncated / multiplier // move the decimal back
        return originalDecimal
    }
}

func formatNumber(_ n: Int) -> String {
    let num = abs(Double(n))
    let sign = (n < 0) ? "-" : ""
    
    switch num {
    case 1_000_000_000...:
        var formatted = num / 1_000_000_000
        formatted = formatted.reduceScale(to: 1)
        return "$\(sign)\(formatted) billion"
        
    case 1_000_000...:
        var formatted = num / 1_000_000
        formatted = formatted.reduceScale(to: 1)
        return "$\(sign)\(formatted) million"
        
    case 1_000...:
        var formatted = num / 1_000
        formatted = formatted.reduceScale(to: 1)
        return "$\(sign)\(formatted) thousand"
        
    case 0...:
        return "Unknown"
        
    default:
        return "\(sign)\(n)"
    }
}
