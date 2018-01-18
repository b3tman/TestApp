//
//  MapViewController.swift
//  TestApp
//
//  Created by Максим Бриштен on 16.01.2018.
//  Copyright © 2018 Максим Бриштен. All rights reserved.
//

import UIKit

class MapViewController: UIViewController {

    //MARK: - Outlets
    
    @IBOutlet weak var menuBarButton: UIBarButtonItem!
    
    //MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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

}
