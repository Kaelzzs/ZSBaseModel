#
# Be sure to run `pod lib lint ZSBaseModel.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'ZSBaseModel'
  s.version          = '0.0.2'
  s.summary          = 'A short description of ZSBaseModel.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
ZSBaseModel 添加NSString类型的属性的默认值 @“” 空串；避免 nil NULL等导致的UI显示问题  和 多出的解析步骤
                       DESC

  s.homepage         = 'https://github.com/zzsat/ZSBaseModel'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'zzsat' => 'zhouzuosong_Kael@163.com' }
  s.source           = { :git => 'https://github.com/zzsat/ZSBaseModel.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '5.0'

  s.source_files = 'ZSBaseModel/Classes/**/*'
  
  # s.resource_bundles = {
  #   'ZSBaseModel' => ['ZSBaseModel/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'YYModel', '~> 2.3'
end
