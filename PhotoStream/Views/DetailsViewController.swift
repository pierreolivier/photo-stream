//
//  DetailViewController.swift
//  PhotoStream
//
//  Created by Pierre-Olivier on 02/10/2024.
//
import UIKit
import Foundation

class DetailsViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    
    @IBAction func closeDetails(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
