//
//  NewsListTableViewCell.swift
//  GeeksforGeeks
//
//  Created by MAC on 11/08/21.
//

import UIKit

class NewsListTableViewCell: UITableViewCell {
    //MARKS:- IBOutlets
    @IBOutlet weak var listImg:UIImageView!
    @IBOutlet weak var titleLbl:UILabel!
    @IBOutlet weak var dateLbl:UILabel!
    @IBOutlet weak var timeLbl:UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
