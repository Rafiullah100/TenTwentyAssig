//
//  SeacrhViewModel.swift
//  TenTwenty Assignment
//
//  Created by EAPPLE on 29/05/2022.
//

import Foundation

class SearchViewModel: NSObject {
    var filteredArray: [Results]?
    
    var movieArray: [Results]?
    var didTextChanged: String?
    
    init(movieArray: [Results], didTextChanged: String) {
        self.movieArray = movieArray
        self.didTextChanged = didTextChanged
        super.init()
        self.searchForText()
    }
    
    func searchForText() {
        filteredArray = []
        movieArray?.forEach({ element in
            if let strRange: Range = element.title!.range(of: didTextChanged ?? "", options: .caseInsensitive, range: nil, locale: nil) {
                if !strRange.isEmpty{
                    filteredArray?.append(element)
                }
            }
        })
        print(filteredArray ?? [])
    }
    
    func searchNumberOfRows() -> Int {
        return filteredArray?.count ?? 0
    }
    
    func searchGetMovie(index: Int) -> Results? {
        return filteredArray?[index]
    }
    
    func searchGetId(index: Int) -> Int? {
        return filteredArray?[index].id
    }
}
