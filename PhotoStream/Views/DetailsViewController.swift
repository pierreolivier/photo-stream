//
//  DetailViewController.swift
//  PhotoStream
//
//  Created by Pierre-Olivier on 02/10/2024.
//
import UIKit
import Foundation

class DetailsViewController: UIViewController {
    var photo: Photo?
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var author: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        if let photo = photo {
            image.image = photo.image
            name.text = "Photo \(photo.id)"
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM-dd-yyyy 'at' HH:mm"
            let formattedDate = dateFormatter.string(from: photo.date)
            date.text = "Taken on \(formattedDate)"
            
            author.text = photo.author
        }
    }
    
    @IBAction func closeDetails(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
}
