#
# LWDrawboard_swift.podspec
# Swift version of LWDrawboard
#

Pod::Spec.new do |s|
  s.name             = 'LWDrawboard_swift'
  s.version          = '1.0.0'
  s.summary          = 'Swift version of LWDrawboard - A powerful drawing and sketching board'

  s.description      = <<-DESC
LWDrawboard_swift is a modern Swift/SwiftUI implementation of the LWDrawboard library.
A comprehensive drawing and sketching solution with:
- Multiple drawing tools (pen, eraser, shapes)
- Customizable brush sizes and colors
- Drawing shapes (rectangle, circle, polygon, arrow)
- Text annotations with custom fonts
- Mosaic/blur effects
- Image cropping functionality
- Undo/Redo support
- SwiftUI and UIKit integration
- Export to image
- Gesture-based controls
                       DESC

  s.homepage         = 'https://github.com/luowei/LWDrawboard.git'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'luowei' => 'luowei@wodedata.com' }
  s.source           = { :git => 'https://github.com/luowei/LWDrawboard.git', :tag => s.version.to_s }

  s.ios.deployment_target = '14.0'
  s.swift_version = '5.0'

  s.source_files = 'LWDrawboard_swift/SwiftUI/**/*'

  s.resource_bundles = {
    'LWDrawboard_swift' => ['LWDrawboard/Assets/**/*']
  }

  s.frameworks = 'UIKit', 'SwiftUI', 'Combine', 'CoreGraphics'
  s.dependency 'Masonry'
  s.dependency 'SDWebImage'
end
