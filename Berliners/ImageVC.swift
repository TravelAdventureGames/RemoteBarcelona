//
//  ImageVC.swift
//  Berliners
//
//  Created by Martijn van Gogh on 12-03-16.
//  Copyright © 2016 Martijn van Gogh. All rights reserved.
//

import UIKit

class ImageVC: UIViewController {

    @IBOutlet var label: UILabel!
    @IBOutlet var largeImageView: UIImageView!
    var imageName: String = ""
    var titleName: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        largeImageView.image = UIImage(named: imageName)
        label.text = titleName
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }



}
