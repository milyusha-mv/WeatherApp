//
//  TableViewCell.swift
//  WeatherApp
//
//  Created by Михаил Милюша on 27.11.2021.
//

import Foundation
import UIKit

class TableViewCell: UITableViewCell {
    @IBOutlet weak var titleTableLable: UILabel!
    @IBOutlet weak var valueTableLable: UILabel!
    @IBOutlet weak var imageTableView: UIImageView!
    
    var tableCell: TableCellIdentifier? {
        didSet {
            updateViews()
        }
    }
    
    func updateViews() {
        guard let tableCell = tableCell as? TableCell else { return }
        titleTableLable.text = tableCell.title
        valueTableLable.text = "\(tableCell.value) \(tableCell.valueSign)"
        imageTableView.image = UIImage(named: "\(tableCell.image)")
    }
}
