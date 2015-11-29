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
    
    @IBOutlet weak var frequencySlider: AKPropertySlider!
    @IBOutlet weak var carrierMultiplierSlider: AKPropertySlider!
    @IBOutlet weak var modulationIndexSlider: AKPropertySlider!
    @IBOutlet weak var amplitudeSlider: AKPropertySlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //AKOrchestra.addInstrument(fmOscillator)
//        frequencySlider.property = fmOscillator.frequency
//        carrierMultiplierSlider.property = fmOscillator.carrierMultiplier
//        modulationIndexSlider.property = fmOscillator.modulationIndex
//        amplitudeSlider.property = fmOscillator.amplitude
        
        frequencySlider.property = conductor.fmOscillator.frequency
        modulationIndexSlider.property = conductor.fmOscillator.modulationIndex
        carrierMultiplierSlider.property = conductor.fmOscillator.carrierMultiplier
        amplitudeSlider.property = conductor.fmOscillator.amplitude
    }
    
    // toggleEvent
    @IBAction func toggleInstrument(sender: AnyObject) {
        toggleSwitchClicked.on ? conductor.start() : conductor.stop()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}


