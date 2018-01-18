//
//  MainViewController.swift
//  TestApp
//
//  Created by Максим Бриштен on 16.01.2018.
//  Copyright © 2018 Максим Бриштен. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    enum TabIndex : Int {
        case loginTab = 0
        case registerTab = 1
    }
    
    //MARK: - Outlets
    
    @IBOutlet weak var customSegmentedControl: CustomSegmentedControl!
    @IBOutlet weak var contentView: UIView!
    
    //MARK: - Properties
    
    var currentViewController: UIViewController?
    
    lazy var loginVC: UIViewController? = {
        let loginVC = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewControllerId")
        
        return loginVC
    }()
    lazy var registerVC: UIViewController? = {
        let registerVC = self.storyboard?.instantiateViewController(withIdentifier: "RegisterViewControllerId")
        
        return registerVC
    }()
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customSegmentedControl.initUI()
        customSegmentedControl.selectedSegmentIndex = TabIndex.loginTab.rawValue
        displayCurrentTab(TabIndex.loginTab.rawValue)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if let currentViewController = currentViewController {
            currentViewController.viewWillDisappear(animated)
        }
    }
    
    // MARK: - Switching Tabs Functions
    
    @IBAction func switchTabs(_ sender: UISegmentedControl) {
        self.currentViewController!.view.removeFromSuperview()
        self.currentViewController!.removeFromParentViewController()
        displayCurrentTab(sender.selectedSegmentIndex)
    }
    
    private func displayCurrentTab(_ tabIndex: Int){
        if let vc = viewControllerForSelectedSegmentIndex(tabIndex) {
            
            self.addChildViewController(vc)
            vc.didMove(toParentViewController: self)
            
            vc.view.frame = self.contentView.bounds
            self.contentView.addSubview(vc.view)
            self.currentViewController = vc
        }
    }
    
    private func viewControllerForSelectedSegmentIndex(_ index: Int) -> UIViewController? {
        var vc: UIViewController?
        switch index {
        case TabIndex.loginTab.rawValue :
            vc = loginVC
        case TabIndex.registerTab.rawValue :
            vc = registerVC
        default:
            return nil
        }
        
        return vc
    }
}
