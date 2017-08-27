//
//  VCMapExtensions.swift
//  Berliners
//
//  Created by Martijn van Gogh on 08-03-16.
//  Copyright © 2016 Martijn van Gogh. All rights reserved.
//

import Foundation
import MapKit

extension ViewController: MKMapViewDelegate {
    
    // zorgt voor de vormgeving van de pinannotation, waaronder rightcalloutaccessoryview.
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        if let annotation = annotation as? Loc {
            let identifier = "pin"
            var view: MKPinAnnotationView
            if let dequeuedView = mapView.dequeueReusableAnnotationViewWithIdentifier(identifier)
                as? MKPinAnnotationView { // 2
                    dequeuedView.annotation = annotation
                    view = dequeuedView
            } else {
                
                view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)//Hier heb je de annotationverwijzing die de koppeling met de ARtwork class maakt.
                view.canShowCallout = true
                view.calloutOffset = CGPoint(x: -25, y: 5)
                
            }

            
            view.pinTintColor = annotation.pinTintColor()
            
            return view
        }
        return nil
    }
    
    
    // Bizar! Deze func zegt wat er gebeurt als er op de accessorycontrol wordt getapt. De app 'Maps' van Apple wordt geopend in directionsmode , waarbij standaard voor driving wordt gekozen. Dit ziet er waanzinnig uit!
    func mapView(mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if control == view.rightCalloutAccessoryView {
            let location = view.annotation as! Loc
            let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeWalking]
            location.mapItem().openInMapsWithLaunchOptions(launchOptions)
        } else if control == view.leftCalloutAccessoryView {
            performSegueWithIdentifier("to ImageVC", sender: view)
        }
        
        
    }
    //Is de eerste tap om de annotation te selecteren, waarop de callout voor het eerst opkomt.
    func mapView(mapView: MKMapView, didSelectAnnotationView view: MKAnnotationView) {
        //we zetten dit pas in de didselect functie, want anders wordt alles al geladen als het misschien niet eens nodig is. Je laadt dus pas als dat nodig is, in didselect...
        
        let textString = view.annotation as! Loc
        let titleString = view.annotation as! Loc
        label.text = "\(titleString.title!)"
        textView.text = "\(textString.descript)"
        
        //maak leftcalloutaccesory met image
        let imName = view.annotation as! Loc
        let butImName = UIImage(named: imName.imageName)
        let imButton = UIButton(type: .Custom)
        imButton.frame = CGRectMake(0, 0, 35, 35)
        imButton.setImage(butImName, forState: .Normal)
        view.leftCalloutAccessoryView = imButton
        
        //maakt rightcalloutaccesory met i-button
        let image = UIImage(named: "route7.png")
        let button = UIButton(type: .Custom)
        button.frame = CGRectMake(0, 0, 35, 35)
        button.setImage(image, forState: .Normal)
        view.rightCalloutAccessoryView = button
        
        createOverlay()
        showAlert()
    
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "to ImageVC" {
            if let waypoint = (sender as? MKAnnotationView)?.annotation as? Loc {
                if let ivc = segue.destinationViewController as? ImageVC {
                    ivc.imageName = waypoint.imageName
                    ivc.titleName = waypoint.title!
                }
            }
        }
    }
    
}

