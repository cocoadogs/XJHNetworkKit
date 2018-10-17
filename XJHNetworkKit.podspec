#
# Be sure to run `pod lib lint XJHNetworkKit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'XJHNetworkKit'
  s.version          = '0.1.2'
  s.summary          = '基于YTKNetwork的网络框架.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = '基于YTKNetwork的网络框架.@GODXJH'

  s.homepage         = 'https://github.com/cocoadogs/XJHNetworkKit'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'cocoadogs' => 'cocoadogs@163.com' }
  s.source           = { :git => 'https://github.com/cocoadogs/XJHNetworkKit.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '9.0'

  s.source_files = 'XJHNetworkKit/XJHNetworkKit.h'
  
  s.subspec 'Config' do |ss|
      ss.public_header_files = 'XJHNetworkKit/XJHNetworkConfig.h','XJHNetworkKit/XJHNetworkConfigParamsBuilder.h'
      ss.source_files = 'XJHNetworkKit/XJHNetworkConfig.{h,m}','XJHNetworkKit/XJHNetworkConfigParamsBuilder.{h,m}'
  end
  
  s.subspec 'Request' do |ss|
      ss.public_header_files = 'XJHNetworkKit/XJHRequest.h','XJHNetworkKit/XJHRequest+HUDDefalut.h'
      ss.source_files = 'XJHNetworkKit/XJHRequest.{h,m}','XJHNetworkKit/XJHRequest+HUDDefalut.{h,m}'
      ss.dependency 'XJHNetworkKit/HUDProtocol'
      ss.resource = 'XJHNetworkKit/XJHNetworkKit.bundle'
      ss.dependency 'XJHNetworkKit/Config'
      ss.dependency 'MBProgressHUD', '0.9.2'
  end
  
  s.subspec 'HUDProtocol' do |ss|
      ss.public_header_files = 'XJHNetworkKit/XJHRequestHUDProtocol.h'
      ss.source_files = 'XJHNetworkKit/XJHRequestHUDProtocol.h'
  end
  
  # s.resource_bundles = {
  #   'XJHNetworkKit' => ['XJHNetworkKit/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
  s.dependency 'YTKNetwork', '~> 2.0.4'
  s.dependency 'ReactiveObjC', '~> 3.1.0'
end
