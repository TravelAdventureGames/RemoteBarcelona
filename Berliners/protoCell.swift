//
//  protoCell.swift
//  Berliners
//
//  Created by Martijn van Gogh on 08-03-16.
//  Copyright © 2016 Martijn van Gogh. All rights reserved.
//

import UIKit

//TEVERWIJDEREN
protocol ButtonCellDelegate {
    func cellTapped(cell: protoCell)
    func accCellTapped(cell: protoCell)
}

class protoCell: UITableViewCell {

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var protoImageView: UIImageView!
    @IBOutlet var protoAdress: UILabel!
    @IBOutlet var protoDescription: UITextView!
    @IBOutlet var button: UIButton!
    @IBOutlet var accButt: UIButton!

    
    //TEVERWIJDEREN
    var buttonDelegate: ButtonCellDelegate?
    
    //TEVERWIJDEREN
    @IBAction func buttonTap(sender: AnyObject) {
        if let delegate = buttonDelegate {
            delegate.cellTapped(self)
        }
    }
    
    @IBAction func butTapAcc(sender: AnyObject) {
        if let delegate = buttonDelegate {
            delegate.accCellTapped(self)
        }
    }


    
    override func awakeFromNib() {
        super.awakeFromNib()
        protoDescription.textAlignment = NSTextAlignment.Justified
        titleLabel.sizeToFit()
        titleLabel.adjustsFontSizeToFitWidth = true
        accButt.setImage(UIImage(named: "route7.png"), forState: .Normal)


        
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
