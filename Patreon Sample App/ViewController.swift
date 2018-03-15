//
//  ViewController.swift
//  Patreon Sample App
//
//  Created by Foti Dim on 07.03.18.
//  Copyright © 2018 FotiDim. All rights reserved.
//

import UIKit
import Patreon

class ViewController: UIViewController {
    
    let patreon = Patreon()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func getProfile(_ sender: Any) {
        patreon.profile { (result) in
            switch result {
            case .success(let profile):
                print(profile)
            case .failure(let error):
                fatalError("error: \(error.localizedDescription)")
            }
        }
    }
    

}

