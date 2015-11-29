//
//  MainViewController.swift
//  ba-acordes
//
//  Created by Mariano Molina on 29/11/15.
//  Copyright © 2015 Pixelbeat. All rights reserved.
//

import UIKit
import MapKit

class MainViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    var barrios = [NSDictionary]()
    var conductor = Conductor()
    @IBOutlet weak var myMap: MKMapView!
    
    let gradient:CAGradientLayer? = CAGradientLayer()
    
    @IBOutlet weak var barrioSelectedLabel: UILabel!
    @IBOutlet weak var latLabel: UILabel!
    @IBOutlet weak var longLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let barriosPath = NSBundle.mainBundle().pathForResource("caba_metadata", ofType: "plist")
        barrios = NSArray(contentsOfFile: barriosPath!) as! [NSDictionary]
    }
    
    override func viewDidAppear(animated: Bool) {
        let gradientLayerView: UIView = UIView(frame: CGRectMake(0, 0, view.bounds.width, view.bounds.height))
        
        self.gradient?.frame = self.view.bounds
        self.gradient?.colors = [ UIColor(rgba: "#4355D7").CGColor, UIColor(rgba: "#41f3b9").CGColor]
        
        gradientLayerView.layer.insertSublayer(gradient!, atIndex: 0)
        
        gradientLayerView.layer.cornerRadius = 10
        gradientLayerView.layer.masksToBounds = true
        
        self.view.layer.insertSublayer(gradientLayerView.layer, atIndex: 0)
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
        
        let comuna = Int(itemSelect["comuna"] as! String)
        // gradien
        self.animateLayer(comuna!)
        
        // CLLocationCoordinate2D(latitude: cityObjSelect.lat, longitude: cityObjSelect.lon)
//        cityCoords?.latitude = Double(itemSelect["latitude"] as! String)!
//        cityCoords?.longitude = Double(itemSelect["longitude"] as! String)!
        
        var cityCoords = CLLocationCoordinate2D(latitude: Double(itemSelect["latitude"] as! String)!, longitude: Double(itemSelect["longitude"] as! String)!)
        let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        let region = MKCoordinateRegion(center: cityCoords, span: span)
        myMap.setRegion(region, animated: true)
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print(error)
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // update location
        manager.startUpdatingLocation()
        
        if let location = locations.last {
            let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
            let region = MKCoordinateRegion(center: location.coordinate, span: span)
            myMap.setRegion(region, animated: true)
        }
    }
    
    
    func animateLayer(comuna:Int){
        let toColors: [AnyObject]
        
        switch comuna {
            
        case 0...(2):
            toColors = [UIColor(rgba: "#4CC7A1").CGColor, UIColor(rgba: "#38918B").CGColor]
        case 2...4:
            toColors = [UIColor(rgba: "#245B76").CGColor, UIColor(rgba: "#102260").CGColor]
        case 4...6:
            toColors = [UIColor(rgba: "#732766").CGColor, UIColor(rgba: "#422463").CGColor]
        case 6...8:
            toColors = [UIColor(rgba: "#D82B6C").CGColor, UIColor(rgba: "#9238fa").CGColor]
        case 8...10:
            toColors = [UIColor(rgba: "#ED8B67").CGColor, UIColor(rgba: "#0fefcd").CGColor]
        case 10...12:
            toColors = [UIColor(rgba: "#FFF161").CGColor, UIColor(rgba: "#fb8303").CGColor]
        case 12...14:
            toColors = [UIColor(rgba: "#fbd103").CGColor, UIColor(rgba: "#fb8303").CGColor]
        case 14...15:
            toColors = [UIColor(rgba: "#fbd103").CGColor, UIColor(rgba: "#fb8303").CGColor]
        default:
            toColors = [UIColor(rgba: "#1804D2").CGColor, UIColor(rgba: "#0091FF").CGColor]
            
        }
        
        let fromColors = self.gradient?.colors
        
        self.gradient!.colors = toColors
        
        let animation : CABasicAnimation = CABasicAnimation(keyPath: "colors")
        
        animation.fromValue = fromColors
        animation.toValue = toColors
        animation.duration = 2
        animation.removedOnCompletion = true
        animation.fillMode = kCAFillModeForwards
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        animation.delegate = self
        
        self.gradient?.addAnimation(animation, forKey:"animateGradient")
    }
    
    
}
