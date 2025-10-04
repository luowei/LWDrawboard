//
//  LWDrawExtensions.swift
//  LWDrawboard
//
//  Created by Swift Conversion
//  Copyright © 2024 MerryUnion. All rights reserved.
//

import SwiftUI
import UIKit

// MARK: - UIColor Extensions

extension UIColor {

    /// Check if color is light
    var isLight: Bool {
        guard let components = cgColor.components else { return true }
        let brightness = ((components[0] * 299) + (components[1] * 587) + (components[2] * 114)) / 1000
        return brightness > 0.5
    }

    /// Get reversed color
    var reversed: UIColor {
        guard let components = cgColor.components else { return self }
        return UIColor(
            red: 1.0 - components[0],
            green: 1.0 - components[1],
            blue: 1.0 - components[2],
            alpha: components[3]
        )
    }

    /// Initialize from hex string
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(
            red: CGFloat(r) / 255,
            green: CGFloat(g) / 255,
            blue: CGFloat(b) / 255,
            alpha: CGFloat(a) / 255
        )
    }
}

// MARK: - Color Extensions (SwiftUI)

extension Color {

    /// Initialize from hex string
    init(hexString: String) {
        let uiColor = UIColor(hexString: hexString)
        self.init(uiColor)
    }

    /// Check if color is light
    var isLight: Bool {
        UIColor(self).isLight
    }
}

// MARK: - String Extensions

extension String {

    /// Convert string to image with specified size
    func toImage(size: CGSize) -> UIImage? {
        let nsString = self as NSString
        let font = UIFont.systemFont(ofSize: size.height * 0.8)
        let attributes: [NSAttributedString.Key: Any] = [
            .font: font,
            .foregroundColor: UIColor.black
        ]

        let stringSize = nsString.size(withAttributes: attributes)
        let renderer = UIGraphicsImageRenderer(size: size)

        return renderer.image { context in
            let x = (size.width - stringSize.width) / 2
            let y = (size.height - stringSize.height) / 2
            nsString.draw(at: CGPoint(x: x, y: y), withAttributes: attributes)
        }
    }
}

// MARK: - UIBezierPath Extensions

extension UIBezierPath {

    /// Rotate path by degree
    func rotate(degree: CGFloat) {
        let radians = degree * .pi / 180
        let center = CGPoint(x: bounds.midX, y: bounds.midY)
        var transform = CGAffineTransform.identity
        transform = transform.translatedBy(x: center.x, y: center.y)
        transform = transform.rotated(by: radians)
        transform = transform.translatedBy(x: -center.x, y: -center.y)
        apply(transform)
    }

    /// Scale path
    func scale(widthScale: CGFloat, heightScale: CGFloat) {
        let center = CGPoint(x: bounds.midX, y: bounds.midY)
        var transform = CGAffineTransform.identity
        transform = transform.translatedBy(x: center.x, y: center.y)
        transform = transform.scaledBy(x: widthScale, y: heightScale)
        transform = transform.translatedBy(x: -center.x, y: -center.y)
        apply(transform)
    }

    /// Move path center to point
    func moveCenter(to point: CGPoint) {
        let center = CGPoint(x: bounds.midX, y: bounds.midY)
        let dx = point.x - center.x
        let dy = point.y - center.y
        apply(CGAffineTransform(translationX: dx, y: dy))
    }
}

// MARK: - UIImage Extensions

extension UIImage {

    /// Create image from color
    static func from(color: UIColor, size: CGSize) -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: size)
        return renderer.image { context in
            color.setFill()
            context.fill(CGRect(origin: .zero, size: size))
        }
    }

    /// Create circle image from color
    static func circle(color: UIColor, size: CGSize) -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: size)
        return renderer.image { context in
            color.setFill()
            let rect = CGRect(origin: .zero, size: size)
            context.cgContext.fillEllipse(in: rect)
        }
    }

    /// Create image from attributed string
    static func from(string: String, attributes: [NSAttributedString.Key: Any], size: CGSize) -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: size)
        return renderer.image { context in
            let nsString = string as NSString
            nsString.draw(in: CGRect(origin: .zero, size: size), withAttributes: attributes)
        }
    }

    /// Combine two images
    static func combine(_ image1: UIImage, with image2: UIImage, in rect: CGRect, totalSize: CGSize) -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: totalSize)
        return renderer.image { context in
            image1.draw(in: CGRect(origin: .zero, size: totalSize))
            image2.draw(in: rect)
        }
    }
}

// MARK: - View Extensions

extension View {

    /// Capture view as UIImage
    func snapshot() -> UIImage? {
        let controller = UIHostingController(rootView: self)
        let view = controller.view

        let targetSize = controller.view.intrinsicContentSize
        view?.bounds = CGRect(origin: .zero, size: targetSize)
        view?.backgroundColor = .clear

        let renderer = UIGraphicsImageRenderer(size: targetSize)
        return renderer.image { _ in
            view?.drawHierarchy(in: controller.view.bounds, afterScreenUpdates: true)
        }
    }
}

// MARK: - CGPoint Extensions

extension CGPoint {

    /// Calculate distance to another point
    func distance(to point: CGPoint) -> CGFloat {
        let dx = x - point.x
        let dy = y - point.y
        return sqrt(dx * dx + dy * dy)
    }

    /// Calculate midpoint to another point
    func midpoint(to point: CGPoint) -> CGPoint {
        return CGPoint(x: (x + point.x) / 2, y: (y + point.y) / 2)
    }
}

// MARK: - Geometry Utilities

struct GeometryUtilities {

    /// Fit page size to screen
    static func fitPageToScreen(pageSize: CGSize, screenSize: CGSize) -> CGSize {
        let hScale = screenSize.width / pageSize.width
        let vScale = screenSize.height / pageSize.height
        let scale = min(hScale, vScale)
        let adjustedHScale = floor(pageSize.width * scale) / pageSize.width
        let adjustedVScale = floor(pageSize.height * scale) / pageSize.height
        return CGSize(width: adjustedHScale, height: adjustedVScale)
    }

    /// Adjust path to fit rect
    static func adjustPath(_ path: UIBezierPath, to rect: CGRect) {
        let bounds = path.bounds
        if bounds.width == 0 || bounds.height == 0 { return }

        let scaleX = rect.width / bounds.width
        let scaleY = rect.height / bounds.height

        var transform = CGAffineTransform(translationX: -bounds.minX, y: -bounds.minY)
        transform = transform.scaledBy(x: scaleX, y: scaleY)
        transform = transform.translatedBy(x: rect.minX, y: rect.minY)
        path.apply(transform)
    }
}
