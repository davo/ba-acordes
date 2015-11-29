//
//  ViewController.swift
//  ba-acordes
//
//  Created by Davo on 11/28/15.
//  Copyright © 2015 Pixelbeat. All rights reserved.
//

import UIKit
import AudioKit

class ViewController: UIViewController {

    @IBOutlet weak var toggleSwitchClicked: UISwitch!
    
    var conductor = Conductor()
    var conductor2 = Conductor()
    
    @IBOutlet weak var frequencySlider: AKPropertySlider!
    @IBOutlet weak var carrierMultiplierSlider: AKPropertySlider!
    @IBOutlet weak var modulationIndexSlider: AKPropertySlider!
    @IBOutlet weak var amplitudeSlider: AKPropertySlider!
    
    @IBOutlet weak var toggleSwitch2: UISwitch!
    
    @IBOutlet weak var frequencySlider2: AKPropertySlider!
    @IBOutlet weak var carrierMultiplierSlider2: AKPropertySlider!
    @IBOutlet weak var modulationIndexSlider2: AKPropertySlider!
    @IBOutlet weak var amplitudeSlider2: AKPropertySlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // primer instrumento
        frequencySlider.property = conductor.fmOscillator.frequency
        modulationIndexSlider.property = conductor.fmOscillator.modulationIndex
        carrierMultiplierSlider.property = conductor.fmOscillator.carrierMultiplier
        amplitudeSlider.property = conductor.fmOscillator.amplitude
        
        // segundo instrumento
        frequencySlider2.property = conductor2.fmOscillator.frequency
        modulationIndexSlider2.property = conductor2.fmOscillator.modulationIndex
        carrierMultiplierSlider2.property = conductor2.fmOscillator.carrierMultiplier
        amplitudeSlider2.property = conductor2.fmOscillator.amplitude
    }
    
    // toggleEvent
    @IBAction func toggleInstrument(sender: AnyObject) {
        toggleSwitchClicked.on ? conductor.start() : conductor.stop()
    }

    @IBAction func toggleSecondInstrument(sender: AnyObject) {
        toggleSwitch2.on ? conductor2.start() : conductor2.stop()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        conductor.stop()
        conductor2.stop()
    }
}


