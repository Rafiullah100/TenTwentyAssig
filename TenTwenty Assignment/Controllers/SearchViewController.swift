//
//  SearchViewController.swift
//  TenTwenty Assignment
//
//  Created by EAPPLE on 29/05/2022.
//

import UIKit

class SearchViewController: UIViewController {
    private var searchViewModel: SearchViewModel?
    var searchText: String?
    var array: [Results]?
    @IBOutlet weak var label: UILabel!
    
    @IBOutlet weak var tableView: UITableView!{
        didSet{
            tableView.delegate = self
            tableView.dataSource = self
            tableView.separatorStyle = .none
            tableView.register(UINib(nibName: MovieTableViewCell.nib, bundle: nil), forCellReuseIdentifier: MovieTableViewCell.nib)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchViewModel = SearchViewModel(movieArray: array ?? [], didTextChanged: searchText ?? "")
        label.text = "\(self.searchViewModel?.searchNumberOfRows() ?? 0) results found"
    }
    
    @IBAction func backBtn(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.searchViewModel?.searchNumberOfRows() ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: MovieTableViewCell = tableView.dequeueReusableCell(withIdentifier: MovieTableViewCell.nib) as! MovieTableViewCell
        cell.movie = searchViewModel?.searchGetMovie(index: indexPath.row)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc: MovieDetailViewController = storyboard?.instantiateViewController(withIdentifier: "MovieDetailViewController") as! MovieDetailViewController
        vc.movieId = searchViewModel?.searchGetId(index: indexPath.row)
        present(vc, animated: true, completion: nil)
    }
}
