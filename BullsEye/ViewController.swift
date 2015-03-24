//
//  ViewController.swift
//  BullsEye
//
//  Created by Gru on 03/18/15.
//  Copyright (c) 2015 GruTech. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // Setting up an 'alert' popup, activated when the user taps or clicks the 'Hit Me!' button.
    @IBAction func showAlert() {
        let alert  = UIAlertController( title: "Hello World",
                                      message: "This is my first app!",
                               preferredStyle: .Alert )
        let action = UIAlertAction( title: "Awesome", style: .Default, handler: nil )
            alert.addAction( action )

        presentViewController( alert, animated: true, completion: nil )
    }
}

