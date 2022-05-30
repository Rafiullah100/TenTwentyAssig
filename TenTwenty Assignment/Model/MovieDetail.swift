//
//  MovieDetail.swift
//  TenTwenty Assignment
//
//  Created by EAPPLE on 28/05/2022.
//

import Foundation


struct MovieDetail : Codable {
    let adult : Bool?
    let backdrop_path : String?
    let budget : Int?
    let genres : [Genres]?
    let homepage : String?
    let id : Int?
    let imdb_id : String?
    let original_language : String?
    let original_title : String?
    let overview : String?
    let popularity : Double?
    let poster_path : String?
    let productionCompanies : [ProductionCompanies]?
    let productionCountries : [ProductionCountries]?
    let release_date : String?
    let revenue : Int?
    let runtime : Int?
    let spokenLanguages : [SpokenLanguages]?
    let status : String?
    let tagline : String?
    let title : String?
    let video : Bool?
    let vote_average : Double?
    let vote_count : Int?

    enum CodingKeys: String, CodingKey {

        case adult = "adult"
        case backdrop_path = "backdrop_path"
        case budget = "budget"
        case genres = "genres"
        case homepage = "homepage"
        case id = "id"
        case imdb_id = "imdb_id"
        case original_language = "original_language"
        case original_title = "original_title"
        case overview = "overview"
        case popularity = "popularity"
        case poster_path = "poster_path"
        case productionCompanies = "production_companies"
        case productionCountries = "productionCountries"
        case release_date = "release_date"
        case revenue = "revenue"
        case runtime = "runtime"
        case spokenLanguages = "spokenLanguages"
        case status = "status"
        case tagline = "tagline"
        case title = "title"
        case video = "video"
        case vote_average = "vote_average"
        case vote_count = "vote_count"
    }
}

struct SpokenLanguages : Codable {
    let english_name : String?
    let iso_639_1 : String?
    let name : String?
}

struct ProductionCountries : Codable {
    let iso_3166_1 : String?
    let name : String?

    enum CodingKeys: String, CodingKey {

        case iso_3166_1 = "iso_3166_1"
        case name = "name"
    }
}

struct ProductionCompanies : Codable {
    let id : Int?
    let logo_path : String?
    let name : String?
    let origin_country : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case logo_path = "logo_path"
        case name = "name"
        case origin_country = "origin_country"
    }
}

struct Genres : Codable {
    let id : Int?
    let name : String?
}
