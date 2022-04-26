//
//  APIService.swift
//  binge today
//
//  Created by Mukul on 24/04/22.
//

import Alamofire
import SwiftyJSON

class APIService {
    
    static let shared = APIService()
    
    func getPopularMovies(movies: @escaping ([MovieModel]) -> Void) {
        AF.request("https://api.themoviedb.org/3/movie/popular?api_key=35014a75778ef72830d24b24df2081e3&language=en-US&page=1").response { response in
            let json = JSON(response.data!)
            movies(json["results"].arrayValue.map {MovieModel.init(json: $0)})
        }
    }
    
    func getMovieDetails (movieID: Int, movie: @escaping (MovieModel) -> Void){
        AF.request("https://api.themoviedb.org/3/movie/\(movieID)?api_key=35014a75778ef72830d24b24df2081e3&language=en-US&page=1").response { response in
            let json = JSON(response.data!)
            movie(MovieModel.init(json: json))
        }
    }
    
    func createImageURL (uri: String) -> URL {
        return URL(string: "https://image.tmdb.org/t/p/original"+uri)!
    }
}
