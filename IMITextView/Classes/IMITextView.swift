//
//  IMITextView.swift
//  IMITextView
//
//  Created by immortal on 2021/5/6
//  Copyright (c) 2021 immortal. All rights reserved.
//

import UIKit

/// A scrollable, multiline text region.
@available(iOS 11.0, *)
public class IMITextView: UIScrollView {
     
    private let storage = NSTextStorage()
    
    private let layoutManager: IMTextLayoutManager = {
        let layoutManager = IMTextLayoutManager()
        layoutManager.allowsNonContiguousLayout = false
        layoutManager.usesFontLeading = false
        if #available(iOS 12.0, *) {
            layoutManager.limitsLayoutForSuspiciousContents = false
        }
        return layoutManager
    }()
    
    private let container: NSTextContainer = {
        let container = NSTextContainer(size: .zero)
        container.widthTracksTextView = true
        container.heightTracksTextView = true
        container.lineFragmentPadding = .zero
        return container
    }()
    
    public private(set) lazy var textView: UITextView = {
        let textView = IMUITextView(frame: .zero, textContainer: container)
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.backgroundColor = .clear
        textView.contentInset = .zero
        textView.clipsToBounds = false
        textView.textContainerInset = .init(top: 12.0, left: 24.0, bottom: 12.0, right: 24.0)
        textView.contentInsetAdjustmentBehavior = .never
        textView.isEditable = true
        textView.panGestureRecognizer.isEnabled = false
        textView.contentScaleFactor = UIScreen.main.scale
        // isScrollEnabled must be false，otherwise the background drawing will show an exception
        textView.isScrollEnabled = false
        return textView
    }()
    
    /// Whether is appending nwewline
    private var isAppendingNewline: Bool = false

    /// Configuration
    public var configuration: IMTextViewConfiguration = IMTextViewConfiguration() {
        didSet { apply(configuration) }
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        initView()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func initView() {
        layoutManager.addTextContainer(container)
        storage.addLayoutManager(layoutManager)
        loadSubviews()
        textView.delegate = self
        showsVerticalScrollIndicator = false
        showsHorizontalScrollIndicator = false
        alwaysBounceVertical = false
        backgroundColor = .clear
        apply(configuration)
    }
    
    private func loadSubviews() {
        addSubview(textView)
        let topConstraint = textView.topAnchor.constraint(greaterThanOrEqualTo: contentLayoutGuide.topAnchor)
        topConstraint.priority = .defaultHigh
        let centerYConstraint = textView.centerYAnchor.anchorWithOffset(to: contentLayoutGuide.topAnchor).constraint(equalTo: heightAnchor, multiplier: -0.5)
        centerYConstraint.priority = .defaultLow
        NSLayoutConstraint.activate([
            textView.widthAnchor.constraint(equalTo: widthAnchor),
            centerYConstraint,
            topConstraint,
            textView.bottomAnchor.constraint(equalTo: contentLayoutGuide.bottomAnchor),
            textView.leadingAnchor.constraint(equalTo: contentLayoutGuide.leadingAnchor),
            textView.trailingAnchor.constraint(equalTo: contentLayoutGuide.trailingAnchor)
        ])
    }
    
    private func apply(_ configuration: IMTextViewConfiguration) {
        layoutManager.isCanDrawGlyphsOutsideStroke = configuration.isStrokeOuter
        
        layoutManager.lineBackgroundOptions = configuration.lineBackgroundOptions
        layoutManager.lineHeightPercentageForCornerRadius = configuration.lineHeightPercentageForCornerRadius
        layoutManager.lineBackgroundInset = configuration.lineBackgroundInset
        layoutManager.lineBackgroundColor = configuration.lineBackgroundColor
        layoutManager.lineBoderWidth = configuration.lineBoderWidth
        layoutManager.lineBoderColor = configuration.lineBoderColor
        
        textView.textContainerInset = configuration.lineBackgroundInset

        textView.typingAttributes[.strokeWidth] = configuration.strokeWidth * textView.contentScaleFactor
        textView.typingAttributes[.strokeColor] = configuration.strokeColor
        textView.typingAttributes[.kern] = configuration.kern * textView.contentScaleFactor
         
        textView.font = configuration.font
        textView.textColor = configuration.textColor
        textView.textAlignment = configuration.textAlignment.alignment
        
        let stringRange = NSRange(location: 0, length: storage.mutableString.length)
        if stringRange.length > 0 {
            storage.addAttributes(textView.typingAttributes, range: stringRange)
        }
        textView.setNeedsDisplay()
    }
    
    public var text: String {
        get { textView.text ?? "" }
        set { textView.text = newValue }
    }
    
    public var isEditable: Bool {
        get { textView.isEditable }
        set { textView.isEditable = newValue }
    }
    
    // MARK: - FirstResponder
    
    @discardableResult
    public override func becomeFirstResponder() -> Bool {
        textView.becomeFirstResponder()
    }
    
    public override var canBecomeFirstResponder: Bool {
        textView.canBecomeFirstResponder
    }
    
    public override var canResignFirstResponder: Bool {
        textView.canResignFirstResponder
    }
    
    @discardableResult
    public override func resignFirstResponder() -> Bool {
        textView.resignFirstResponder()
    }
    
    public override var isFirstResponder: Bool {
        textView.isFirstResponder
    }
}

extension IMITextView: UITextViewDelegate {
    
    /// Auto scroll to current caret
    public func textViewDidChange(_ textView: UITextView) {
        textView.setNeedsDisplay()
        if isAppendingNewline {
            isAppendingNewline = false
            if let font = textView.attributedText.attribute(.font, at: 0, effectiveRange: nil) as? UIFont {
                contentOffset.y += font.lineHeight + layoutManager.lineBackgroundInset.top + layoutManager.lineBackgroundInset.bottom
            }
        }
    }
    
    public func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if textView.text.isEmpty && text.isEmpty {
            return false
        }
        isAppendingNewline = text.hasSuffix("\n")
        return true
    }
}
