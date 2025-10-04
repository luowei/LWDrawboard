// swift-tools-version:5.5
//
//  Package.swift
//  LWDrawboard SwiftUI
//
//  Created by Swift Conversion
//  Copyright © 2024 MerryUnion. All rights reserved.
//

import PackageDescription

let package = Package(
    name: "LWDrawboardSwiftUI",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        .library(
            name: "LWDrawboardSwiftUI",
            targets: ["LWDrawboardSwiftUI"]
        )
    ],
    dependencies: [
        // Add any external dependencies here if needed
    ],
    targets: [
        .target(
            name: "LWDrawboardSwiftUI",
            dependencies: [],
            path: ".",
            exclude: ["Package.swift", "LWDrawboardExample.swift"],
            sources: [
                "LWDrawTypes.swift",
                "LWDrafter.swift",
                "LWDrawExtensions.swift",
                "LWDrawViewModel.swift",
                "LWDrawView.swift",
                "LWDrawBar.swift",
                "LWDrawWrapView.swift"
            ]
        )
    ]
)
