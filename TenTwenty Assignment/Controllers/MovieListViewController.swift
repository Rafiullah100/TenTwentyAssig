//
//  MovieListViewController.swift
//  TenTwenty Assignment
//
//  Created by EAPPLE on 28/05/2022.
//

import UIKit
import AVFoundation
class MovieListViewController: UIViewController {

    @IBOutlet weak var searchField: UITextField!
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var tableView: UITableView!{
        didSet{
            tableView.delegate = self
            tableView.dataSource = self
            tableView.separatorStyle = .none
            tableView.register(UINib(nibName: MovieTableViewCell.nib, bundle: nil), forCellReuseIdentifier: MovieTableViewCell.nib)
        }
    }
    
    private var movieViewModel = MovieViewModel()
    var searchText: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
        loadMovie()
        searchField.addTarget(self, action: #selector(textChanged)
                              , for: .editingChanged)
        searchField.addTarget(self, action: #selector(MyTextFieldAction)
                              , for: UIControl.Event.primaryActionTriggered)
    }

    
    @objc func textChanged(textField: UITextField){
        searchText = textField.text
    }
    
    @objc func MyTextFieldAction(textField: UITextField) {
        let vc: SearchViewController = storyboard?.instantiateViewController(withIdentifier: "SearchViewController") as! SearchViewController
        vc.searchText = self.searchText
        vc.array = movieViewModel.getArray()
        present(vc, animated: true, completion: nil)
    }
    
    private func initialSetup(){
        searchView.layer.cornerRadius = searchView.frame.size.height / 2.0
    }
    
    private func loadMovie(){
        self.movieViewModel.movieLoaded = { [weak self] (_, success) in
            if success {
                self?.tableView.reloadData()
            }
        }
    }
    
    @IBAction func clearBtn(_ sender: Any) {
        searchField.resignFirstResponder()
        searchField.text = ""
    }
}

extension MovieListViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.movieViewModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: MovieTableViewCell = tableView.dequeueReusableCell(withIdentifier: MovieTableViewCell.nib) as! MovieTableViewCell
        cell.movie = movieViewModel.getMovie(index: indexPath.row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc: MovieDetailViewController = storyboard?.instantiateViewController(withIdentifier: "MovieDetailViewController") as! MovieDetailViewController
        vc.movieId = movieViewModel.getId(index: indexPath.row)
        present(vc, animated: true, completion: nil)
    }
}

