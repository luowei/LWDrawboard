# LWDrawboard Swift Version

This document describes how to use the Swift/SwiftUI version of LWDrawboard.

## Overview

LWDrawboard_swift is a modern Swift/SwiftUI implementation of the LWDrawboard library. It provides a comprehensive drawing and sketching solution with full support for SwiftUI, gesture-based controls, and modern Swift patterns.

## Requirements

- iOS 14.0+
- Swift 5.0+
- Xcode 12.0+

## Installation

### CocoaPods

Add the following line to your Podfile:

```ruby
pod 'LWDrawboard_swift'
```

Then run:
```bash
pod install
```

## Key Features

- **SwiftUI Native** - Built from the ground up for SwiftUI
- **Multiple Drawing Tools** - Pen, eraser, shapes, text, mosaic
- **Customizable Brushes** - Adjustable size, color, and opacity
- **Shape Drawing** - Rectangle, circle, polygon, arrow, line
- **Text Annotations** - Add text with custom fonts and colors
- **Image Effects** - Mosaic/blur effects for privacy
- **Crop & Transform** - Image cropping and transformation
- **Undo/Redo** - Full undo/redo support
- **Export** - Save drawings as images
- **Gesture Controls** - Intuitive touch and gesture support

## Quick Start

### Basic Drawing View

```swift
import SwiftUI
import LWDrawboard_swift

struct ContentView: View {
    @StateObject private var viewModel = LWDrawViewModel()

    var body: some View {
        VStack {
            // Drawing canvas
            LWDrawView(viewModel: viewModel)
                .frame(height: 400)
                .border(Color.gray)

            // Drawing toolbar
            LWDrawBar(viewModel: viewModel)
                .frame(height: 60)
        }
    }
}
```

### With Custom Background Image

```swift
struct DrawingWithImageView: View {
    @StateObject private var viewModel = LWDrawViewModel()
    let backgroundImage = UIImage(named: "background")

    var body: some View {
        LWDrawWrapView(
            viewModel: viewModel,
            backgroundImage: backgroundImage
        )
    }
}
```

### Simple Sketch View

```swift
struct SketchView: View {
    @State private var drawing = LWDrawTypes.Drawing()

    var body: some View {
        VStack {
            Canvas { context, size in
                for stroke in drawing.strokes {
                    var path = Path()
                    for (index, point) in stroke.points.enumerated() {
                        if index == 0 {
                            path.move(to: point)
                        } else {
                            path.addLine(to: point)
                        }
                    }
                    context.stroke(
                        path,
                        with: .color(stroke.color),
                        lineWidth: stroke.width
                    )
                }
            }
            .gesture(
                DragGesture(minimumDistance: 0)
                    .onChanged { value in
                        // Add drawing logic
                    }
            )
        }
    }
}
```

## Advanced Usage

### Drawing View Model

```swift
import LWDrawboard_swift

class DrawingManager: ObservableObject {
    @Published var viewModel = LWDrawViewModel()

    func setupDrawing() {
        // Configure drawing settings
        viewModel.currentTool = .pen
        viewModel.brushColor = .blue
        viewModel.brushWidth = 5.0
    }

    func selectPenTool() {
        viewModel.currentTool = .pen
        viewModel.brushColor = .black
        viewModel.brushWidth = 3.0
    }

    func selectEraserTool() {
        viewModel.currentTool = .eraser
        viewModel.brushWidth = 20.0
    }

    func selectShapeTool(_ shape: LWDrawTypes.ShapeType) {
        viewModel.currentTool = .shape(shape)
        viewModel.brushColor = .red
        viewModel.brushWidth = 2.0
    }

    func undo() {
        viewModel.undo()
    }

    func redo() {
        viewModel.redo()
    }

    func clear() {
        viewModel.clearAll()
    }

    func exportImage() -> UIImage? {
        return viewModel.generateImage()
    }
}
```

### Custom Drawing Tools

