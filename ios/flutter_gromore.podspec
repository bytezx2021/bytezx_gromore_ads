#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint flutter_gromore.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'flutter_gromore'
  s.version          = '0.0.1'
  s.summary          = '穿山甲Gromore插件'
  s.description      = <<-DESC
穿山甲Gromore插件
                       DESC
  s.homepage         = 'http://example.com'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Your Company' => 'email@example.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.dependency 'Flutter'

  s.dependency 'Ads-CN-Beta', '6.5.0.1'
  s.platform = :ios, '12.0'

  s.static_framework = true
  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version = '5.0'
end
