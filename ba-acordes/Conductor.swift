//
//  Conductor.swift
//  ba-acordes
//
//  Created by Mariano Molina on 29/11/15.
//  Copyright © 2015 Pixelbeat. All rights reserved.
//
import AudioKit

class Conductor {
    
    let fmOscillator = FMSynth()
    
    let frequencySequence = AKSequence()
    let modulationIndexSequence = AKSequence()
    
    var randomizeFrequency: AKEvent!
    var randomizeModulationIndex: AKEvent!
    
    var frequencyTimer: NSTimer!
    var modIndexTimer: NSTimer!
    
    //var fx: EffectsProcessor
    
    init() {
        
        randomizeFrequency = AKEvent(block: {
            self.fmOscillator.frequency.randomize()
            self.frequencySequence.addEvent(self.randomizeFrequency, afterDuration: 0.1)
        })
        
        randomizeModulationIndex = AKEvent(block: {
            self.fmOscillator.modulationIndex.randomize()
            self.modulationIndexSequence.addEvent(self.randomizeModulationIndex, afterDuration: 0.2)
        })
        
        frequencySequence.addEvent(randomizeFrequency, atTime: 3.0)
        modulationIndexSequence.addEvent(randomizeModulationIndex, atTime: 0.2)
        
        AKOrchestra.addInstrument(fmOscillator)
    }
    
    func start() {
        fmOscillator.play()
        fmOscillator.frequency.randomize()
        frequencySequence.play()
        modulationIndexSequence.play()
    }
    
    func stop() {
        fmOscillator.stop()
        frequencySequence.stop()
        modulationIndexSequence.stop()
    }
    
}