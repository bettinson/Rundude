//
//  FloatingButtonContainerView.swift
//  Runmill
//
//  Created by Matt Bettinson on 2016-08-12.
//  Copyright © 2016 Matt Bettinson. All rights reserved.
//

import UIKit

class FloatingButtonContainerView: UIView {
    let iconSize : CGFloat = 50
    let screenFrame = UIScreen.mainScreen().bounds
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let offSet : CGFloat = 50
        
        let dividerView = UIView(frame: CGRect(x: (screenFrame.width / 2 ) - (30 / 2) , y: (screenFrame.height / 2) - (CGFloat(5)), width: 30, height: 5))
        let newRunButton = FloatingButtonView(frame: CGRect(x: (screenFrame.width / 2 ) - (iconSize / 2), y: (screenFrame.height / 2) - (CGFloat(iconSize)) + (offSet * 2), width: iconSize, height: iconSize))
        
        let addRunButton = FloatingButtonView(frame: CGRect(x: (screenFrame.width / 2 ) - (iconSize / 2), y: (screenFrame.height / 2) - (CGFloat(iconSize)) - offSet, width: iconSize, height: iconSize))
        
        addRunButton.backgroundColor = UIColor.blueColor()
        
        
        dividerView.backgroundColor = UIColor.darkGrayColor()
        self.addSubview(dividerView)
        self.addSubview(newRunButton)
        self.addSubview(addRunButton)
        dividerView.transform.a = 0
        let darkenView = UIView(frame: screenFrame)
        darkenView.backgroundColor = UIColor.blackColor()
        darkenView.alpha = 0
        
        UIView.animateWithDuration(0.3, animations: {
                darkenView.alpha = 0.3
                dividerView.transform.a = 10
            }, completion: {(finished: Bool) -> Void in
                print("done")
        })
        
        self.addSubview(darkenView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func intrinsicContentSize() -> CGSize {
        return screenFrame.size
    }
}
