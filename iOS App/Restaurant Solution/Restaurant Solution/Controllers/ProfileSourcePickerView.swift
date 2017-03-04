//
//  ProfileSourcePickerView.swift
//  Restaurant Solution
//
//  Created by Scott McKenzie on 2/23/17.
//  Copyright © 2017 Danny Harding. All rights reserved.
//

import UIKit

class ProfileSourcePickerView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    class func instantiateFromNib() -> ProfileSourcePickerView{
        return Bundle.main.loadNibNamed("ProfileSourcePickerView", owner: nil, options: nil)!.first as! ProfileSourcePickerView
    }

}
