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

    @IBOutlet weak var accesTokenTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if let data = KeyChain.load(key: "AccessToken"),
            let result = String(data: data, encoding: String.Encoding.utf8){
                print("result: " + result)
                accesTokenTextField.text = result
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func saveAccessToken(_ sender: Any) {
        guard let data = accesTokenTextField.text?.data(using: .utf8) else {
            return
        }
        let status = KeyChain.save(key: "AccessToken", data: data)
        print("status: ", status)
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

