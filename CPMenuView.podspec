#
# Be sure to run `pod lib lint CPMenuView.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.platform = :ios
  s.ios.deployment_target = '8.0'
  s.name             = 'CPMenuView'
  s.version          = ‘1.1.0’
  s.summary          = 'Simple circle menu'
  s.homepage         = 'https://github.com/phuongvnc/CPMenuView'
  s.requires_arc = true
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Chi Phuong' => 'vonguyenchiphuong@gmail.com' }
  s.source           = { :git => 'https://github.com/phuongvnc/CPMenuView.git', :tag => s.version.to_s }
  s.ios.deployment_target = '8.0'
  s.source_files = 'CPMenuView/*'
  s.requires_arc = true
  s.frameworks = 'UIKit'
end
