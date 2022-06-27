//
//  Common.swift
//  LocalStorage
//
//  Created by Kiroshan Thayaparan on 6/27/22.
//

import Foundation

class Common {
    
    class func getDateOfBirthFormat(dateAndTime: String) -> String {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSXXX"
        
        let showDate = inputFormatter.date(from: dateAndTime)
        inputFormatter.dateFormat = "yyyy MMM dd"
        var resultString = ""
        if showDate != nil {
            resultString = inputFormatter.string(from: showDate!)
        }
        return resultString
    }
}
