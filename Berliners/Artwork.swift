//
//  Loc.swift
//  Berliners
//
//  Created by Martijn van Gogh on 08-03-16.
//  Copyright © 2016 Martijn van Gogh. All rights reserved.
//


import Foundation
import MapKit
import AddressBook
import Contacts

class Loc: NSObject, MKAnnotation {
    
    let title: String?
    let locationName: String
    let descript: String
    let coordinate: CLLocationCoordinate2D
    let imageName: String
    let discipline: String
    
    init(title: String, locationName: String, descript: String, coordinate: CLLocationCoordinate2D, imageName: String, discipline: String) {
        self.title = title
        self.locationName = locationName
        self.descript = descript
        self.coordinate = coordinate
        self.imageName = imageName
        self.discipline = discipline
        
        super.init()
        
    }
    var subtitle: String? {
        return locationName
    }
    func pinTintColor() -> UIColor  {
        switch discipline {
        case "Chillen":
            return UIColor.orangeColor()
        case "Drinken":
            return UIColor.purpleColor()
        case "Eten":
            return UIColor.blueColor()
        case "Doen":
            return UIColor.blackColor()
        default:
            return UIColor.greenColor()
        }
    }
    
    // annotation callout info button opens this mapItem in Maps app
    func mapItem() -> MKMapItem {
        let addressDictionary = [String(CNPostalAddressStreetKey): locationName]
        let placemark = MKPlacemark(coordinate: coordinate, addressDictionary: addressDictionary)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = title
        
        return mapItem
        
    }
}