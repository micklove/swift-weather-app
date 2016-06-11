//
//  ViewController.swift
//  mlo.weather.app
//
//  Created by Love Michael on 11/06/2016.
//  Copyright © 2016 Love Michael. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    
    @IBAction
    func setCityTapped(sender: UIButton) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Hello World");
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

