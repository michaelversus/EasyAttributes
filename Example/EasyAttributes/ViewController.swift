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
        EasyAttributes.configFonts(with: ["pr":"PermanentMarker-Regular"], fontAdaptationFactor: 1.1)
        let string = "Hello <c:ebebeb><b26><u>I am a bold colored underlined string </u></b26></c> and <i14><u>i am an italic string underlined</u></i14> Hello there <u>again</u>  Hello there <u>again</u> <pr36>this is custom font string</pr36><s23> System string</s23>"
        dump(string.toAttributed())
        lbl.attributedText = string.toAttributed()
        return lbl
    }()
    
    lazy var textView: UITextView = {
        EasyAttributes.configFonts(with: ["pr":"PermanentMarker-Regular"], fontAdaptationFactor: 1.1)
        let string = "<pr25>System string click </pr25><a:chat>here</a>"
        
        let textView = UITextView(
            easyAttributesString: string,
            font: UIFont(name: "PermanentMarker-Regular", size: 25)!,
            textColor: .black,
            backgroundColor: .white,
            textAlignment: .left,
            linkColor: .red
        )
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.delegate = self
        return textView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(label)
        view.addSubview(textView)
        
        label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        label.heightAnchor.constraint(equalToConstant: 400).isActive = true
        
        textView.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 20).isActive = true
        textView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        textView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        textView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        textView.heightAnchor.constraint(equalToConstant: 400).isActive = true
        
    }
}

extension ViewController: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange) -> Bool {
        if URL.absoluteString == "easy://chat" {
            debugPrint("clicked a link")
        }
        return false
    }
}
