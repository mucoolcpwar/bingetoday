//
//  MovieModel.swift
//  binge today
//
//  Created by Mukul on 24/04/22.
//

import Foundation
import SwiftyJSON

struct MovieModel {
    
    var adult : Bool?
    var backdrop_path : String?
    var belongs_to_collection : Belongs_to_collection?
    var budget : Int?
    var genres : [Genres]?
    var homepage : String?
    var id : Int?
    var imdb_id : String?
    var original_language : String?
    var original_title : String?
    var overview : String?
    var popularity : Double?
    var poster_path : String?
    var production_companies : [Production_companies]?
    var production_countries : [Production_countries]?
    var release_date : String?
    var revenue : Int?
    var runtime : Int?
    var spoken_languages : [Spoken_languages]?
    var status : String?
    var tagline : String?
    var title : String?
    var video : Bool?
    var vote_average : Double?
    var vote_count : Int?
    var posterUrl : URL?
    
    init(id: Int?, poster_path: String?){
        self.id = id
        self.poster_path = poster_path
        self.posterUrl = URL(string: "https://image.tmdb.org/t/p/original" + poster_path!)
    }
    
    init(json: JSON?){
        self.adult = json!["adult"].boolValue
        self.backdrop_path = json!["backdrop_path"].stringValue
        self.belongs_to_collection = Belongs_to_collection.init(json: json!["belongs_to_collection"])
        self.budget = json!["budget"].intValue
        self.genres = json!["genres"].arrayValue.map{Genres.init(json: $0)}
        
        self.homepage = json!["homepage"].stringValue
        self.id = json!["id"].intValue
        self.imdb_id = json!["imdb_id"].stringValue
        self.original_language = json!["original_language"].stringValue
        self.original_title = json!["original_title"].stringValue
        self.overview = json!["overview"].stringValue
        self.popularity = json!["popularity"].doubleValue
        self.poster_path = json!["poster_path"].stringValue
        self.production_companies = json!["production_companies"].arrayValue.map{Production_companies.init(json: $0)}
        self.production_countries = json!["production_countries"].arrayValue.map{Production_countries.init(json: $0)}
        self.release_date = json!["release_date"].stringValue
        self.revenue = json!["revenue"].intValue
        self.runtime = json!["runtime"].intValue
        self.spoken_languages = json!["spoken_languages"].arrayValue.map{Spoken_languages.init(json: $0)}
        self.status = json!["status"].stringValue
        self.tagline = json!["tagline"].stringValue
        self.title = json!["title"].stringValue
        self.video = json!["video"].boolValue
        self.vote_average = json!["vote_average"].doubleValue
        self.vote_count = json!["vote_count"].intValue
        self.posterUrl = URL(string: "https://image.tmdb.org/t/p/original" + poster_path!)
    }
    
}

struct Genres  {
    var id : Int?
    var name : String?
    
    init(json: JSON?) {
        self.id = json!["id"].intValue
        self.name = json!["name"].stringValue
    }
    
}

struct Production_companies  {
    var id : Int?
    var logo_path : String?
    var name : String?
    var origin_country : String?
    
    init(json : JSON?)  {
        self.id = json!["id"].intValue
        self.logo_path = json!["logo_path"].stringValue
        self.name = json!["name"].stringValue
        self.origin_country = json!["origin_country"].stringValue
    }
    
}

struct Production_countries  {
    var iso_3166_1 : String?
    var name : String?
    
    init(json: JSON?)  {
        self.iso_3166_1 = json!["iso_3166_1"].stringValue
        self.name = json!["name"].stringValue
    }
    
}

struct Spoken_languages  {
    var english_name : String?
    var iso_639_1 : String?
    var name : String?
        
    init(json: JSON?){
        self.english_name = json!["english_name"].stringValue
        self.iso_639_1 = json!["iso_639_1"].stringValue
        self.name = json!["name"].stringValue
    }
    
}

struct Belongs_to_collection  {
    var id : Int?
    var name : String?
    var poster_path : String?
    var backdrop_path : String?
        
    init(json: JSON?){
        self.id = json!["id"].intValue
        self.name = json!["name"].stringValue
        self.poster_path = json!["poster_path"].stringValue
        self.backdrop_path = json!["backdrop_path"].stringValue
    }
    
}
