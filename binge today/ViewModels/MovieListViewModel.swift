//
//  MovieListViewModel.swift
//  binge today
//
//  Created by Mukul on 26/04/22.
//

import Foundation
protocol MovieListViewModelDelegate {
    func needToReloadData()
}

struct MovieListItemViewModel {
    var id: Int?
    var posterURL: URL?
}

class MovieListViewModel {
    
    var topMovies: [MovieModel]?
    var delegate : MovieListViewModelDelegate?
    var topMoviesModels: [MovieListItemViewModel] = []
    
    init (){
        self.callAPI()
    }
        
    func callAPI(){
        APIService.shared.getPopularMovies() { movieModels in
            self.topMovies = movieModels
            self.assignValues(movies: self.topMovies)
            self.delegate?.needToReloadData()
        }
    }
    
    func assignValues(movies: [MovieModel]?){
        
        var tempID: Int?
        var tempPosterURL: URL?
        
        for movie in movies! {
            
            if let idValue = movie.id {
                tempID = idValue
            }
            if let urlValue = movie.poster_path {
                tempPosterURL = URL(string: "https://image.tmdb.org/t/p/original" + urlValue)
            }
            topMoviesModels.append(MovieListItemViewModel.init(id: tempID, posterURL: tempPosterURL))
        }
        
    }
    
}
