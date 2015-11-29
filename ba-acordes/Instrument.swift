//
//  File.swift
//  ba-acordes
//
//  Created by Mariano Molina on 29/11/15.
//  Copyright © 2015 Pixelbeat. All rights reserved.
//
import AudioKit

class FMSynth: AKInstrument {
    
    var frequency = AKInstrumentProperty(value: 440, minimum: 150, maximum: 740)
    var carrierMultiplier = AKInstrumentProperty(value: 0.5, minimum: 0.0, maximum: 1.0)
    var modulationIndex = AKInstrumentProperty(value: 0.5, minimum: 0.0, maximum: 1.0)
    var amplitude   = AKInstrumentProperty(value: 0.25, minimum: 0.0, maximum: 0.5)
    
    override init() {
        super.init()
        
        // add property constructor
        addProperty(frequency)
        addProperty(carrierMultiplier)
        addProperty(modulationIndex)
        addProperty(amplitude)
        
        // set instrument constructor
        let fmOscillator = AKFMOscillator()
        fmOscillator.baseFrequency = frequency
        fmOscillator.carrierMultiplier = carrierMultiplier
        fmOscillator.modulationIndex = modulationIndex
        fmOscillator.amplitude = amplitude
        
        // set Output
        setAudioOutput(fmOscillator)
    }
    
}
