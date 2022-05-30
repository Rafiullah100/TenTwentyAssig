//
//  MovieTableViewCell.swift
//  TenTwenty Assignment
//
//  Created by EAPPLE on 28/05/2022.
//

import UIKit
import SDWebImage
class MovieTableViewCell: UITableViewCell {

    static let nib = "MovieTableViewCell"
    
    @IBOutlet weak var categoryLabeL: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    
    var movie: Results? {
        didSet {
            imgView.layer.cornerRadius = 10.0
            titleLabel.text = movie?.title
            categoryLabeL.text = movie?.releaseDate
            imgView.sd_setImage(with: URL(string: "http://image.tmdb.org/t/p/w500/\(movie?.posterPath ?? "")"), placeholderImage: nil)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
