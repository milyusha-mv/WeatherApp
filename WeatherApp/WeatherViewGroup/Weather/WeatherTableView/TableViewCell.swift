//
//  TableViewCell.swift
//  WeatherApp
//
//  Created by Михаил Милюша on 27.11.2021.
//

import Foundation
import UIKit

class TableViewCell: UITableViewCell {
    @IBOutlet weak var titleTableLabel: UILabel!
    @IBOutlet weak var valueTableLabel: UILabel!
    @IBOutlet weak var imageTableView: UIImageView!
    
    var tableCell: TableCellIdentifier? {
        didSet {
            updateViews()
        }
    }
    
    func updateViews() {
        guard let tableCell = tableCell as? TableCell else { return }
        titleTableLabel.text = tableCell.title
        if tableCell.valueSign != "" {
            valueTableLabel.text = tableCell.value + tableCell.valueSign
        } else {
            let dateUnix = Double(tableCell.value) ?? 0
            let date = Date(timeIntervalSince1970: dateUnix)
            let formatter  = DateFormatter()
            
            formatter.locale = Locale(identifier: "ru_RU")
            formatter.setLocalizedDateFormatFromTemplate("HH:mm")
            let dateTime = formatter.string(from: date)
            valueTableLabel.text = "\(dateTime)"
            self.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: UIScreen.main.bounds.width)
        }

        imageTableView.image = UIImage(named: tableCell.image)
    }
}
