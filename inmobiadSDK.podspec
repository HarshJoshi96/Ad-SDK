#
# Be sure to run `pod lib lint myCocoaPodLibrary.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'inmobiadSDK'
  s.version          = '0.0.5'
  s.summary          = 'InMobi Ad SDK'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = 'This library will allow user to integrate inMobi ad in their Native iOS code'

  s.homepage         = 'https://github.com/HarshJoshi96/Ad-SDK'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { '66667656' => 'harsh.joshi@infobeans.com' }
  s.source           = { :git => 'https://github.com/HarshJoshi96/Ad-SDK', :tag => s.version.to_s }
  s.swift_version     = '5.0'
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '13.0'
  s.pod_target_xcconfig = { 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64' }
  s.user_target_xcconfig = { 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64' }

  s.source_files = 'myCocoaPodLibrary/Classes/**/*'
  
   s.resource_bundles = {
     'Resources' => ['myCocoaPodLibrary/Assets/*.png']
   }

  # s.public_header_files = 'Pod/Classes/**/*.h'
   s.frameworks = 'UIKit', 'AVKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
