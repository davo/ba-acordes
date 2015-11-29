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
    
    init() {
        // Modulation Index Random.
        randomizeModulationIndex = AKEvent(block: {
            self.fmOscillator.modulationIndex.randomize()
            self.modulationIndexSequence.addEvent(self.randomizeModulationIndex, afterDuration: 0.2)
        })
        modulationIndexSequence.addEvent(randomizeModulationIndex, atTime: 0.2)
        
        AKOrchestra.addInstrument(fmOscillator)
    }
    
    func start() {
        fmOscillator.play()
        modulationIndexSequence.play()
    }
    
    func stop() {
        fmOscillator.stop()
        modulationIndexSequence.stop()
    }
    
    // Funciones de control de sintetizador. >>Edit Lucas.
    
    //Frecuencia.
    func setFrequency(Frec: Float) {
        fmOscillator.frequency.value = Frec
    }
    //carrierMutipler
    func setCarrierMultipler(Mult: Float) {
        fmOscillator.carrierMultiplier.value = Mult
    }
    //Amplitude
    func setAmplitude(Amp: Float) {
        fmOscillator.amplitude.value = Amp
    }
    //    Esta puesta Random.
    //    //Modulation Index
    //    func setModulationIndex(Mod: Float) {
    //        fmOscillator.modulationIndex.value = Mod
    //    }
    
}