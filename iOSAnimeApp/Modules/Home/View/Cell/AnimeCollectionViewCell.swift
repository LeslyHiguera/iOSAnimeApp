//
//  AnimeCollectionViewCell.swift
//  iOSAnimeApp
//
//  Created by Lesly Higuera on 13/01/23.
//

import UIKit

class AnimeCollectionViewCell: UICollectionViewCell {
    
    // MARK: - IBOutles Properties
    
    @IBOutlet weak var animeImage: UIImageView!{
        didSet {
            animeImage.layer.cornerRadius = 30
            animeImage.clipsToBounds = true
        }
    }
    
    // MARK: - Properties
    
    var animes: DataInfo? {
        didSet {
            setup()
        }
    }

    private func setup() {
        if let url = animes?.images?.jpg?.image_url {
            animeImage.downloaded(from: url, placeHolder: nil)
        }
    }

}
