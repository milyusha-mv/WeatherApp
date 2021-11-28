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
        guard let collectionCell = collectionCell as? WeatherCell else { return }
        part_nameLablel.text = collectionCell.part_name
        tempLabel.text = "\(collectionCell.temp_min)° - \(collectionCell.temp_max)°"
        feels_likeLabel.text = "\(collectionCell.feels_like)"
        
//        guard let imageURL = URL(string: predictionCell.imageCollection) else { return }
//        guard let imageData = RequestManager.shared.fetchImage(with: imageURL) else { return }
//        imageCollectionView.image = UIImage(data: imageData)
    }
}
