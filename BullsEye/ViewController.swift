//
//  ViewController.swift
//  BullsEye
//
//  Created by Gru on 03/18/15.
//  Copyright (c) 2015 GruTech. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var currentValue: Int = 50

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

        let message = "The value of the slider is: \(currentValue)"
        let alert   = UIAlertController( title: "Hello World",
                                       message: message,
                                preferredStyle: .Alert )

        let action  = UIAlertAction( title: "OK",
                                     style: .Default,
                                   handler: nil )
            alert.addAction( action )

        presentViewController( alert, animated: true, completion: nil )
    }

    @IBAction func sliderMoved( slider: UISlider ) {

        self.currentValue = lroundf(slider.value)
        println( "The value of the slider is now: \(self.currentValue)" )
    }
}

