//
//  DetailViewController.swift
//  Notes
//
//  Created by mainul on 7/9/17.
//  Copyright © 2017 mainul. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - Custom Method

    func setupUI() {
        UIGraphicsBeginImageContext(self.view.frame.size)
        UIImage(named: "noteBG")?.draw(in: self.view.bounds)
        
        if let image = UIGraphicsGetImageFromCurrentImageContext() {
            UIGraphicsEndImageContext()
            self.view.backgroundColor = UIColor(patternImage: image)
        } else{
            UIGraphicsEndImageContext()
        }
        
        title = "Note"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveButtonTapped))
        
    }
    
    func saveButtonTapped(selector: Any) {
        print("tapped")
    }

}
