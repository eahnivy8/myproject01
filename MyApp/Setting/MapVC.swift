//
//  MapVC.swift
//  MyApp
//
//  Created by xeozin on 07/07/2019.
//  Copyright © 2019 xeozin. All rights reserved.
//

import UIKit
import MapKit

class MapVC: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    
    var loc = CLLocationCoordinate2D(latitude: 0, longitude: 0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        drawMap()
    }
    
    func drawMap() {
        let span = MKCoordinateSpan.init(latitudeDelta: 1, longitudeDelta: 1)
        let region = MKCoordinateRegion(center: loc, span: span)
        self.mapView.setRegion(region, animated: true)
    }

}
