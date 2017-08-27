//
//  tableVCTwee.swift
//  Berliners
//
//  Created by Martijn van Gogh on 08-03-16.
//  Copyright © 2016 Martijn van Gogh. All rights reserved.
//

import UIKit
import MapKit

//TEVERWIJDEREN


class tableVCTwee: UITableViewController, ButtonCellDelegate {

    /**
    
 */

    var locations:[Loc] = locationData //pointer
    var filteredLocations = [Loc]() // stores searchresults
    let searchController = UISearchController(searchResultsController: nil)
    let navBar = UINavigationBar()
    var largeImName = String() //om mee te nemen naar ImageVC
    var titleName = String() //idem
    var coordinations = CLLocationCoordinate2D() //om mee te nemen naar apple maps
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.dataSource = self
        self.navigationItem.title = "Gaudi en tapas"
        
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
        searchController.searchBar.scopeButtonTitles = ["All", "Chillen", "Drinken", "Eten", "Doen"]
        searchController.searchBar.delegate = self

        tableView.estimatedRowHeight = tableView.rowHeight
        tableView.rowHeight = UITableViewAutomaticDimension
        

    }
    /**
     Return: scopes and searchtext field
     */
    
    func filterContentForSearchText(searchText: String, scope: String = "All") {
        filteredLocations = locations.filter({ location -> Bool in
            let categoryMatch = (scope == "All") || (location.discipline == scope)
            if searchText.isEmpty {
                return categoryMatch
            } else {
                return categoryMatch && location.title!.lowercaseString.containsString(searchText.lowercaseString)
            }
        })
        
        tableView.reloadData()
    }
    func searchBarSearchButtonClicked(searchBar: UISearchBar)
    {
        searchController.active = false
        self.searchController.disablesAutomaticKeyboardDismissal()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.searchController.searchBar.endEditing(true)
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {

        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.active && searchController.searchBar.text != "" || !filteredLocations.isEmpty {
            return filteredLocations.count
        }
        return locations.count
    }

    
    
    //de loc: Loc zorgt ervoor dat je de goede array kiest voor of na filtering!!
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let myCell = self.tableView.dequeueReusableCellWithIdentifier("myCell", forIndexPath: indexPath) as! protoCell
        let loc: Loc
        if searchController.active && (searchController.searchBar.text != "" || !filteredLocations.isEmpty) {
            loc = filteredLocations[indexPath.row]
        } else {
            loc = locations[indexPath.row]
        }
        if myCell.buttonDelegate == nil {
            myCell.buttonDelegate = self
        }
        
        myCell.titleLabel.text = loc.title
        myCell.protoAdress.text = loc.locationName
        myCell.protoDescription.text = loc.descript
        myCell.protoImageView.image = UIImage(named: loc.imageName)
        
        
        /*let saveButton = UIButton(type: .Custom) as UIButton
        saveButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        saveButton.addTarget(self, action: "accessoryButtonTapped:", forControlEvents: .TouchUpInside)
        saveButton.setImage(UIImage(named: "route7.png"), forState: .Normal)
        myCell.accessoryView = saveButton as UIView*/
        
        
        return myCell
    }
   
    func cellTapped(cell: protoCell) {
        var new = String()
        let number = self.tableView.indexPathForCell(cell)!.row
        if searchController.active && (searchController.searchBar.text != "" || !filteredLocations.isEmpty) {
            new = filteredLocations[number].imageName
            titleName = filteredLocations[number].title!

           
        } else {
            new = locations[number].imageName
            titleName = locations[number].title!
            
        }
        
        largeImName = new
        print("\(new) tapped") //maak hier een imgaview.image
        performSegueWithIdentifier("to imageVC", sender: self)
        
        
    }
    
    func accCellTapped(cell: protoCell) {
        var coor = CLLocationCoordinate2D()
        var accLocName = String()
        let number = self.tableView.indexPathForCell(cell)!.row
        if searchController.active && (searchController.searchBar.text != "" || !filteredLocations.isEmpty) {
            
            coor = filteredLocations[number].coordinate
            accLocName = filteredLocations[number].title!
            
        } else {

            titleName = locations[number].title!
            coor = locations[number].coordinate
            accLocName = locations[number].title!
            
        }
        
        coordinations = coor
        print("\(coordinations) tapped")
        let placemark = MKPlacemark(coordinate: coordinations, addressDictionary: nil)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = accLocName
        
        let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeWalking]
        mapItem.openInMapsWithLaunchOptions(launchOptions)
    }

 
    override func tableView(tableView: UITableView, accessoryButtonTappedForRowWithIndexPath indexPath: NSIndexPath) {
        let loc: Loc
        if searchController.active && (searchController.searchBar.text != "" || !filteredLocations.isEmpty) {
            loc = filteredLocations[indexPath.row]
        } else {
            loc = locations[indexPath.row]
        }
        let coordinates: CLLocationCoordinate2D
        coordinates = loc.coordinate
        
        
        let placemark = MKPlacemark(coordinate: coordinates, addressDictionary: nil)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = loc.title
        
        let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeWalking]
        mapItem.openInMapsWithLaunchOptions(launchOptions)
    }
   
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        // Je maakt een var destination aan om aan te geven dat de navigationcontroller wordt overgeslagen en er gesegued wordt naar de visibkle VC, ofwel via een NVC (als die er is zoals hier) of rechtstreeks.
        var destination = segue.destinationViewController as UIViewController
        if let navCon = destination as? UINavigationController {
            destination = navCon.visibleViewController!
        }
        
        if let hvc = destination as? ImageVC {
            hvc.imageName = largeImName
            hvc.titleName = titleName
            
        }
    }
    
 

 


    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
extension tableVCTwee: UISearchResultsUpdating {
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        let searchBar = searchController.searchBar
        let scope = searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex]
        filterContentForSearchText(searchController.searchBar.text!, scope: scope)
    }
}
extension tableVCTwee: UISearchBarDelegate {
    func searchBar(searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        filterContentForSearchText(searchBar.text!, scope: searchBar.scopeButtonTitles![selectedScope])
    }
}
