//
//  OpmaakRoute.swift
//  Berliners
//
//  Created by Martijn van Gogh on 09-03-16.
//  Copyright © 2016 Martijn van Gogh. All rights reserved.
//

import Foundation
import UIKit

class OpmaakButton: UIButton {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setButtonStyle()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func awakeFromNib() {
        setButtonStyle()
    }
    
    func setButtonStyle() {
        
        self.layer.cornerRadius = 5
        self.backgroundColor = UIColor(red: 40/255, green: 146/255, blue: 255/255, alpha: 0.8)
        self.layer.shadowColor = UIColor.grayColor().CGColor
        self.layer.shadowOpacity = 1.0
        self.layer.shadowOffset = CGSizeMake(1.0, 1.0)
        self.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        self.titleLabel!.font = UIFont(name: "Helveticaneue-Bold", size: 10)
        self.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Center
    }
}