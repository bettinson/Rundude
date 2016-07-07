//
//  TimeFormatter.swift
//  Runmill
//
//  Created by Matt Bettinson on 2016-07-05.
//  Copyright © 2016 Matt Bettinson. All rights reserved.
//

import Foundation

class TimeFormatter: NSObject {
    var hourFormattingPattern = "**:**:**"
    var replacementChar: Character = "*"
    
    
    override init() {
        super.init()
    }
    
    func changeText(string: String) -> String {
        //Assumes string is a number
        var finalText = ""
        
        if string.characters.count > 0 && hourFormattingPattern.characters.count > 0 {
            let tempString = string as String
            
            var stop = false
            
            var formatterIndex = hourFormattingPattern.startIndex
            var tempIndex = tempString.startIndex
            
            while !stop {
                let formattingPatternRange = formatterIndex ..< formatterIndex.advancedBy(1)
                if hourFormattingPattern.substringWithRange(formattingPatternRange) != String (replacementChar) {
                    finalText = finalText.stringByAppendingString(hourFormattingPattern.substringWithRange(formattingPatternRange))
                } else if tempString.characters.count > 0 {
                    let pureStringRange:Range = tempIndex ..< tempIndex.advancedBy(1)
                    finalText = finalText.stringByAppendingString(tempString.substringWithRange(pureStringRange))
                    tempIndex = tempIndex.successor()
                }
                formatterIndex = formatterIndex.successor()
                
                if formatterIndex >= hourFormattingPattern.endIndex || tempIndex >= tempString.endIndex {
                    stop = true
                }
                
            }
            
        }
        return finalText
    }
}