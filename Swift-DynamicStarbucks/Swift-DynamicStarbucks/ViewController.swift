//
//  ViewController.swift
//  Swift-DynamicStarbucks
//
//  Created by caiwenshu on 11/4/15.
//  Copyright © 2015 caiwenshu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        let cupView:CupView = CupView(frame: CGRectMake(0,40,320,480))
        self.view .addSubview(cupView)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    

}

