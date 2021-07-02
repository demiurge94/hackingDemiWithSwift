//
//  DetailViewController.swift
//  project1
//
//  Created by Erick Vicencio on 6/28/21.
//
/* ----Notes from course-----
    Auto Layout takes care of layout in different screen sizes
    Auto layout rules are called constraints
 */
import UIKit

class DetailViewController: UIViewController {
    @IBOutlet var imageView: UIImageView!
    var selectedImage: String?
    var currentPicture: Int = 0
    var totalPictures: Int = 0
    override func viewDidLoad() {
        navigationItem.largeTitleDisplayMode = .never
        super.viewDidLoad()
        title = "\(currentPicture) of \(totalPictures)"
        /*Soooo, because selectedImage has ?, we need to check it first, meaning iflet*/
        if let imageToLoad = selectedImage{
            imageView.image = UIImage(named: imageToLoad)
        }
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool){
        //super - "tell my parent data type that these methods were called"
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = true
    }
    //set to true only when DetailView controller is showing
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.hidesBarsOnTap = false
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
