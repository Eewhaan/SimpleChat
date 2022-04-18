//
//  DateFormatter.swift
//  simpleChat
//
//  Created by Ivan Pavic on 18.4.22..
//

import Foundation

extension Date {
    func toString() -> String {
        let convertDateFormatter = DateFormatter()
        convertDateFormatter.dateFormat = "MMM dd yyyy h:mm a"
        return convertDateFormatter.string(from: self)
    }
}
