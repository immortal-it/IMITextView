//
//  IMTextViewConfiguration.swift
//  IMITextView
//
//  Created by immortal on 2021/5/8
//  Copyright (c) 2021 immortal. All rights reserved.
//

import UIKit

/// TextView configuration
public struct IMTextViewConfiguration {
    
    /// Text alignment
    public enum TextAlignment: Int {
        
        /// Visually left aligned
        case left
        
        /// Visually center aligned
        case center
        
        /// Visually right aligned
        case right
        
        /// NSTextAlignment
        public var alignment: NSTextAlignment {
            switch self {
                case .left: return .left
                case .center: return .center
                case .right: return .right
            }
        }
    }
    
    /// Line background options
    public typealias LineBackgroundOptions = IMTextLayoutManager.LineBackgroundOptions

    
    /// Text alignment,  default value is`TextAlignment.center`
    public var textAlignment: TextAlignment = .center
     
    /// Text color,  default value is`UIColor.black`
    public var textColor: UIColor = .black
    
    /// Text font,  default value is`UIFont.systemFont(ofSize: 30.0, weight: .bold)`
    public var font: UIFont = UIFont.systemFont(ofSize: 30.0, weight: .bold)
    
    
    /// Whether stroke outer,  default value is`true`
    public var isStrokeOuter: Bool = true
    
    /// In percent of font point size,  default value is`CGFloat.zero`: no stroke; positive for stroke alone, negative for stroke and fill
    public var strokeWidth: CGFloat = .zero
    
    /// Stroke color,  default value is`UIColor.white`
    public var strokeColor: UIColor = .white
    
    
    /// Amount to modify default kerning. 0 means kerning is disabled. default value is`CGFloat.zero`
    public var kern: CGFloat = .zero
    
    
    /// Line background options
    public var lineBackgroundOptions: LineBackgroundOptions = []

    /// Line height percentage for cornerRadius, default value is`0.13`
    public var lineHeightPercentageForCornerRadius: CGFloat = 0.13

    /// Line background content inset, default value is`UIEdgeInsets(top: 5.0, left: 12.0, bottom: 5.0, right: 12.0) `
    public var lineBackgroundInset: UIEdgeInsets = UIEdgeInsets(top: 5.0, left: 12.0, bottom: 5.0, right: 12.0)
                
    /// Line background color, default value is `.white`
    public var lineBackgroundColor: UIColor = .white

    
    /// Line boder width, default value is `2.0`
    public let lineBoderWidth: CGFloat = 2.0
    
    /// Line boder color, default value is `.white`
    public var lineBoderColor: UIColor = .white
}
