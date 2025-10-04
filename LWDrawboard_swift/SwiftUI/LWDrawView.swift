//
//  LWDrawView.swift
//  LWDrawboard
//
//  Created by Swift Conversion
//  Copyright © 2024 MerryUnion. All rights reserved.
//

import SwiftUI

// MARK: - LWDrawView

/// Main drawing canvas view
public struct LWDrawView: View {

    // MARK: - Properties

    @ObservedObject var viewModel: LWDrawViewModel

    @State private var currentPath: [CGPoint] = []
    @State private var currentDrafter: LWDrafter?

    // MARK: - Body

    public var body: some View {
        ZStack {
            // Background
            if let bgColor = viewModel.backgroundFillColor {
                Color(bgColor)
            }

            if let bgImage = viewModel.backgroundImage {
                Image(uiImage: bgImage)
                    .resizable()
                    .scaledToFill()
            }

            // Drawing canvas
            Canvas { context, size in
                drawContent(context: context, size: size)
            }
            .gesture(
                DragGesture(minimumDistance: 0)
                    .onChanged { value in
                        handleDragChanged(value)
                    }
                    .onEnded { value in
                        handleDragEnded(value)
                    }
            )
        }
        .background(Color.clear)
    }

    // MARK: - Drawing Methods

    private func drawContent(context: GraphicsContext, size: CGSize) {
        // Draw all existing curves
        for drafter in viewModel.curves {
            drawDrafter(drafter, context: &context, size: size)
        }

        // Draw current path being drawn
        if !currentPath.isEmpty, let drafter = currentDrafter {
            drawDrafter(drafter, context: &context, size: size)
        }
    }

    private func drawDrafter(_ drafter: LWDrafter, context: inout GraphicsContext, size: CGSize) {
        guard drafter.points.count >= 2 else { return }

        switch drafter.drawType {
        case .hand, .curveDash, .erase:
            drawCurve(drafter, context: &context)
        case .chinesePen:
            drawChinesePen(drafter, context: &context)
        case .line, .lineDash:
            drawLine(drafter, context: &context)
        case .lineArrow:
            drawArrow(drafter, context: &context)
        case .rectangle, .rectangleDash, .rectangleFill:
            drawRectangle(drafter, context: &context)
        case .oval, .ovalDash, .ovalFill:
            drawOval(drafter, context: &context)
        case .text:
            if !drafter.isTexting {
                drawText(drafter, context: &context)
            }
        case .emojiTile, .imageTile:
            drawTile(drafter, context: &context)
        }
    }

    private func drawCurve(_ drafter: LWDrafter, context: inout GraphicsContext) {
        var path = Path()
        let points = drafter.points

        path.move(to: points[0])
        for i in 1..<points.count {
            let midPoint = points[i-1].midpoint(to: points[i])
            path.addQuadCurve(to: midPoint, control: points[i-1])
        }
        path.addLine(to: points.last!)

        if drafter.drawType == .curveDash {
            context.stroke(
                path,
                with: .color(Color(drafter.color)),
                style: StrokeStyle(
                    lineWidth: drafter.lineWidth,
                    lineCap: .round,
                    lineJoin: .round,
                    dash: [drafter.lineWidth * 6, drafter.lineWidth * 2]
                )
            )
        } else {
            context.stroke(
                path,
                with: .color(Color(drafter.color)),
                style: StrokeStyle(
                    lineWidth: drafter.lineWidth,
                    lineCap: .round,
                    lineJoin: .round
                )
            )
        }
    }

    private func drawChinesePen(_ drafter: LWDrafter, context: inout GraphicsContext) {
        // Simplified Chinese pen rendering
        let points = drafter.points
        guard points.count >= 2 else { return }

        var path = Path()
        path.move(to: points[0])

        for i in 1..<points.count {
            path.addLine(to: points[i])
        }

        context.stroke(
            path,
            with: .color(Color(drafter.color).opacity(0.5)),
            style: StrokeStyle(
                lineWidth: drafter.lineWidth,
                lineCap: .round,
                lineJoin: .round
            )
        )
    }

    private func drawLine(_ drafter: LWDrafter, context: inout GraphicsContext) {
        guard let first = drafter.points.first, let last = drafter.points.last else { return }

        var path = Path()
        path.move(to: first)
        path.addLine(to: last)

        if drafter.drawType == .lineDash {
            context.stroke(
                path,
                with: .color(Color(drafter.color)),
                style: StrokeStyle(
                    lineWidth: drafter.lineWidth,
                    lineCap: .round,
                    dash: [drafter.lineWidth * 6, drafter.lineWidth * 2]
                )
            )
        } else {
            context.stroke(
                path,
                with: .color(Color(drafter.color)),
                style: StrokeStyle(lineWidth: drafter.lineWidth, lineCap: .round)
            )
        }
    }

