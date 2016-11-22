//
//  TimeFormatter.swift
//  Runmill
//
//  Created by Matt Bettinson on 2016-07-05.
//  Copyright © 2016 Matt Bettinson. All rights reserved.
//

import Foundation

class TimeFormatter: NSObject {
    //Change this however you want
    var hourFormattingPattern = "**:**:**"
    var replacementChar: Character = "*"
    
    
    override init() {
        super.init()
    }
    
    func changeText(_ changeString: String) -> String {
        //Assumes string is a number
        var finalText = ""
        
        var newString = changeString
        newString = String(changeString.characters.reversed())
        
        if newString.characters.count > 0 && hourFormattingPattern.characters.count > 0 {
            let tempString = newString as String
            
            var stop = false
            
            var formatterIndex = hourFormattingPattern.startIndex
            var tempIndex = tempString.startIndex
            
            while !stop {
                let formattingPatternRange = formatterIndex ..< newString.index(formatterIndex, offsetBy: 1)
                if hourFormattingPattern.substring(with: formattingPatternRange) != String (replacementChar) {
                    finalText = finalText.appendingFormat(hourFormattingPattern.substring(with: formattingPatternRange))
                } else if tempString.characters.count > 0 {
                    let pureStringRange:Range = tempIndex ..< finalText.index(tempIndex, offsetBy: 1)
                    finalText = finalText.appendingFormat(tempString.substring(with: pureStringRange))
                    tempIndex = finalText.index(after: tempIndex)
                }
                formatterIndex = finalText.index(after: formatterIndex)
                
                if formatterIndex >= hourFormattingPattern.endIndex || tempIndex >= tempString.endIndex {
                    stop = true
                }
            }
        }
        
        finalText = String(finalText.characters.reversed())
        
        return finalText
    }
}
