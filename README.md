# EasyAttributes

[![CI Status](https://travis-ci.org/michaelversus/EasyAttributes.svg?branch=master)](https://travis-ci.org/michaelversus/EasyAttributes.svg?branch=master)
[![Version](https://img.shields.io/cocoapods/v/EasyAttributes.svg?style=flat)](https://cocoapods.org/pods/EasyAttributes)
[![License](https://img.shields.io/cocoapods/l/EasyAttributes.svg?style=flat)](https://cocoapods.org/pods/EasyAttributes)
[![Platform](https://img.shields.io/cocoapods/p/EasyAttributes.svg?style=flat)](https://cocoapods.org/pods/EasyAttributes)
[![codecov](https://codecov.io/gh/michaelversus/EasyAttributes/branch/master/graph/badge.svg)](https://codecov.io/gh/michaelversus/EasyAttributes)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

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

## Author

Michalis Karagiorgos, michaliskarag@gmail.com

## License

EasyAttributes is available under the MIT license. See the LICENSE file for more info.
