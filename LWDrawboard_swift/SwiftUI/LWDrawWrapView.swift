//
//  LWDrawWrapView.swift
//  LWDrawboard
//
//  Created by Swift Conversion
//  Copyright © 2024 MerryUnion. All rights reserved.
//

import SwiftUI
import Photos

// MARK: - LWDrawWrapViewDelegate

/// Protocol for handling photo assets
public protocol LWDrawWrapViewDelegate: AnyObject {
    func getAllAssets(ascending: Bool) -> [PHAsset]
    func requestImage(for asset: PHAsset, size: CGSize, completion: @escaping (UIImage?, [AnyHashable: Any]?) -> Void)
}

// MARK: - LWDrawWrapView

/// Main container view combining drawing canvas and toolbar
public struct LWDrawWrapView: View {

    // MARK: - Properties

    @StateObject private var viewModel: LWDrawViewModel
    @State private var showEditOptions = false

    public weak var delegate: LWDrawWrapViewDelegate?

    // MARK: - Body

    public var body: some View {
        VStack(spacing: 0) {
            // Drawing area
            ZStack(alignment: .topTrailing) {
                LWDrawView(viewModel: viewModel)

                // Edit button
                Button(action: {
                    viewModel.enableEdit.toggle()
                }) {
                    Image(systemName: viewModel.enableEdit ? "lock.open" : "lock")
                        .font(.system(size: 20))
                        .foregroundColor(.white)
                        .frame(width: 30, height: 30)
                        .background(Color.gray.opacity(0.5))
                        .cornerRadius(4)
                }
                .padding([.top, .trailing], 8)
            }

            // Color indicator
            Rectangle()
                .fill(Color(viewModel.freeInkColor))
                .frame(height: 10)

            // Drawing toolbar
            LWDrawBar(viewModel: viewModel)
        }
        .background(Color(UIColor.lightGray).opacity(0.4))
    }

    // MARK: - Public Methods

    /// Reset all drawings
    public func resetDrawing() {
        viewModel.resetDrawing()
    }

    /// Get snapshot of current drawing
    public func snapshot() -> UIImage? {
        return nil // Implementation would capture the canvas
    }

    // MARK: - Initialization

    public init(viewModel: LWDrawViewModel? = nil, delegate: LWDrawWrapViewDelegate? = nil) {
        _viewModel = StateObject(wrappedValue: viewModel ?? LWDrawViewModel())
        self.delegate = delegate
    }
}

// MARK: - Preview

struct LWDrawWrapView_Previews: PreviewProvider {
    static var previews: some View {
        LWDrawWrapView()
    }
}
