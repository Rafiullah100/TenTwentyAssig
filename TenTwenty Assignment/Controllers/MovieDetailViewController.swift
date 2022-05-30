//
//  MovieDetailViewController.swift
//  TenTwenty Assignment
//
//  Created by EAPPLE on 28/05/2022.
//

import UIKit
import AVFoundation
import youtube_ios_player_helper

class MovieDetailViewController: UIViewController {
    
    @IBOutlet weak var playerView: YTPlayerView!{
        didSet{
            playerView.delegate = self

        }
    }
    var movieId: Int?
    private var detailMovieViewModel: MovieDetailViewModel!

    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var getTicketBtn: UIButton!
    @IBOutlet weak var watchBtn: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!{
        didSet{
            collectionView.delegate = self
            collectionView.dataSource = self
            collectionView.register(UINib(nibName: GenreCollectionViewCell.nib, bundle: nil), forCellWithReuseIdentifier: GenreCollectionViewCell.nib)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        playerView.playVideo()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
        detailMovieViewModel = MovieDetailViewModel(movieId: movieId ?? 0)
        loadMovieDetail()
    }
    
    private func initialSetup(){
        getTicketBtn.layer.cornerRadius = 10
        watchBtn.layer.cornerRadius = 10
        watchBtn.layer.borderWidth = 1.0
        watchBtn.layer.borderColor = UIColor.blue.cgColor
    }
    
    private func loadMovieDetail(){
        self.detailMovieViewModel.movieDetailLoaded = {_, success in
            if success {
                self.loadDataIntoView()
                self.collectionView.reloadData()
            }
        }
        
        self.detailMovieViewModel.videoLoaded = { _, success in
            if success {
                self.playVideo()
            }
        }
    }
    
    @IBAction func trailerBtn(_ sender: Any) {
        self.playVideo()
    }
    
    @IBAction func cancel(_ sender: Any) {
        playerView.stopVideo()
        bgView.isHidden = true
    }
    
    private func loadDataIntoView(){
        imageView.sd_setImage(with: detailMovieViewModel.getImageUrl(), placeholderImage: nil)
        nameLabel.text = detailMovieViewModel.getMovieName()
        dateLabel.text = detailMovieViewModel.getDate()
        textView.text = detailMovieViewModel.getOverview()
    }
    
    private func playVideo(){
        bgView.isHidden = false
        playerView.load(withVideoId: detailMovieViewModel.getVideoId())
    }
    
    @IBAction func back(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func getTicket(_ sender: Any) {
    }
}

extension MovieDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return detailMovieViewModel.getGenre().count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: GenreCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: GenreCollectionViewCell.nib, for: indexPath) as! GenreCollectionViewCell
        cell.indexPathRow = indexPath.row
        cell.genre = detailMovieViewModel.getGenre()[indexPath.row]
        return cell
    }    
}

extension MovieDetailViewController: YTPlayerViewDelegate{
    func playerViewDidBecomeReady(_ playerView: YTPlayerView) {
        playerView.playVideo()
    }
    func playerView(_ playerView: YTPlayerView, didChangeTo state: YTPlayerState) {
        if state == .ended {
            bgView.isHidden = true
        }
    }
}