```swift
struct CustomDrawingToolbar: View {
    @ObservedObject var viewModel: LWDrawViewModel

    var body: some View {
        HStack(spacing: 20) {
            // Tool selector
            ToolButton(
                icon: "pencil",
                isSelected: viewModel.currentTool == .pen,
                action: { viewModel.currentTool = .pen }
            )

            ToolButton(
                icon: "eraser",
                isSelected: viewModel.currentTool == .eraser,
                action: { viewModel.currentTool = .eraser }
            )

            // Shape tools
            Menu {
                Button("Rectangle") {
                    viewModel.currentTool = .shape(.rectangle)
                }
                Button("Circle") {
                    viewModel.currentTool = .shape(.circle)
                }
                Button("Arrow") {
                    viewModel.currentTool = .shape(.arrow)
                }
            } label: {
                Image(systemName: "square.on.circle")
            }

            // Color picker
            ColorPicker("", selection: $viewModel.brushColor)
                .labelsHidden()
                .frame(width: 40)

            // Size slider
            Slider(value: $viewModel.brushWidth, in: 1...50)
                .frame(width: 100)

            Text("\(Int(viewModel.brushWidth))")
                .frame(width: 30)
        }
        .padding()
    }
}

struct ToolButton: View {
    let icon: String
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Image(systemName: icon)
                .foregroundColor(isSelected ? .blue : .gray)
                .padding(8)
                .background(isSelected ? Color.blue.opacity(0.2) : Color.clear)
                .cornerRadius(8)
        }
    }
}
```

### Shape Drawing

```swift
struct ShapeDrawingView: View {
    @StateObject private var viewModel = LWDrawViewModel()

    var body: some View {
        VStack {
            LWDrawView(viewModel: viewModel)

            HStack {
                Button("Rectangle") {
                    viewModel.currentTool = .shape(.rectangle)
                    viewModel.brushColor = .red
                }

                Button("Circle") {
                    viewModel.currentTool = .shape(.circle)
                    viewModel.brushColor = .blue
                }

                Button("Arrow") {
                    viewModel.currentTool = .shape(.arrow)
                    viewModel.brushColor = .green
                }

                Button("Polygon") {
                    viewModel.currentTool = .shape(.polygon)
                    viewModel.brushColor = .purple
                }
            }
            .buttonStyle(.bordered)
        }
    }
}
```

### Text Annotation

```swift
struct TextAnnotationView: View {
    @StateObject private var viewModel = LWDrawViewModel()
    @State private var showTextInput = false
    @State private var textInput = ""
    @State private var textPosition: CGPoint = .zero

    var body: some View {
        ZStack {
            LWDrawView(viewModel: viewModel)
                .onTapGesture { location in
                    textPosition = location
                    showTextInput = true
                }

            if showTextInput {
                TextInputOverlay(
                    text: $textInput,
                    position: textPosition,
                    onDone: { text in
                        viewModel.addText(
                            text,
                            at: textPosition,
                            font: .systemFont(ofSize: 20),
                            color: viewModel.brushColor
                        )
                        showTextInput = false
                        textInput = ""
                    },
                    onCancel: {
                        showTextInput = false
                        textInput = ""
                    }
                )
            }
        }
    }
}
```

### Mosaic/Blur Effect

```swift
struct MosaicEffectView: View {
    @StateObject private var viewModel = LWDrawViewModel()
    let image: UIImage

    var body: some View {
        VStack {
            LWDrawView(viewModel: viewModel)

            HStack {
                Button("Mosaic") {
                    viewModel.currentTool = .mosaic
                    viewModel.mosaicSize = 10
                }

                Button("Blur") {
                    viewModel.currentTool = .blur
                    viewModel.blurRadius = 15
                }

                Slider(
                    value: viewModel.currentTool == .mosaic
                        ? $viewModel.mosaicSize
                        : $viewModel.blurRadius,
                    in: 5...30
                )
            }
        }
        .onAppear {
            viewModel.setBackgroundImage(image)
        }
    }
}
```

## SwiftUI-Specific Features

### Drawing State Management

