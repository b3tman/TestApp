//
//  PhotosCollectionViewController.swift
//  TestApp
//
//  Created by Максим Бриштен on 16.01.2018.
//  Copyright © 2018 Максим Бриштен. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class PhotosCollectionViewController: UICollectionViewController {

    //MARK: - Outlets
    
    @IBOutlet weak var menuBarButton: UIBarButtonItem!
    
    //MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
        enableSlideMenu()
    }
    
    //MARK: - Private
    
    private func enableSlideMenu() {
        if self.revealViewController() != nil {
            menuBarButton.target = self.revealViewController()
            menuBarButton.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
    }
    
    private func setupCollectionView() {
        let nib = UINib(nibName: "PhotoCollectionViewCell", bundle: nil)
        collectionView!.register(nib, forCellWithReuseIdentifier: reuseIdentifier)
        
        let collectionViewLayout = collectionView!.collectionViewLayout as! UICollectionViewFlowLayout
        collectionViewLayout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }

    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView,
                   numberOfItemsInSection section: Int) -> Int {
        return 10
    }

    override func collectionView(_ collectionView: UICollectionView,
                          cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier,
                                                                      for: indexPath) as! PhotoCollectionViewCell
        
        cell.photoImageView.image = UIImage(named: "armin")
    
        return cell
    }

}

    //MARK: - Extension UICollectionViewDelegateFlowLayout

extension PhotosCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
             layout collectionViewLayout: UICollectionViewLayout,
                 sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenSize = UIScreen.main.bounds
        let screenWidth = screenSize.width
        let cellWidth = screenWidth / 3 - 15
        let cellHeight = cellWidth
        
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
}
    
