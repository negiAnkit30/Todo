//
//  AlertView.swift
//  TodoListDemo
//
//  Created by H S Negi on 05/06/23.
//

protocol DeleteTodoIteemProtocol: AnyObject {
    func deleteItemFromList(checkOkPress:Bool)
}

import UIKit

class AlertView: UIViewController {
    //MARK: - @IBOutlet
    @IBOutlet weak var warningLbl: UILabel!
    @IBOutlet weak var subLbl: UILabel!
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var okBtn: UIButton!
    
    //MARK: - Delete Delegate
    weak var delegate:DeleteTodoIteemProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupLabelView()
    }
    
    //MARK: - Label Setup
    func setupLabelView() {
        warningLbl.font = UIFont(name: FontNames.RubikMedium, size: 18)
        subLbl.font = UIFont(name: FontNames.RubikRegular, size: 14)
        cancelBtn.titleLabel?.font = UIFont(name:FontNames.RubikMedium, size: 14)
        okBtn.titleLabel?.font = UIFont(name:FontNames.RubikMedium, size: 14)
    }
    
    //MARK: - IBAction
    @IBAction func okBtnAction(_ sender: UIButton) {
        delegate?.deleteItemFromList(checkOkPress: true)
        self.dismiss(animated: true)
    }
    
    @IBAction func cancelBtnAction(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
}