    private func drawArrow(_ drafter: LWDrafter, context: inout GraphicsContext) {
        guard let first = drafter.points.first, let last = drafter.points.last else { return }

        // Draw line
        var linePath = Path()
        linePath.move(to: first)
        linePath.addLine(to: last)

        // Draw arrow head
        let angle = atan2(last.y - first.y, last.x - first.x)
        let arrowLength = drafter.lineWidth * 3

        var arrowPath = Path()
        arrowPath.move(to: last)
        arrowPath.addLine(to: CGPoint(
            x: last.x - arrowLength * cos(angle - .pi / 6),
            y: last.y - arrowLength * sin(angle - .pi / 6)
        ))
        arrowPath.move(to: last)
        arrowPath.addLine(to: CGPoint(
            x: last.x - arrowLength * cos(angle + .pi / 6),
            y: last.y - arrowLength * sin(angle + .pi / 6)
        ))

        context.stroke(
            linePath,
            with: .color(Color(drafter.color)),
            style: StrokeStyle(lineWidth: drafter.lineWidth, lineCap: .round)
        )

        context.stroke(
            arrowPath,
            with: .color(Color(drafter.color)),
            style: StrokeStyle(lineWidth: drafter.lineWidth, lineCap: .round)
        )
    }

    private func drawRectangle(_ drafter: LWDrafter, context: inout GraphicsContext) {
        guard let first = drafter.points.first, let last = drafter.points.last else { return }

        let rect = CGRect(
            x: min(first.x, last.x),
            y: min(first.y, last.y),
            width: abs(last.x - first.x),
            height: abs(last.y - first.y)
        )

        let path = Path(roundedRect: rect, cornerRadius: 0)

        if drafter.drawType == .rectangleFill {
            context.fill(path, with: .color(Color(drafter.color)))
        }

        if drafter.drawType == .rectangleDash {
            context.stroke(
                path,
                with: .color(Color(drafter.color)),
                style: StrokeStyle(
                    lineWidth: drafter.lineWidth,
                    dash: [drafter.lineWidth * 6, drafter.lineWidth * 2]
                )
            )
        } else {
            context.stroke(
                path,
                with: .color(Color(drafter.color)),
                style: StrokeStyle(lineWidth: drafter.lineWidth)
            )
        }
    }

    private func drawOval(_ drafter: LWDrafter, context: inout GraphicsContext) {
        guard let first = drafter.points.first, let last = drafter.points.last else { return }

        let rect = CGRect(
            x: min(first.x, last.x),
            y: min(first.y, last.y),
            width: abs(last.x - first.x),
            height: abs(last.y - first.y)
        )

        let path = Path(ellipseIn: rect)

        if drafter.drawType == .ovalFill {
            context.fill(path, with: .color(Color(drafter.color)))
        }

        if drafter.drawType == .ovalDash {
            context.stroke(
                path,
                with: .color(Color(drafter.color)),
                style: StrokeStyle(
                    lineWidth: drafter.lineWidth,
                    dash: [drafter.lineWidth * 6, drafter.lineWidth * 2]
                )
            )
        } else {
            context.stroke(
                path,
                with: .color(Color(drafter.color)),
                style: StrokeStyle(lineWidth: drafter.lineWidth)
            )
        }
    }

    private func drawText(_ drafter: LWDrafter, context: inout GraphicsContext) {
        guard !drafter.text.isEmpty else { return }

        let font = UIFont(name: drafter.fontName, size: drafter.lineWidth * 5) ?? UIFont.systemFont(ofSize: drafter.lineWidth * 5)
        let attributes: [NSAttributedString.Key: Any] = [
            .font: font,
            .foregroundColor: drafter.color
        ]

        let attributedString = AttributedString(NSAttributedString(string: drafter.text, attributes: attributes))

        context.draw(
            Text(attributedString),
            in: drafter.rect
        )
    }

    private func drawTile(_ drafter: LWDrafter, context: inout GraphicsContext) {
        for point in drafter.points {
            if drafter.drawType == .emojiTile {
                if let image = drafter.tileEmojiText.toImage(size: drafter.brushSize) {
                    let rect = CGRect(
                        x: point.x - drafter.brushSize.width / 2,
                        y: point.y - drafter.brushSize.height / 2,
                        width: drafter.brushSize.width,
                        height: drafter.brushSize.height
                    )
                    context.draw(Image(uiImage: image), in: rect)
                }
            }
        }
    }

    // MARK: - Gesture Handlers

    private func handleDragChanged(_ value: DragGesture.Value) {
        let location = value.location

        if currentDrafter == nil {
            // Start new drafter
            let drafter = LWDrafter(
                drawType: viewModel.drawType,
                color: viewModel.freeInkColor,
                lineWidth: viewModel.freeInkLinewidth
            )
            drafter.tileEmojiText = viewModel.tileEmojiText
            drafter.tileAsset = viewModel.tileAsset
            drafter.fontName = viewModel.fontName
            drafter.openShadow = viewModel.openShadow
            currentDrafter = drafter
        }

        currentDrafter?.points.append(location)
        currentPath.append(location)
    }

    private func handleDragEnded(_ value: DragGesture.Value) {
        if let drafter = currentDrafter {
            viewModel.addCurve(drafter)
        }
        currentDrafter = nil
        currentPath.removeAll()
    }

    // MARK: - Initialization

    public init(viewModel: LWDrawViewModel) {
        self.viewModel = viewModel
    }
}
