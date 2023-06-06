//
//  TodoContentTblVwCell.swift
//  TodoListDemo
//
//  Created by H S Negi on 05/06/23.
//

import UIKit

class TodoContentTblVwCell: UITableViewCell {

    @IBOutlet weak var checkBtn: UIButton!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var timeLbl: UILabel!
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var statusLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }

    //MARK: - Label Font Setup
    func setupView() {
        titleLbl.font = UIFont(name: FontNames.RubikRegular, size: 16)
        timeLbl.font = UIFont(name: FontNames.RubikRegular, size: 12)
        statusLbl.font = UIFont(name: FontNames.RubikRegular, size: 12)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
