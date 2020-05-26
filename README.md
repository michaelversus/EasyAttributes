# EasyAttributes

[![CI Status](https://travis-ci.org/michaelversus/EasyAttributes.svg?branch=master)](https://travis-ci.org/michaelversus/EasyAttributes.svg?branch=master)
[![Version](https://img.shields.io/cocoapods/v/EasyAttributes.svg?style=flat)](https://cocoapods.org/pods/EasyAttributes)
[![License](https://img.shields.io/cocoapods/l/EasyAttributes.svg?style=flat)](https://cocoapods.org/pods/EasyAttributes)
[![Platform](https://img.shields.io/cocoapods/p/EasyAttributes.svg?style=flat)](https://cocoapods.org/pods/EasyAttributes)
[![codecov](https://codecov.io/gh/michaelversus/EasyAttributes/branch/master/graph/badge.svg)](https://codecov.io/gh/michaelversus/EasyAttributes)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements
iOS 10+

## Installation

EasyAttributes is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'EasyAttributes'
```

## Usage
```swift
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
}
```

## Result
![Screenshot](https://github.com/michaelversus/EasyAttributes/blob/master/screenshots/Label.png)

## Custom Fonts
If you'd like to use custom fonts you must: 

1) register the custom fonts.
You can find instructions here: https://developer.apple.com/documentation/uikit/text_display_and_fonts/adding_a_custom_font_to_your_app

then inside ViewController...

```swift
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
        EasyAttributes.configFonts(with: ["pr":"PermanentMarker-Regular"])
        let string = "Hello <c:ebebeb>there</c> <b26><u>I am a bold string</u></b26> and <i14>i am an italic string</i14> Hello there <u>again</u> <pr36>this is custom font string</pr36>"
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
```
## Result
![Screenshot](https://github.com/michaelversus/EasyAttributes/blob/master/screenshots/CustomFontsLabel.png)

## UITextView clickable links

```swift
import UIKit
import EasyAttributes

class ViewController: UIViewController {

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
        view.addSubview(textView)
        textView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        textView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        textView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
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
```
## Result
![Screenshot](https://github.com/michaelversus/EasyAttributes/blob/master/screenshots/UITextViewLinks.png)

## Author

Michalis Karagiorgos, michaliskarag@gmail.com

## License

EasyAttributes is available under the MIT license. See the LICENSE file for more info.
