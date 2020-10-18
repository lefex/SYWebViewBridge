#
# Be sure to run `pod lib lint SYWebViewBridge.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'SYWebViewBridge'
  s.version          = '0.1.0'
  s.summary          = 'A bridge between iOS and WKWebView.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
An iOS modern bridge for sending messages between Objective-C and JavaScript in WKWebView. Include FE and iOS.
                       DESC

  s.homepage         = 'https://github.com/lefex/SYWebViewBridge'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'wsy' => 'wsyxyxs@126.com' }
  s.source           = { :git => 'https://github.com/lefex/SYWebViewBridge.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '9.0'

  s.source_files = './SYWebViewBridge/Classes/**/*'
  
  # s.resource_bundles = {
  #   'SYWebViewBridge' => ['SYWebViewBridge/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
