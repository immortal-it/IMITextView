//
//  IMUITextView.swift
//  IMITextView
//
//  Created by immortal on 2021/5/8
//  Copyright (c) 2021 immortal. All rights reserved.
//

import UIKit

/// A scrollable, multiline text region.
class IMUITextView: UITextView {
    
    /// Ajust first rect
    override func firstRect(for range: UITextRange) -> CGRect {
        var firstRect = super.firstRect(for: range)
        if let layoutManager = layoutManager as? IMTextLayoutManager {
            // Fix error rect for lineBackgroundInset.bottom
            firstRect.origin.y -= layoutManager.lineBackgroundInset.bottom
            
            // Fix error rect for whitespace
            if textAlignment == .center {
                let glyphRange = layoutManager.glyphRange(forBoundingRect: firstRect, in: textContainer)
                let lineText = textStorage.attributedSubstring(from: glyphRange).string.replacingOccurrences(of: " ", with: "")
                if lineText.isEmpty {
                    firstRect.origin.x -= firstRect.width * 0.5
                }
            }
        }
        return firstRect
    }

    /// Ajust caret position
    override func caretRect(for position: UITextPosition) -> CGRect {
        var caretRect = super.caretRect(for: position)
        if let layoutManager = layoutManager as? IMTextLayoutManager {
            // Fix error rect for lineBackgroundInset.bottom
            caretRect.origin.y -= layoutManager.lineBackgroundInset.bottom

            // Fix error rect for whitespace
            if textAlignment == .center {
                let glyphIndex = layoutManager.glyphIndex(for: caretRect.origin, in: textContainer)
                let lineRect = layoutManager.lineFragmentUsedRect(forGlyphAt: glyphIndex, effectiveRange: nil)
                let glyphRange = layoutManager.glyphRange(forBoundingRect: lineRect, in: textContainer)
                let lineText = textStorage.attributedSubstring(from: glyphRange).string.replacingOccurrences(of: " ", with: "")
                if lineText.isEmpty {
                    caretRect.origin.x -= lineRect.width * 0.5
                }
            }
            
         }
        return caretRect
    }

    /// Ajust selection rects
    override func selectionRects(for range: UITextRange) -> [UITextSelectionRect] {
        let selectionRects = super.selectionRects(for: range)
        if let layoutManager = layoutManager as? IMTextLayoutManager, layoutManager.lineBackgroundInset.bottom > 0 {
            return selectionRects.map({
//                // Fix error rect for whitespace
//                if textAlignment == .center {
//                    let glyphRange = layoutManager.glyphRange(forBoundingRect: $0.rect, in: textContainer)
//                    let lineText = textStorage.attributedSubstring(from: glyphRange).string.replacingOccurrences(of: " ", with: "")
//                    if lineText.isEmpty {
//                        let lineRect = layoutManager.lineFragmentUsedRect(forGlyphAt: glyphRange.location, effectiveRange: nil)
//                        return IMUITextSelectionMutableRect($0, offset: CGPoint(x: -lineRect.width * 0.5, y: -layoutManager.lineBackgroundInset.bottom))
//                    }
//                }
                // Fix error rect for lineBackgroundInset.bottom
                return IMUITextSelectionMutableRect($0, offset: CGPoint(x: 0.0, y: -layoutManager.lineBackgroundInset.bottom))
            })
        }
        return selectionRects
    }
    
    override var textContainerInset: UIEdgeInsets {
        set {
            if let layoutManager = layoutManager as? IMTextLayoutManager {
                // Fix error rect for lineBackgroundInset.bottom
                super.textContainerInset = UIEdgeInsets(top: newValue.top + layoutManager.lineBackgroundInset.bottom,
                                                        left: newValue.left,
                                                        bottom: newValue.bottom - layoutManager.lineBackgroundInset.bottom,
                                                        right: newValue.right)
            } else {
                super.textContainerInset = newValue
            }
        }
        get {
            if let layoutManager = layoutManager as? IMTextLayoutManager {
                // Fix error rect for lineBackgroundInset.bottom
                return UIEdgeInsets(top: super.textContainerInset.top - layoutManager.lineBackgroundInset.bottom,
                                    left: super.textContainerInset.left,
                                    bottom: super.textContainerInset.bottom + layoutManager.lineBackgroundInset.bottom,
                                    right: super.textContainerInset.right)
            } else {
               return super.textContainerInset
            }
        }
    }
}


/// IMUITextSelectionMutableRect defines an annotated selection rect used by the system to
/// offer rich text interaction experience.  It also serves as an abstract class
/// provided to be subclassed when adopting UITextInput
private class IMUITextSelectionMutableRect: UITextSelectionRect {
     
    let offset: CGPoint

    let textSelectionRect: UITextSelectionRect
    
    init(_ textSelectionRect: UITextSelectionRect, offset: CGPoint) {
        self.textSelectionRect = textSelectionRect
        self.offset = offset
        super.init()
    }
    
    override var rect: CGRect {
        CGRect(x: textSelectionRect.rect.minX + offset.x,
               y: textSelectionRect.rect.minY + offset.y,
               width: textSelectionRect.rect.width,
               height: textSelectionRect.rect.height)
    }
    
    override var writingDirection: NSWritingDirection {
        textSelectionRect.writingDirection
    }

    /// Returns YES if the rect contains the start of the selection.
    override var containsStart: Bool {
        textSelectionRect.containsStart
    }

    /// Returns YES if the rect contains the end of the selection.
    override var containsEnd: Bool {
        textSelectionRect.containsEnd
    }

    /// Returns YES if the rect is for vertically oriented text.
    override var isVertical: Bool {
        textSelectionRect.isVertical
    }
}
