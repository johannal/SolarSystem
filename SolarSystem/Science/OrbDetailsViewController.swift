//
//  OrbDetailsViewController.swift
//  Science
//
//  Created by Sebastian on 08.05.17.
//  Copyright © 2017 Debugger UI. All rights reserved.
//

/*
 Notes
 
 Methods only called if VC is part of tree:
 override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
 override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
 
 /// Put gravity simulator into landscape if transition to width > height
 */

import UIKit

class OrbDetailsViewController: UIViewController {
    
    @IBOutlet weak var contentContainerView: UIView!
    
    var infoViewController: UIViewController?
    var gravityViewController: UIViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        let segmentedControl = UISegmentedControl.init()
//        segmentedControl.insertSegment(withTitle: "Info", at: 0, animated: false)
//        segmentedControl.insertSegment(withTitle: "Gravity", at: 1, animated: false)
//        segmentedControl.addTarget(self, action: #selector(segmentedControlChanged(_:)), for: .valueChanged)
//        self.navigationItem.titleView = segmentedControl
        
        // Present initial content view controller
        _presentContentController(for: self.view.frame.size)
    }
    
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        super.willTransition(to: newCollection, with: coordinator)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        _presentContentController(for: size)
    }
    
    func _presentContentController(for size: CGSize) {
        if size.width > size.height {
            presentGravityViewController()
        }
        else {
            presentInfoViewController()
        }
    }
    
    @objc func segmentedControlChanged(_ segmentedControl: UISegmentedControl) {
        if segmentedControl.selectedSegmentIndex == 0 {
            // Present info view controller
            presentInfoViewController()
        }
        else if segmentedControl.selectedSegmentIndex == 1 {
            // Present gravity view controller
            presentGravityViewController()
        }
    }
    
    func presentInfoViewController() {
        if infoViewController == nil {
            infoViewController = self.storyboard?.instantiateViewController(withIdentifier: "infoViewController")
        }
        
        if let infoVC = infoViewController {
            gravityViewController?.view.removeFromSuperview()
            gravityViewController?.removeFromParentViewController()
            
            self.addChildViewController(infoVC)
            contentContainerView.addSubview(infoVC.view)
            infoVC.view.frame = contentContainerView.bounds
            infoVC.view.translatesAutoresizingMaskIntoConstraints = true
        }
    }
    
    func presentGravityViewController() {
        if gravityViewController == nil {
            gravityViewController = self.storyboard?.instantiateViewController(withIdentifier: "gravityViewController")
        }
        
        if let gravityVC = gravityViewController {
            infoViewController?.view.removeFromSuperview()
            infoViewController?.removeFromParentViewController()
            
            self.addChildViewController(gravityVC)
            contentContainerView.addSubview(gravityVC.view)
            gravityVC.view.frame = contentContainerView.bounds
            gravityVC.view.translatesAutoresizingMaskIntoConstraints = true
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
