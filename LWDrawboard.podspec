#
# Be sure to run `pod lib lint LWDrawboard.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'LWDrawboard'
  s.version          = '1.0.0'
  s.summary          = '一个可自定义笔触大小颜色的画板和涂鸦板。'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
LWDrawboard，可自定义笔触大小颜色的画板涂鸦板，绘制的矩形、圆形、多边形、箭头、文字的颜色大小形状可调节，并且支持马塞克、裁剪等功能。
                       DESC

  s.homepage         = 'https://github.com/luowei/LWDrawboard.git'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'luowei' => 'luowei@wodedata.com' }
  s.source           = { :git => 'https://github.com/luowei/LWDrawboard.git'}
  # s.source           = { :git => 'https://gitlab.com/ioslibraries1/libdrawboard.git' }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'LWDrawboard/Classes/**/*'
  s.exclude_files = 'LWDrawboard/SwiftUI/**/*.swift'
  
  s.resource_bundles = {
    'LWDrawboard' => ['LWDrawboard/Assets/**/*']
  }

  s.public_header_files = 'LWDrawboard/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'

  s.dependency 'Masonry'
  s.dependency 'SDWebImage'
end
