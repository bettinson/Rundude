//
//  FloatingButtonView.swift
//  Runmill
//
//  Created by Matt Bettinson on 2016-08-09.
//  Copyright © 2016 Matt Bettinson. All rights reserved.
//

import UIKit

class FloatingButtonView: UIView {
    
    enum viewRepresenting: Int {
        case EnterRunData = 1
        case NewRun = 2
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.backgroundColor = UIColor.blackColor()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.blackColor()
    }
    
    override func intrinsicContentSize() -> CGSize {
        return CGSize(width: 200, height: 200)
    }
}