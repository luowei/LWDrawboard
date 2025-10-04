//
//  LWDrawTypes.swift
//  LWDrawboard
//
//  Created by Swift Conversion
//  Copyright © 2024 MerryUnion. All rights reserved.
//

import Foundation
import UIKit
import Photos

// MARK: - Draw Type Enumeration

/// Drawing tool types
public enum DrawType: Int, CaseIterable {
    case hand = 0           // Free drawing
    case erase              // Eraser
    case line               // Straight line
    case lineArrow          // Arrow
    case rectangle          // Rectangle
    case oval               // Oval
    case text               // Text
    case emojiTile          // Emoji tile/stamp
    case imageTile          // Image tile/stamp
    case rectangleDash      // Dashed rectangle
    case rectangleFill      // Filled rectangle
    case ovalDash           // Dashed oval
    case ovalFill           // Filled oval
    case lineDash           // Dashed line
    case curveDash          // Dashed curve
    case chinesePen         // Chinese calligraphy pen
}

// MARK: - Draw Status

/// Drawing status/mode
public enum DrawStatus {
    case drawing    // Drawing mode
    case editing    // Editing mode
    case texting    // Text input mode
}

// MARK: - Constants

public struct DrawConstants {
    // Minimum/Maximum pen width
    static let widthMin: CGFloat = 5
    static let widthMax: CGFloat = 13

    // Default colors
    static let colorItems = [
        "#000000", "#808080", "#C0C0C0", "#800000", "#A52A2A", "#FFA500",
        "#008000", "#808000", "#FFFFFF", "#FF0000", "#00FFFF", "#0000FF",
        "#0000A0", "#ADD8E6", "#800080", "#FFFF00", "#00FF00", "#FF00FF"
    ]

    // Default emoji set
    static let emojiItems = [
        "👀", "❤", "💛", "💙", "💜", "💔", "❣", "💕", "💞", "💓",
        "💗", "💖", "💘", "💝", "⌚", "📱", "📲", "💻", "📹", "🎥",
        "📽", "🎞", "📞", "☎", "🚕", "🚙", "🚌", "🚎", "🏎", "🚄",
        "✈", "🏕", "⛺", "🏞", "🏘", "🏰", "🏯", "🏟", "🗽", "🏠",
        "🏡", "🏚", "🏢", "💒", "🏛", "⛪", "🕌", "🕍", "🕋", "⚽",
        "🏀", "🏈", "⚾", "🎾", "🏐", "🏉", "🎱", "⛳", "🏌", "🏓",
        "🏸", "🏒", "🏑", "🏏", "🎿", "🍏", "🍎", "🍐", "🍊", "🍋",
        "🍌", "🍉", "🍇", "🍓", "🍈", "🍒", "🍑", "🍍", "🍅", "🍆",
        "🌶", "🌽", "🍠", "🍺", "🍻", "🍷", "🍸", "🍹", "🍾", "🍶",
        "🍵", "☕", "🍦", "🍰", "🎂", "🍮", "🐶", "🐱", "🐭", "🐹",
        "🐰", "🐻", "🐼", "🐨", "🐯", "🦁", "🐮", "🐷", "🐽", "🐸",
        "🐙", "🐵", "🐒", "🐔", "🐧", "🐺", "🐗", "🐴", "🦄", "🐝",
        "🐛", "🐌", "🐞", "🐜", "🕷", "🦂", "🦀", "🐍", "🐢", "🕊",
        "🐕", "🐩", "🐈", "🐇", "🐿", "🐾", "🐉", "🐲", "🌵", "🎄",
        "🌲", "🌳", "🌴", "🌱", "🌿", "🍀", "🎍", "🎋", "🍃", "🍂",
        "🍁", "🌾", "🌺", "🌻", "🌹", "🌷", "🌼", "🌸", "💐", "🍄",
        "🌰", "🎃", "🐚", "🐎", "😀", "😬", "😁", "😂", "😃", "😄",
        "😅", "😆", "😇", "😉", "😊", "🙂", "🙃", "☺", "😋", "😌",
        "😍", "😘", "😗", "😙", "😚", "😜", "😝", "😛", "🤑", "🤓",
        "😎", "🤗", "😏", "😶", "😐", "😑", "😒", "🙄", "🤔", "😳",
        "😞", "😟", "😠", "😡", "😔", "😕", "🙁", "☹", "😣", "😖",
        "😫", "😩", "😤", "😮", "😱", "😨", "😰", "😯", "😦", "😧",
        "😢", "😥", "😪", "😓", "😭", "😵", "😲", "🤐", "😷", "🤒",
        "🤕", "😴", "🙌", "👏", "👋", "👍", "👊", "✊", "✌", "👌",
        "✋", "💪", "🙏", "☝", "👆", "👇", "👈", "👉", "🖕", "🤘",
        "🖖", "✍", "💅", "👄", "👅", "👂", "👃", "👁"
    ]

    // Default font names
    static let fontNames = [
        "Helvetica", "Helvetica-Bold", "Helvetica-BoldOblique",
        "Helvetica-Light", "Helvetica-LightOblique", "HelveticaNeue",
        "HelveticaNeue-Bold", "HelveticaNeue-CondensedBold",
        "HelveticaNeue-Light", "HelveticaNeue-Medium",
        "HelveticaNeue-Thin", "HelveticaNeue-UltraLight",
        "MarkerFelt-Thin", "Noteworthy-Light", "SavoyeLetPlain",
        "SnellRoundhand-Bold", "TimesNewRomanPSMT",
        "STFangsong", "STHeiti", "STKaiti", "STSong", "STXihei",
        "LiHeiPro", "LiSongPro",
        "PingFangSC-Light", "PingFangSC-Medium", "PingFangSC-Regular",
        "PingFangSC-Semibold", "PingFangSC-Thin", "PingFangSC-Ultralight",
        "PingFangTC-Light", "PingFangTC-Medium", "PingFangTC-Regular",
        "PingFangTC-Semibold", "PingFangTC-Thin", "PingFangTC-Ultralight"
    ]
}
