//
//  ViewController.swift
//  PhotoStream
//
//  Created by Pierre-Olivier on 01/10/2024.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var introductionView: UIView!
    
    @IBOutlet weak var streamCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        print("Loading app...")
    }

    @IBAction func onIntroductionDismiss(_ sender: Any) {
        print("Dismiss introduction...")
        
        UIView.animate(withDuration: 0.4, delay: 0, options: .transitionCrossDissolve, animations: {
            self.introductionView.alpha = 0
            
            // Apply layout updates
            self.view.layoutIfNeeded()
        })
        
        UIView.animate(withDuration: 0.3, delay: 0.2, options: .transitionCrossDissolve, animations: {
            self.streamCollectionView.frame.origin.y = self.introductionView.frame.origin.y
            self.streamCollectionView.frame.size.height += self.introductionView.frame.height
            
            // Apply layout updates
            self.view.layoutIfNeeded()
        })
    }
    
}