```swift
class DrawingState: ObservableObject {
    @Published var strokes: [LWDrawTypes.Stroke] = []
    @Published var currentStroke: LWDrawTypes.Stroke?
    @Published var canUndo: Bool = false
    @Published var canRedo: Bool = false

    private var undoStack: [[LWDrawTypes.Stroke]] = []
    private var redoStack: [[LWDrawTypes.Stroke]] = []

    func addStroke(_ stroke: LWDrawTypes.Stroke) {
        strokes.append(stroke)
        undoStack.append(strokes)
        redoStack.removeAll()
        updateUndoRedoState()
    }

    func undo() {
        guard undoStack.count > 1 else { return }
        redoStack.append(undoStack.removeLast())
        strokes = undoStack.last ?? []
        updateUndoRedoState()
    }

    func redo() {
        guard let state = redoStack.popLast() else { return }
        undoStack.append(state)
        strokes = state
        updateUndoRedoState()
    }

    private func updateUndoRedoState() {
        canUndo = undoStack.count > 1
        canRedo = !redoStack.isEmpty
    }
}
```

### Gesture-Based Drawing

```swift
struct GestureDrawingView: View {
    @StateObject private var viewModel = LWDrawViewModel()
    @State private var currentPath = Path()

    var body: some View {
        Canvas { context, size in
            // Draw existing strokes
            for stroke in viewModel.strokes {
                context.stroke(
                    stroke.path,
                    with: .color(stroke.color),
                    lineWidth: stroke.width
                )
            }

            // Draw current stroke
            context.stroke(
                currentPath,
                with: .color(viewModel.brushColor),
                lineWidth: viewModel.brushWidth
            )
        }
        .gesture(
            DragGesture(minimumDistance: 0)
                .onChanged { value in
                    if currentPath.isEmpty {
                        currentPath.move(to: value.location)
                    } else {
                        currentPath.addLine(to: value.location)
                    }
                }
                .onEnded { _ in
                    let stroke = LWDrawTypes.Stroke(
                        path: currentPath,
                        color: viewModel.brushColor,
                        width: viewModel.brushWidth
                    )
                    viewModel.addStroke(stroke)
                    currentPath = Path()
                }
        )
    }
}
```

### Export and Sharing

```swift
struct DrawingExportView: View {
    @StateObject private var viewModel = LWDrawViewModel()
    @State private var exportedImage: UIImage?
    @State private var showShareSheet = false

    var body: some View {
        VStack {
            LWDrawView(viewModel: viewModel)

            HStack {
                Button("Export") {
                    exportedImage = viewModel.generateImage()
                }

                Button("Share") {
                    exportedImage = viewModel.generateImage()
                    showShareSheet = true
                }

                Button("Save to Photos") {
                    if let image = viewModel.generateImage() {
                        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
                    }
                }
            }
        }
        .sheet(isPresented: $showShareSheet) {
            if let image = exportedImage {
                ShareSheet(items: [image])
            }
        }
    }
}

struct ShareSheet: UIViewControllerRepresentable {
    let items: [Any]

    func makeUIViewController(context: Context) -> UIActivityViewController {
        UIActivityViewController(activityItems: items, applicationActivities: nil)
    }

    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {}
}
```

## API Reference

### LWDrawViewModel

```swift
class LWDrawViewModel: ObservableObject {
    @Published var currentTool: LWDrawTypes.Tool
    @Published var brushColor: Color
    @Published var brushWidth: CGFloat
    @Published var strokes: [LWDrawTypes.Stroke]

    var canUndo: Bool { get }
    var canRedo: Bool { get }

    func undo()
    func redo()
    func clearAll()
    func generateImage() -> UIImage?
    func setBackgroundImage(_ image: UIImage)
    func addStroke(_ stroke: LWDrawTypes.Stroke)
    func addText(_ text: String, at position: CGPoint, font: UIFont, color: Color)
}
```

### LWDrawTypes

