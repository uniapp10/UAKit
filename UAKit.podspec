#
# Be sure to run `pod lib lint UAKit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'UAKit'
  s.version          = '0.1.0'
  s.summary          = 'Use to create app base rapidly.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
UAKit
                       DESC

  s.homepage         = 'https://github.com/uniapp10/UAKit'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'uniapp10' => 'zhudong10@163.com' }
  s.source           = { :git => 'https://github.com/uniapp10/UAKit.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'UAKit/Classes/**/*'

  s.subspec 'Category' do |wh|
    wh.source_files = "UAKit/Category/**/*.{h,m,pch,swift}"
    wh.public_header_files = "Base/**/*.{h}"
    #wh.resource_bundles = {'WindHUD' => ['CommonLibSDK/Resources/WindHUD/WindHUD.bundle/{*,.*}']}
    #wh.framework = 'QuartzCore'
    wh.framework = 'UIKit', 'Foundation'
    wh.requires_arc = true
  end

  s.subspec 'Base' do |wh|
    wh.source_files = "UAKit/Base/**/*.{h,m,pch,swift}"
    wh.public_header_files = "Base/**/*.{h}"
    #wh.resource_bundles = {'WindHUD' => ['CommonLibSDK/Resources/WindHUD/WindHUD.bundle/{*,.*}']}
    #wh.framework = 'QuartzCore'
    wh.framework = 'UIKit', 'Foundation'
    wh.requires_arc = true
  end
  
  # s.resource_bundles = {
  #   'UAKit' => ['UAKit/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
