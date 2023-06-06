//
//  ViewController+Extensions.swift
//  TodoListDemo
//
//  Created by H S Negi on 06/06/23.
//

import Foundation
import UIKit

extension UIViewController {
    //MARK: - To hide the keyboard on tap of outside the textfield area
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }    
}

extension UILabel {
    //MARK: - To put middle line in the label text
    func lineDrawnInTextMiddle() {
        guard let text = self.text else { return }
        let attributedString = NSMutableAttributedString(string: text)
        let range = NSRange(location: 0, length: attributedString.length)
        attributedString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: NSUnderlineStyle.single.rawValue, range: range)
        attributedString.addAttribute(NSAttributedString.Key.baselineOffset, value: 0, range: range)
        self.attributedText = attributedString
    }
}
