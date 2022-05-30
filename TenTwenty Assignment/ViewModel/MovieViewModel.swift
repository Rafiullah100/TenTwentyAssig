//
//  MovieViewModel.swift
//  TenTwenty Assignment
//
//  Created by EAPPLE on 28/05/2022.
//

import Foundation

class MovieViewModel: NSObject {
    var movieLoaded: (([Results]?, Bool) -> Void)?
    var movieArray: [Results]?
    
    override init() {
        super.init()
        self.callServices()
    }
    
    func callServices() {
        ApiManager.shared.retrieveMovie { [weak self] res in
            switch res {
            case .success(let movie):
                self?.movieArray = movie.movieArray
                self?.movieLoaded?(self?.movieArray, true)
            case .failure(let error):
                print(error)
                self?.movieLoaded?(nil, false)
            }
        }
    }
    
    func numberOfRows() -> Int {
        return movieArray?.count ?? 0
    }
    
    func getMovie(index: Int) -> Results? {
        return movieArray?[index]
    }
    
    func getId(index: Int) -> Int? {
        return movieArray?[index].id
    }
    
    func getArray() -> [Results] {
        return movieArray ?? []
    }
}


