//
//  LWDrawboardExample.swift
//  LWDrawboard
//
//  Created by Swift Conversion
//  Copyright © 2024 MerryUnion. All rights reserved.
//

import SwiftUI

// MARK: - Example Usage

/// Example view demonstrating how to use LWDrawboard in a SwiftUI app
struct LWDrawboardExample: View {

    @StateObject private var viewModel = LWDrawViewModel()

    var body: some View {
        NavigationView {
            VStack {
                LWDrawWrapView(viewModel: viewModel)
            }
            .navigationTitle("Drawing Board")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Clear") {
                        viewModel.resetDrawing()
                    }
                }

                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        // Save drawing logic
                        saveDrawing()
                    }
                }
            }
        }
    }

    private func saveDrawing() {
        // Implementation to save the drawing
        // This could export to UIImage, PDF, or save to PhotoLibrary
        print("Saving drawing...")
    }
}

// MARK: - Preview

struct LWDrawboardExample_Previews: PreviewProvider {
    static var previews: some View {
        LWDrawboardExample()
    }
}

// MARK: - Integration Example

/*

 ## Basic Integration

 ### 1. Simple Usage

 ```swift
 import SwiftUI

 struct ContentView: View {
     @StateObject private var viewModel = LWDrawViewModel()

     var body: some View {
         LWDrawWrapView(viewModel: viewModel)
     }
 }
 ```

 ### 2. Customized Setup

 ```swift
 struct ContentView: View {
     @StateObject private var viewModel: LWDrawViewModel

     init() {
         let vm = LWDrawViewModel()
         vm.freeInkColor = .blue
         vm.freeInkLinewidth = 5.0
         vm.backgroundFillColor = .white
         _viewModel = StateObject(wrappedValue: vm)
     }

     var body: some View {
         LWDrawWrapView(viewModel: viewModel)
     }
 }
 ```

 ### 3. With Custom Controls

 ```swift
 struct ContentView: View {
     @StateObject private var viewModel = LWDrawViewModel()

     var body: some View {
         VStack {
             // Custom controls
             HStack {
                 Button("Undo") {
                     viewModel.undo()
                 }

                 Button("Clear") {
                     viewModel.resetDrawing()
                 }

                 Picker("Tool", selection: $viewModel.drawType) {
                     Text("Pen").tag(DrawType.hand)
                     Text("Eraser").tag(DrawType.erase)
                     Text("Line").tag(DrawType.line)
                 }
                 .pickerStyle(.segmented)
             }
             .padding()

             // Drawing canvas
             LWDrawWrapView(viewModel: viewModel)
         }
     }
 }
 ```

 ### 4. Programmatic Drawing

 ```swift
 // Create a drafter programmatically
 let drafter = LWDrafter(drawType: .rectangle, color: .red, lineWidth: 3.0)
 drafter.points = [
     CGPoint(x: 50, y: 50),
     CGPoint(x: 200, y: 200)
 ]
 viewModel.addCurve(drafter)
 ```

 ### 5. Accessing Drawing Data

 ```swift
 // Get all curves
 let allCurves = viewModel.curves

 // Iterate through drawings
 for curve in viewModel.curves {
     print("Type: \(curve.drawType)")
     print("Color: \(curve.color)")
     print("Points: \(curve.points.count)")
 }
 ```

 ## Features

 - ✅ Multiple drawing tools (pen, eraser, shapes, text)
 - ✅ Color picker with predefined colors
 - ✅ Adjustable line width
 - ✅ Undo functionality
 - ✅ Text with custom fonts
 - ✅ Emoji stamps
 - ✅ Shape tools (rectangle, oval, line, arrow)
 - ✅ Dashed line variants
 - ✅ Fill options for shapes
 - ✅ Chinese calligraphy pen style
 - ✅ Shadow effects
 - ✅ Background image/color support
 - ✅ Edit mode for moving/rotating elements

 ## Requirements

 - iOS 15.0+
 - SwiftUI
 - Xcode 13.0+

 ## Migration from Objective-C

 The Swift/SwiftUI version maintains API compatibility where possible:

 | Objective-C | Swift/SwiftUI |
 |-------------|---------------|
 | LWDrawView | LWDrawView (SwiftUI) |
 | LWDrawBar | LWDrawBar (SwiftUI) |
 | LWDrawWrapView | LWDrawWrapView (SwiftUI) |
 | LWDrafter | LWDrafter (Swift class) |
 | DrawType enum | DrawType enum |

 */
