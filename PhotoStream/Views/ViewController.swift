//
//  ViewController.swift
//  PhotoStream
//
//  Created by Pierre-Olivier on 01/10/2024.
//

import UIKit
import Combine

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var introductionView: UIView!
    
    private var collectionViewModel = PhotoCollectionViewModel()
    private var cancellables = Set<AnyCancellable>()
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        print("Loading app...")
        
        setupCollectionView()
        bindViewModel()
    }
    
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 100, height: 100)
        collectionView.collectionViewLayout = layout
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    private func bindViewModel() {
        collectionViewModel.$photos
                    .receive(on: RunLoop.main)
                    .sink { [weak self] _ in
                        self?.collectionView.reloadData()
                    }
                    .store(in: &cancellables)
    }

    @IBAction func onIntroductionDismiss(_ sender: Any) {
        print("Dismiss introduction...")
        
        UIView.animate(withDuration: 0.4, delay: 0, options: .transitionCrossDissolve, animations: {
            self.introductionView.alpha = 0
            
            // Apply layout updates
            self.view.layoutIfNeeded()
        })
        
        UIView.animate(withDuration: 0.4, delay: 0.1, options: .transitionCrossDissolve, animations: {
            self.collectionView.frame.origin.y = self.introductionView.frame.origin.y
            self.collectionView.frame.size.height += self.introductionView.frame.height
            
            // Apply layout updates
            self.view.layoutIfNeeded()
        })
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("\(collectionViewModel.photos.count)")
        return collectionViewModel.photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        let item = collectionViewModel.photos[indexPath.item]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 100)
    }
    
}

