//
//  ViewController.swift
//  EasyAttributes
//
//  Created by Michalis Karagiorgos on 11/17/2019.
//  Copyright (c) 2019 Michalis Karagiorgos. All rights reserved.
//

import UIKit
import EasyAttributes

class ViewController: UIViewController {

    let label: UILabel = {
       let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.numberOfLines = 0
        lbl.textColor = .black
        lbl.textAlignment = .center
        lbl.font = UIFont.systemFont(ofSize: 16)
        let string = "Hello <c:ebebeb>there</c> <b26><u>I am a bold string</u></b26> and <i14>i am an italic string</i14> Hello there <u>again</u>"
        lbl.attributedText = string.toAttributed()
        return lbl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(label)
        
        label.topAnchor.constraint(equalTo: view.topAnchor, constant: 70).isActive = true
        label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

