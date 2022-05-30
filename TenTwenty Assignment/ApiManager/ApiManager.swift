//
//  ApiManager.swift
//  TenTwenty Assignment
//
//  Created by EAPPLE on 28/05/2022.
//

import Foundation

import Foundation
import Alamofire
import UIKit

class ApiManager{
    
    static let shared = ApiManager()
}


extension ApiManager{
    public func retrieveMovie( completionHandler: @escaping (Result<movieList, Error>) -> Void){
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/upcoming?api_key=\(Constants.apiKey)") else {
            return
        }

        AF.request(url, method: .post, parameters: nil, encoding: URLEncoding.default,  headers: nil).responseJSON { res in
            switch res.result {
            case .failure(let error):
                print(error)
                completionHandler(.failure(error))
            case .success(_):
                guard let data = res.data else {
                    return
                }
                do {
                    let json = try JSONDecoder().decode(movieList.self, from: data)
                    print(json)
                    return completionHandler(.success(json))
                } catch let error{
                    print(error)
                    completionHandler(.failure(error))
                }
            }
        }
    }
    
    public func retrieveMovieDetail(movieId: Int, completionHandler: @escaping (Result<MovieDetail, Error>) -> Void){
        print(movieId)
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/\(movieId)?api_key=\(Constants.apiKey)") else {
            return
        }

        AF.request(url, method: .get, parameters: nil, encoding: URLEncoding.default,  headers: nil).responseJSON { res in
            switch res.result {
            case .failure(let error):
                print(error)
                completionHandler(.failure(error))
            case .success(_):
                guard let data = res.data else {
                    return
                }
                do {
                    let json = try JSONDecoder().decode(MovieDetail.self, from: data)
                    print(json)
                    return completionHandler(.success(json))
                } catch let error{
                    print(error)
                    completionHandler(.failure(error))
                }
            }
        }
    }
    
    public func getVideoKey(movieId: Int, completionHandler: @escaping (Result<VideoModel, Error>) -> Void){
        print(movieId)
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/\(movieId)/videos?api_key=\(Constants.apiKey)") else {
            return
        }

        AF.request(url, method: .get, parameters: nil, encoding: URLEncoding.default,  headers: nil).responseJSON { res in
            switch res.result {
            case .failure(let error):
                print(error)
                completionHandler(.failure(error))
            case .success(_):
                guard let data = res.data else {
                    return
                }
                do {
                    let json = try JSONDecoder().decode(VideoModel.self, from: data)
                    print(json)
                    return completionHandler(.success(json))
                } catch let error{
                    print(error)
                    completionHandler(.failure(error))
                }
            }
        }
    }
}
