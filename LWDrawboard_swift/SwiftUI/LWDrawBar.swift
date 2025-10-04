//
//  LWDrawBar.swift
//  LWDrawboard
//
//  Created by Swift Conversion
//  Copyright © 2024 MerryUnion. All rights reserved.
//

import SwiftUI

// MARK: - LWDrawBar

/// Drawing toolbar with tools and options
public struct LWDrawBar: View {

    // MARK: - Properties

    @ObservedObject var viewModel: LWDrawViewModel

    @State private var showColorPicker = false
    @State private var showEmojiPicker = false
    @State private var showFontPicker = false

    // MARK: - Body

    public var body: some View {
        VStack(spacing: 0) {
            Divider()

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 0) {
                    // Section 1: Drawing tools
                    toolButton(icon: "pencil", isSelected: viewModel.drawType == .hand) {
                        viewModel.drawType = .hand
                        viewModel.freeInkColor = .black
                    }

                    toolButton(icon: "stamp", isSelected: viewModel.drawType == .emojiTile) {
                        viewModel.drawType = .emojiTile
                        showEmojiPicker = true
                    }

                    toolButton(icon: "paintbrush.pointed", isSelected: viewModel.drawType == .chinesePen) {
                        viewModel.drawType = .chinesePen
                    }

                    toolButton(icon: "shadow", isSelected: viewModel.openShadow) {
                        viewModel.openShadow.toggle()
                    }

                    toolButton(icon: "paintpalette", isSelected: false) {
                        showColorPicker = true
                    }

                    toolButton(icon: "eraser", isSelected: viewModel.drawType == .erase) {
                        viewModel.drawType = .erase
                    }

                    Divider()
                        .frame(height: 30)

                    // Section 2: Undo and slider
                    toolButton(icon: "arrow.uturn.backward", isSelected: false) {
                        viewModel.undo()
                    }

                    Slider(value: $viewModel.freeInkLinewidth, in: 1...60)
                        .frame(width: 200)
                        .padding(.horizontal, 8)

                    Divider()
                        .frame(height: 30)

                    // Section 3: Brush sizes
                    toolButton(icon: "circle.fill", size: 8, isSelected: viewModel.freeInkLinewidth == 3) {
                        viewModel.freeInkLinewidth = 3.0
                    }

                    toolButton(icon: "circle.fill", size: 12, isSelected: viewModel.freeInkLinewidth == 6) {
                        viewModel.freeInkLinewidth = 6.0
                    }

                    toolButton(icon: "circle.fill", size: 16, isSelected: viewModel.freeInkLinewidth == 12) {
                        viewModel.freeInkLinewidth = 12.0
                    }

                    Divider()
                        .frame(height: 30)

                    // Section 4: Shapes
                    toolButton(icon: "line.diagonal", isSelected: viewModel.drawType == .line) {
                        viewModel.drawType = .line
                    }

                    toolButton(icon: "line.diagonal.arrow", isSelected: viewModel.drawType == .lineArrow) {
                        viewModel.drawType = .lineArrow
                    }

                    toolButton(icon: "rectangle", isSelected: viewModel.drawType == .rectangle) {
                        viewModel.drawType = .rectangle
                    }

                    toolButton(icon: "rectangle.dashed", isSelected: viewModel.drawType == .rectangleDash) {
                        viewModel.drawType = .rectangleDash
                    }

                    toolButton(icon: "rectangle.fill", isSelected: viewModel.drawType == .rectangleFill) {
                        viewModel.drawType = .rectangleFill
                    }

                    toolButton(icon: "circle", isSelected: viewModel.drawType == .oval) {
                        viewModel.drawType = .oval
                    }

                    toolButton(icon: "circle.dashed", isSelected: viewModel.drawType == .ovalDash) {
                        viewModel.drawType = .ovalDash
                    }

                    toolButton(icon: "circle.fill", isSelected: viewModel.drawType == .ovalFill) {
                        viewModel.drawType = .ovalFill
                    }

                    toolButton(icon: "scribble.variable", isSelected: viewModel.drawType == .curveDash) {
                        viewModel.drawType = .curveDash
                    }

                    toolButton(icon: "textformat", isSelected: viewModel.drawType == .text) {
                        viewModel.drawType = .text
                        showFontPicker = true
                    }
                }
                .frame(height: 40)
            }
        }
        .background(Color(UIColor.systemBackground))
        .sheet(isPresented: $showColorPicker) {
            ColorPickerView(viewModel: viewModel, isPresented: $showColorPicker)
        }
        .sheet(isPresented: $showEmojiPicker) {
            EmojiPickerView(viewModel: viewModel, isPresented: $showEmojiPicker)
        }
        .sheet(isPresented: $showFontPicker) {
            FontPickerView(viewModel: viewModel, isPresented: $showFontPicker)
        }
    }

    // MARK: - Helper Views

    private func toolButton(
        icon: String,
        size: CGFloat? = nil,
        isSelected: Bool,
        action: @escaping () -> Void
    ) -> some View {
        Button(action: action) {
            Image(systemName: icon)
                .font(.system(size: size ?? 20))
                .frame(width: 40, height: 40)
                .background(isSelected ? Color.gray.opacity(0.3) : Color.clear)
        }
    }

    // MARK: - Initialization

    public init(viewModel: LWDrawViewModel) {
        self.viewModel = viewModel
    }
}

// MARK: - ColorPickerView

struct ColorPickerView: View {
    @ObservedObject var viewModel: LWDrawViewModel
    @Binding var isPresented: Bool

    let columns = Array(repeating: GridItem(.flexible(), spacing: 0), count: 6)

    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 0) {
                    ForEach(DrawConstants.colorItems, id: \.self) { colorHex in
                        Button(action: {
                            viewModel.freeInkColor = UIColor(hexString: colorHex)
                            isPresented = false
                        }) {
                            Rectangle()
                                .fill(Color(hexString: colorHex))
                                .frame(height: 60)
                                .border(Color.gray.opacity(0.3), width: 0.5)
                        }
                    }
                }
            }
            .navigationTitle("Select Color")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        isPresented = false
                    }
                }
            }
        }
    }
}

// MARK: - EmojiPickerView

struct EmojiPickerView: View {
    @ObservedObject var viewModel: LWDrawViewModel
    @Binding var isPresented: Bool

    let columns = Array(repeating: GridItem(.flexible(), spacing: 8), count: 6)

    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 8) {
                    ForEach(DrawConstants.emojiItems, id: \.self) { emoji in
                        Button(action: {
                            viewModel.tileEmojiText = emoji
                            viewModel.drawType = .emojiTile
                            isPresented = false
                        }) {
                            Text(emoji)
                                .font(.system(size: 30))
                                .frame(width: 45, height: 45)
                                .background(Color.gray.opacity(0.1))
                                .cornerRadius(8)
                        }
                    }
                }
                .padding()
            }
            .navigationTitle("Select Emoji")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        isPresented = false
                    }
                }
            }
        }
    }
}

// MARK: - FontPickerView

struct FontPickerView: View {
    @ObservedObject var viewModel: LWDrawViewModel
    @Binding var isPresented: Bool

    var body: some View {
        NavigationView {
            List(DrawConstants.fontNames, id: \.self) { fontName in
                Button(action: {
                    viewModel.fontName = fontName
                    isPresented = false
                }) {
                    Text("Sample Text - 好嗎Abc")
                        .font(Font.custom(fontName, size: 18))
                        .foregroundColor(.primary)
                }
            }
            .navigationTitle("Select Font")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        isPresented = false
                    }
                }
            }
        }
    }
}
