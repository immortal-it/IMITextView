# IMITextView

![Pod Version](https://img.shields.io/cocoapods/v/IMITextView.svg?style=flat)
![Pod Platform](https://img.shields.io/cocoapods/p/IMITextView.svg?style=flat)
![Pod License](https://img.shields.io/cocoapods/l/IMITextView.svg?style=flat)
[![CocoaPods compatible](https://img.shields.io/badge/CocoaPods-compatible-green.svg?style=flat)](https://cocoapods.org)
[![Carthage Compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)

`IMITextView`  provides background effects of textView like Instagram in iOS.

<img src="https://github.com/immortal-it/IMITextView/tree/main/Images/demon001.png">
<img src="https://github.com/immortal-it/IMITextView/tree/main/Images/demon002.png">
<img src="https://github.com/immortal-it/IMITextView/tree/main/Images/demon003.png">

## Requirements

- iOS 11.0+
- Xcode 12+
- Swift 5.0+

## Installation

### From CocoaPods

[CocoaPods](http://cocoapods.org) is a dependency manager for Cocoa projects, which automates and simplifies the process of using 3rd-party libraries like `IMITextView` in your projects. First, add the following line to your [Podfile](http://guides.cocoapods.org/using/using-cocoapods.html):

```ruby
pod 'IMITextView'
```

If you want to use the latest features of `IMITextView` use normal external source dependencies.

```ruby
pod 'IMITextView', :git => 'https://github.com/immortal-it/IMITextView.git'
```

This pulls from the `main` branch directly.

Second, install `IMITextView` into your project:

```ruby
pod install
```

### Carthage

[Carthage](https://github.com/Carthage/Carthage) is a decentralized dependency manager that builds your dependencies and provides you with binary frameworks. To integrate IMITextView into your Xcode project using Carthage, specify it in your `Cartfile`:

```ogdl
github "immortal-it/IMITextView" ~> 0.0.1
```

### Swift Package Manager

The [Swift Package Manager](https://swift.org/package-manager/) is a tool for automating the distribution of Swift code and is integrated into the `swift` compiler. It is in early development, but IMITextView does support its use on supported platforms.

Once you have your Swift package set up, adding IMITextView as a dependency is as easy as adding it to the `dependencies` value of your `Package.swift`.

```swift
dependencies: [
    .package(url: "https://github.com/immortal-it/IMITextView", .upToNextMajor(from: "0.0.1"))
]
```

### Manually

* Drag the `immortal-it/IMITextView` folder into your project.

## Usage

(see sample Xcode project in `Demon`)
  
- #### Line Background
```swift
let textView = IMITextView()
textView.configuration.lineBackgroundOptions = .fill
```
- #### Line Background Boder
```swift
let textView = IMITextView()
textView.configuration.lineBackgroundOptions = .boder
```

- #### Stroke Outer
```swift
let textView = IMITextView()
textView.configuration.isStrokeOuter = true
textView.configuration.strokeWidth = 10.0
textView.configuration.strokeColor = .red
```

## Customization

`IMITextView` can be customized via the `Configuration`

## License

`IMITextView` is distributed under the terms and conditions of the [MIT license](https://github.com/immortal-it/IMITextView/LICENSE).
