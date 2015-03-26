//
//  ViewController.swift
//  BullsEye
//
//  Created by Gru on 03/18/15.
//  Copyright (c) 2015 GruTech. All rights reserved.
//
// Apprentice Tutorial #1

import UIKit

class ViewController: UIViewController {

    let DEBUG : Bool = false

    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var target: UILabel!
    @IBOutlet weak var  score: UILabel!
    @IBOutlet weak var  round: UILabel!

    var currentValue: Int = 0
    var sliderValue:  Int = 0
    var targetValue:  Int = 0
    var difference:   Int = 0
    var scoreValue:   Int = 0
    var roundValue:   Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        startNewRound()
        updateLabels()


        // Apprentice Tutorial #1 p.112-113, Perking up the slider
        let thumbImageNormal = UIImage( named: "SliderThumb-Normal" )
        slider.setThumbImage( thumbImageNormal, forState: .Normal )

        let thumbImageHighLighted = UIImage( named: "SliderThumb-Highlighted" )
        slider.setThumbImage( thumbImageHighLighted, forState: .Highlighted )

        let insets = UIEdgeInsets( top: 0, left: 14, bottom: 0, right: 14 )

        if let trackLeftImage = UIImage( named: "SliderTrackLeft" ) {
            let trackLeftResizable = trackLeftImage.resizableImageWithCapInsets( insets )
            slider.setMinimumTrackImage( trackLeftResizable, forState: .Normal )
        }

        if let trackRightImage = UIImage( named: "SliderTrackRight" ) {
            let trackRightResizeable = trackRightImage.resizableImageWithCapInsets( insets )
            slider.setMaximumTrackImage( trackRightResizeable, forState: .Normal )
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func startNewRound() {
        self.targetValue  = 1 + Int(arc4random_uniform(100))
        self.currentValue = 50
        self.slider.value = Float(self.currentValue)

        self.roundValue  += 1
    }

    func updateLabels() {
        target.text = String(targetValue)   // or the next line does the same thing...
    //  target.text = "\(targetValue)"         both are valid

        score.text  = "\(scoreValue)"
        round.text  = "\(roundValue)"
    }

    // Setting up an 'alert' popup, activated when the user taps or clicks the 'Hit Me!' button.
    @IBAction func showAlert() {

        var difference : Int = abs(targetValue - currentValue)
        var points : Int     = 100 - difference

        var title     = ""
        if difference == 0 {
            title     = "Bull's Eye, Perfect shot"
            points   += 100       // Bonus Points for a perfect hit.
        } else if difference < 5 {
            title     = "Close, but not quite!"
            if difference == 1 {
                points   += 50
            }
        } else if difference < 10 {
            title     = "Pretty good"
        } else {
            title     = "Not even close!"
        }

        scoreValue += points


        var message = "\nYou scored \(points) points\n\nMissed target by \(difference) with a \(currentValue)/\(targetValue)."
        if DEBUG {
            message = "The value of the slider is: \(currentValue)"
                    + "\nThe target value is: \(targetValue)"
                    + "\nThe difference is: \(difference)"
                    + "\nYou scored \(points) points"
                    + "\nYour score is \(scoreValue)"
        }

        let alert   = UIAlertController( title: title,
                                       message: message,
                                preferredStyle: .Alert )

        // Setting up 'handler' to execute the 'startNewRound()' and 'updateLabels()' calls after
        // the user selects the OK on the Alert popup.  p.87
        let action  = UIAlertAction( title: "OK",
                                     style: .Default,
                                   handler: { action in self.startNewRound()    // This is called a closure... p.88
                                                        self.updateLabels()
                                            } )
        alert.addAction( action )

        presentViewController( alert, animated: true, completion: nil )
    }

    // The method catches slider events, and updates 'currentValue' w/ the current location of the slider.
    @IBAction func sliderMoved( slider: UISlider ) {

        self.currentValue = lroundf(slider.value)
        if self.DEBUG { println( "The value of the slider is now: \(self.currentValue)" ) }
    }

    // Implementing the 'Start Over' button.  p.88
    @IBAction func startOver() {

        // Exercise was just to restart the game.  I pumped it up a little by asking the 'Are you sure' question by
        // allowing the player to cancel the 'new game' request and resume the current game.

        if self.DEBUG { println( "Let's see if the player wants to start over w/ a new game or continue." ) }

        var refreshAlert = UIAlertController( title: "New Game?",
                                            message: "Would you like to start a 'new game'\n or \n 'Resume' the current game",
                                     preferredStyle: UIAlertControllerStyle.Alert)

        refreshAlert.addAction(UIAlertAction( title: "New Game",
                                              style: .Default,
                                            handler: { ( action: UIAlertAction!) in
                                                if self.DEBUG { println("Handle 'New Game' logic here") }
                                                self.roundValue = 0
                                                self.scoreValue = 0
                                                self.startNewRound()
                                                self.updateLabels()
                                            }))

        refreshAlert.addAction(UIAlertAction( title: "Resume",
                                              style: .Default,
                                            handler: { (action: UIAlertAction!) in
                                                if self.DEBUG { println("Handle 'Resume Game' Logic here") }
                                            }))

        presentViewController(refreshAlert, animated: true, completion: nil)
     }

}

