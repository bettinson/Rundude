//
//  FloatingButtonView.swift
//  Runmill
//
//  Created by Matt Bettinson on 2016-08-09.
//  Copyright © 2016 Matt Bettinson. All rights reserved.
//

import UIKit

protocol FloatingButtonDelegate: class {
    //viewRepresenting is an enum that represents which view is intended whent the button is tapped
    func buttonWasTapped(sender: FloatingButtonDelegate, button: FloatingButton.viewRepresentingOptions)
}

class FloatingButton: UIView, UIGestureRecognizerDelegate {
    
    let colour = UIColor.black
    weak var delegate:FloatingButtonDelegate?
    var viewRepresenting : viewRepresentingOptions?
    
    enum viewRepresentingOptions: Int {
        case EnterRunData = 1
        case NewRun = 2
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.backgroundColor = colour
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = colour
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 200, height: 200)
    }
    
    func changeViewRepresenting(viewRepresenting: viewRepresentingOptions) {
        if viewRepresenting == viewRepresentingOptions.NewRun {
            let newRunTap = UITapGestureRecognizer(target: self, action: #selector(self.newRunTapped))
            newRunTap.delegate = self
            self.addGestureRecognizer(newRunTap)
        }
        if viewRepresenting == viewRepresentingOptions.EnterRunData {
            let addRunTap = UITapGestureRecognizer(target: self, action: #selector(self.addRunTapped))
            addRunTap.delegate = self
            self.addGestureRecognizer(addRunTap)
        }
    }
    
    func addRunTapped(sender: UITapGestureRecognizer? = nil) {
        delegate?.buttonWasTapped(sender: self.delegate!, button: FloatingButton.viewRepresentingOptions.EnterRunData)
        //Dismiss view
    }
    
    func newRunTapped(sender: UITapGestureRecognizer? = nil) {
        delegate?.buttonWasTapped(sender: self.delegate!, button: FloatingButton.viewRepresentingOptions.NewRun)
        //Dismiss view
    }
}
