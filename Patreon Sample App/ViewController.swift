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
        
        if let url = Bundle.main.url(forResource:"Configuration", withExtension: "plist") {
            do {
                let data = try Data(contentsOf:url)
                let configuration = try PropertyListSerialization.propertyList(from: data, options: [], format: nil) as! [String:Any]
                if let accessToken = configuration["AccessToken"] as? String {
                    saveAccessToken(accessToken)
                }
            } catch {
                print(error)
            }
        }

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
        if let accessToken = accesTokenTextField.text, !accessToken.isEmpty {
            saveAccessToken(accessToken)
        }
    }
    
    func saveAccessToken(_ accesssToken: String) {
        guard let data = accesssToken.data(using: .utf8) else {
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

