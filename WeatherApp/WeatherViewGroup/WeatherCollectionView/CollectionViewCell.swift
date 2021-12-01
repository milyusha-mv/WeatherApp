//
//  CollectionViewCell.swift
//  WeatherApp
//
//  Created by Михаил Милюша on 27.11.2021.
//

import Foundation
import UIKit

protocol CollectionCellRepresentable {
    var collectionCell: CollectionCellIdentifier? { get set }
}

class CollectionViewCell: UICollectionViewCell, CollectionCellRepresentable {
    
    
    @IBOutlet weak var part_nameLablel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var feels_likeLabel: UILabel!
    @IBOutlet weak var imageCollectionView: UIImageView!
    
    var collectionCell: CollectionCellIdentifier? {
        didSet {
            updateViews()
        }
    }
    
    func updateViews() {
        guard let collectionCell = collectionCell as? CollectionCell else { return }
        part_nameLablel.text = collectionCell.partName
        if collectionCell.tempMin != collectionCell.tempMax {
            tempLabel.text = "\(collectionCell.tempMin)° - \(collectionCell.tempMax)°"
        } else { tempLabel.text = "\(collectionCell.tempMin)°" }
        feels_likeLabel.text = "Ощущается \(collectionCell.feelsLike)"
        imageCollectionView.image = UIImage(named: "\(collectionCell.imageCollection)")
        
    }
}
