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
                let formattingPatternRange = formatterIndex ..< hourFormattingPattern.index(after: formatterIndex)
                if hourFormattingPattern.substring(with: formattingPatternRange) != String (replacementChar) {
                    finalText = finalText.appendingFormat(hourFormattingPattern.substring(with: formattingPatternRange))
                } else if tempString.characters.count >= 0 {
                    let pureStringRange:Range = tempIndex ..< tempString.index(after: tempIndex)
                    finalText = finalText.appendingFormat(tempString.substring(with: pureStringRange))
                    if (finalText.index(after: tempIndex) != finalText.endIndex) {
                        tempIndex = finalText.index(after: tempIndex)
                    }
                }
                if (finalText.index(after: formatterIndex) != finalText.endIndex) {
                    formatterIndex = finalText.index(after: formatterIndex)
                }
                if formatterIndex >= hourFormattingPattern.endIndex || tempIndex >= tempString.endIndex {
                    stop = true
                }
            }
        }
        
        finalText = String(finalText.characters.reversed())
        
        return finalText.substring(to: finalText.index(before: finalText.endIndex)) 
    }
}
