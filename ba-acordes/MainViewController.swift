//
//  MainViewController.swift
//  ba-acordes
//
//  Created by Mariano Molina on 29/11/15.
//  Copyright © 2015 Pixelbeat. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    var barrios = [NSDictionary]()
    var conductor = Conductor()
    
    @IBOutlet weak var barrioSelectedLabel: UILabel!
    @IBOutlet weak var latLabel: UILabel!
    @IBOutlet weak var longLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let barriosPath = NSBundle.mainBundle().pathForResource("caba_metadata", ofType: "plist")
        barrios = NSArray(contentsOfFile: barriosPath!) as! [NSDictionary]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    // MARK: pickerView
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return barrios.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let item = barrios[row]
        let nombreBarrio = item["barrio"] as! String
        return nombreBarrio
    }

    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        let itemSelect = barrios[row]
        
        self.barrioSelectedLabel.text = "\( itemSelect["barrio"] as! String )"
        self.latLabel.text = "Latitud: \( itemSelect["latitude"] as! String )"
        self.longLabel.text = "Longitud: \( itemSelect["longitude"] as! String )"
        
        let poblacion = Float(itemSelect["poblacion_total"] as! String)
        let arboles   = Float(itemSelect["arboles_por_barrio"] as! String)
        let manzanas  = Float(itemSelect["manzanas_por_barrio"] as! String)
        
        conductor.start()
        
        conductor.setFrequency(poblacion!)
        conductor.setCarrierMultipler(arboles!)
        conductor.setAmplitude(manzanas!)
        
    }
    
    
}
