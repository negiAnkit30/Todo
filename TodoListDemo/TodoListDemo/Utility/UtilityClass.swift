//
//  UtilityClass.swift
//  TodoListDemo
//
//  Created by H S Negi on 05/06/23.
//

import Foundation
import UIKit


class UtilityClass : NSObject {
    
    //MARK: - Date Formatter
    class func getTimeInStringFormat(dueDate: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm a"
        let timeString = dateFormatter.string(from: dueDate)
        return timeString
    }
}



