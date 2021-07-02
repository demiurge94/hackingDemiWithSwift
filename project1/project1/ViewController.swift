//
//  ViewController.swift
//  project1
//
//  Created by Erick Vicencio on 6/28/21.
//

import UIKit

class ViewController: UITableViewController {
    var pictures = [String]()
    override func viewDidLoad() {
        navigationController?.navigationBar.prefersLargeTitles = true 
        title = "Wallpaper Viewer"
        super.viewDidLoad()
        let fm = FileManager.default
        //declares a constant assigned value, data type that let's us work with file
        let path = Bundle.main.resourcePath!
        //declare constant path set to resource path of our app bundle
        let items = try! fm.contentsOfDirectory(atPath: path)
        //declare constant set to contents of directory at path items is arr of strings with file names
        
        for item in items{
            if item.hasSuffix("jpg"){
                pictures.append(item)
            }
        }
        // Do any additional setup after loading the view.
        print(pictures)
    }
    /*
     override - method has been defined already, so we need to override it
     '_' - remnant of objective c. means the first parameter isn't passed in when using a name when called externally, where the name of the first paramater was usually built right into the method name!
        mean's it's like tableView(someTableView)
     */
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return pictures.count
    }
    /*cellForRowAt is a method from tableView, see documentation
    it is called when you need to provide a row. The row to show will
    be specified in teh parameter indexPath, type IndexPath*/
    override func tableView(_ tableView:UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
        // creates a new constant called cell by dequeuing a recycled
        //cell from the table. 'Picture' is the name of the identifier of
        //cell type that we want to recycle.
        cell.textLabel?.text = pictures[indexPath.row] //? means do this only if there's an actual text label there
        return cell
    }
    //returns UITableViewCell
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath ){
        //1: Try loading the "Detail" view controller and typecasting it to be detail
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController{
            //2: Upon success, set its selectedImage property
            vc.selectedImage = pictures[indexPath.row]
            vc.currentPicture = indexPath.row
            vc.totalPictures = pictures.count
            //3: now push it onto the navigation controller
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}

