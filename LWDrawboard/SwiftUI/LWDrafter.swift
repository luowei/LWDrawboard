//
//  LWDrafter.swift
//  LWDrawboard
//
//  Created by Swift Conversion
//  Copyright © 2024 MerryUnion. All rights reserved.
//

import Foundation
import UIKit
import Photos

// MARK: - LWDrafter Model

/// Model representing a drawing stroke/element
public class LWDrafter: ObservableObject {

    // MARK: - Properties

    /// Array of points in the stroke
    @Published public var points: [CGPoint] = []

    /// Color of the stroke
    @Published public var color: UIColor = .black

    /// Line width of the stroke
    @Published public var lineWidth: CGFloat = 3.0

    /// Type of drawing tool used
    @Published public var drawType: DrawType = .hand

    /// Emoji text for tile drawing
    @Published public var tileEmojiText: String = "👀"

    /// Photo asset for image tile drawing
    @Published public var tileAsset: PHAsset?

    /// Text content (for text drawing)
    @Published public var text: String = ""

    /// Font name (for text drawing)
    @Published public var fontName: String = "HelveticaNeue"

    /// Bounding rectangle
    @Published public var rect: CGRect = .zero

    /// Is currently in text input mode
    @Published public var isTexting: Bool = false

    /// Is currently in editing mode
    @Published public var isEditing: Bool = false

    /// Is a new/unsaved element
    @Published public var isNew: Bool = true

    /// Path bounds
    @Published public var pathBounds: CGRect = .zero

    /// Rotation angle in degrees
    @Published public var rotateAngle: CGFloat = 0

    /// Scale rectangle
    @Published public var scaleRect: CGRect = .zero

    /// Move point
    @Published public var movePoint: CGPoint = .zero

    /// Rotation angle dictionary for emoji/image tiles
    public var rotateAngleDict: [String: CGFloat] = [:]

    /// Shadow enabled
    @Published public var openShadow: Bool = false

    // MARK: - Computed Properties

    /// Get shadow configuration
    public var shadow: NSShadow {
        let shadow = NSShadow()
        let shadowColor = color.isLight ?
            UIColor.black.withAlphaComponent(0.6) :
            UIColor.white.withAlphaComponent(0.6)
        shadow.shadowColor = shadowColor
        shadow.shadowOffset = CGSize(width: 1.1, height: 1.1)
        shadow.shadowBlurRadius = 2.0
        return shadow
    }

    /// Brush size for tiles
    public var brushSize: CGSize {
        return CGSize(width: lineWidth * 4, height: lineWidth * 4)
    }

    // MARK: - Initialization

    public init() {
        // Default initialization
    }

    public init(
        drawType: DrawType,
        color: UIColor = .black,
        lineWidth: CGFloat = 3.0
    ) {
        self.drawType = drawType
        self.color = color
        self.lineWidth = lineWidth
    }
}

// MARK: - Identifiable Conformance

extension LWDrafter: Identifiable {
    public var id: UUID { UUID() }
}
