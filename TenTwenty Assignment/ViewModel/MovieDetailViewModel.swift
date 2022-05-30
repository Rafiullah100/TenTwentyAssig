//
//  MovieDetailViewModel.swift
//  TenTwenty Assignment
//
//  Created by EAPPLE on 28/05/2022.
//

import Foundation
import UIKit
import SDWebImage

class MovieDetailViewModel: NSObject {
    var movieId: Int
    var movieDetailLoaded: ((MovieDetail?, Bool) -> Void)?
    var videoLoaded: ((VideoModel?, Bool) -> Void)?
    var movieDetail: MovieDetail?
    var video: VideoModel?
    
    init(movieId: Int) {
        self.movieId = movieId
        super.init()
        self.callServices()
    }
    
    func callServices() {
        ApiManager.shared.retrieveMovieDetail(movieId: movieId ) { [weak self] res in
            switch res {
            case .success(let detail):
                print(detail)
                self?.movieDetail = detail
                self?.movieDetailLoaded?(self?.movieDetail, true)
                self?.keyForVideo()
            case .failure(let error):
                print(error)
                self?.movieDetailLoaded?(nil, false)
            }
        }
    }
    
    func keyForVideo() {
        ApiManager.shared.getVideoKey(movieId: movieDetail?.id ?? 0) { res in
            switch res {
            case .success(let video):
                self.video = video
                self.videoLoaded?(self.video, true)
            case .failure(let err):
                print(err)
                self.videoLoaded?(nil, false)
            }
        }
    }
    
    func getImageUrl() -> URL {
        guard let url = URL(string: "http://image.tmdb.org/t/p/w500/\(movieDetail?.backdrop_path ?? "")") else { return URL(string: "")! }
        return url
    }
    
    func getMovieName() -> String {
        guard let name = movieDetail?.title else { return "" }
        return name
    }
    
    func getDate() -> String {
        guard let releaseDate = movieDetail?.release_date else { return "" }
        return "In Theatre \(releaseDate)"
    }
    
    func getGenre() -> [Genres] {
        return movieDetail?.genres ?? []
    }
    
    func getOverview() -> String{
        guard let overview = movieDetail?.overview else { return "" }
        return overview
    }
    
    func getVideoId() -> String{
        guard let videoKey = video?.results?[0].key else { return "" }
        return videoKey
    }
}