```swift
enum LWDrawTypes {
    enum Tool {
        case pen
        case eraser
        case shape(ShapeType)
        case text
        case mosaic
        case blur
    }

    enum ShapeType {
        case rectangle
        case circle
        case arrow
        case line
        case polygon
    }

    struct Stroke {
        let id: UUID
        let path: Path
        let color: Color
        let width: CGFloat
        let tool: Tool
    }

    struct Drawing {
        var strokes: [Stroke]
        var backgroundImage: UIImage?
    }
}
```

### LWDrawView

```swift
struct LWDrawView: View {
    @ObservedObject var viewModel: LWDrawViewModel

    init(viewModel: LWDrawViewModel)
}
```

### LWDrawBar

```swift
struct LWDrawBar: View {
    @ObservedObject var viewModel: LWDrawViewModel

    init(viewModel: LWDrawViewModel)
}
```

### LWDrawWrapView

```swift
struct LWDrawWrapView: View {
    @ObservedObject var viewModel: LWDrawViewModel
    var backgroundImage: UIImage?

    init(
        viewModel: LWDrawViewModel,
        backgroundImage: UIImage? = nil
    )
}
```

## Best Practices

### 1. Use View Model for State Management

```swift
// Good - Centralized state
@StateObject private var viewModel = LWDrawViewModel()

// Avoid - Scattered state
@State private var tool: Tool = .pen
@State private var color: Color = .black
@State private var width: CGFloat = 5
```

### 2. Optimize Performance for Large Drawings

```swift
// Use Canvas for better performance
Canvas { context, size in
    // Draw strokes efficiently
}

// Avoid excessive view updates
.drawingGroup() // Use Metal rendering
```

### 3. Handle Memory Properly

```swift
class DrawingManager {
    private let maxStrokes = 1000

    func addStroke(_ stroke: Stroke) {
        if strokes.count >= maxStrokes {
            strokes.removeFirst()
        }
        strokes.append(stroke)
    }
}
```

### 4. Provide Undo/Redo

```swift
// Always provide undo/redo
HStack {
    Button("Undo") {
        viewModel.undo()
    }
    .disabled(!viewModel.canUndo)

    Button("Redo") {
        viewModel.redo()
    }
    .disabled(!viewModel.canRedo)
}
```

## Migration from Objective-C Version

### Before (Objective-C)
```objective-c
LWDrawboardView *drawView = [[LWDrawboardView alloc] init];
drawView.brushColor = [UIColor blueColor];
drawView.brushWidth = 5.0;
[drawView clear];
```

### After (Swift)
```swift
let viewModel = LWDrawViewModel()
viewModel.brushColor = .blue
viewModel.brushWidth = 5.0

LWDrawView(viewModel: viewModel)
```

## Examples

Check the `LWDrawboard/SwiftUI/LWDrawboardExample.swift` file for complete working examples including:

- Basic drawing
- Shape tools
- Text annotations
- Mosaic effects
- Image cropping
- Export functionality

## Troubleshooting

**Q: Drawing lag or performance issues**
- Use `.drawingGroup()` modifier for Metal rendering
- Limit the number of strokes
- Consider simplifying complex paths

**Q: Export image quality issues**
- Use higher resolution for export
- Check image compression settings
- Ensure proper color space

**Q: Gestures not working**
- Verify gesture priority
- Check for conflicting gestures
- Ensure proper touch handling

**Q: Undo/Redo not working**
- Verify state is being tracked
- Check undo stack management
- Ensure proper state restoration

## Performance Tips

1. **Use Canvas API** - More efficient than Shape views
2. **Limit Undo History** - Keep reasonable undo stack size
3. **Optimize Paths** - Simplify complex drawing paths
4. **Lazy Loading** - Load strokes on demand for large drawings
5. **Metal Rendering** - Use `.drawingGroup()` for complex drawings

## License

LWDrawboard_swift is available under the MIT license. See the LICENSE file for more information.

## Author

**luowei**
- Email: luowei@wodedata.com
- GitHub: [@luowei](https://github.com/luowei)
