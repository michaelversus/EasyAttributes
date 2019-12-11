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
        EasyAttributes.configFonts()
        let string = "Hello <c:ebebeb><b26><u>I am a bold colored underlined string </u></b26></c> and <i14><u>i am an italic string underlined</u></i14> Hello there <u>again</u>  Hello there <u>again</u> <pr36>this is custom font string</pr36>"
        lbl.attributedText = string.toAttributed()
        return lbl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(label)
        label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        label.heightAnchor.constraint(equalToConstant: 400).isActive = true
    }
}

