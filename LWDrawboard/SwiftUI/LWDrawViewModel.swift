//
//  LWDrawViewModel.swift
//  LWDrawboard
//
//  Created by Swift Conversion
//  Copyright © 2024 MerryUnion. All rights reserved.
//

import SwiftUI
import Combine
import Photos

// MARK: - LWDrawViewModel

/// View model managing the drawing state and operations
public class LWDrawViewModel: ObservableObject {

    // MARK: - Published Properties

    /// Array of all drawing elements
    @Published public var curves: [LWDrafter] = []

    /// Current drawing type/tool
    @Published public var drawType: DrawType = .hand

    /// Current draw status/mode
    @Published public var drawStatus: DrawStatus = .drawing

    /// Free ink color
    @Published public var freeInkColor: UIColor = .black

    /// Free ink line width
    @Published public var freeInkLinewidth: CGFloat = 3.0

    /// Current emoji for tile
    @Published public var tileEmojiText: String = "👀"

    /// Current asset for image tile
    @Published public var tileAsset: PHAsset?

    /// Font name for text
    @Published public var fontName: String = "HelveticaNeue"

    /// Enable editing mode
    @Published public var enableEdit: Bool = false

    /// Shadow enabled
    @Published public var openShadow: Bool = false

    /// Background image
    @Published public var backgroundImage: UIImage?

    /// Background color
    @Published public var backgroundFillColor: UIColor?

    /// Chinese pen width
    @Published public var chinesePenWidth: CGFloat = 13

    // MARK: - Methods

    /// Reset drawing (clear all curves)
    public func resetDrawing() {
        curves.removeAll()
        exitEditingOrTexting()
    }

    /// Exit editing or texting mode
    public func exitEditingOrTexting() {
        drawStatus = .drawing
        for curve in curves {
            curve.isEditing = false
            curve.isTexting = false
        }
    }

    /// Undo last drawing action
    public func undo() {
        guard !curves.isEmpty else { return }
        curves.removeLast()
    }

    /// Add a new drafter/curve
    public func addCurve(_ drafter: LWDrafter) {
        curves.append(drafter)
    }

    /// Get currently editing drafter
    public func getEditingDrafter() -> LWDrafter? {
        return curves.first(where: { $0.isEditing })
    }

    /// Get currently texting drafter
    public func getTextingDrafter() -> LWDrafter? {
        return curves.first(where: { $0.isTexting })
    }

    /// Get editing or texting drafter
    public func getEditingOrTextingDrafter() -> LWDrafter? {
        return curves.first(where: { $0.isEditing || $0.isTexting })
    }

    /// Check if point is within any drafter's bounds
    public func drafterContaining(point: CGPoint) -> LWDrafter? {
        return curves.reversed().first { drafter in
            guard drafter.rect.size != .zero else { return false }
            return drafter.rect.insetBy(dx: -25, dy: -25).contains(point)
        }
    }

    // MARK: - Initialization

    public init() {
        // Default initialization
    }
}
