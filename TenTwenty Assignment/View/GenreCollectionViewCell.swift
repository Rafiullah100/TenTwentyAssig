//
//  GenreCollectionViewCell.swift
//  TenTwenty Assignment
//
//  Created by EAPPLE on 29/05/2022.
//

import UIKit

class GenreCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var label: UILabel!
    static let nib = "GenreCollectionViewCell"
    var indexPathRow: Int?
    let color: [UIColor] = [.red, .green, .blue, .black]
    
    var genre: Genres? {
        didSet {
            print(color[indexPathRow ?? 0])
            bgView.backgroundColor = color[indexPathRow ?? 0]
            bgView.layer.cornerRadius = bgView.frame.size.height / 2.0
            label.text = genre?.name
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
