#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint video_player_360.podspec' to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'video_player_360'
  s.version          = '0.0.1'
  s.summary          = 'A flutter plugin to stream 360° videos on iOS'
  s.description      = <<-DESC
This flutter plugin will allow you to play 360° videos via a streaming or direct link
                       DESC
  s.homepage         = 'http://example.com'
  s.license          = { :file => '../LICENSE', :type => 'MIT' }
  s.author           = { 'Your Company' => 'email@example.com' }
  s.source           = { :git => 'https://github.com/innovationmauritiustelecom/video_player_360.git', :tag => "#{s.version}" }
  s.source_files = 'Classes/**/*.{h,m}'
  s.public_header_files = 'Classes/**/*.h'
  s.dependency 'Flutter'
  s.platform = :ios, '8.0'
  s.resource_bundles = {
    '360_bundle' => ['Classes/**/*.{xib,fsh,vsh,xcassets}']
  }
  
  # Flutter.framework does not contain a i386 slice. Only x86_64 simulators are supported.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'VALID_ARCHS[sdk=iphonesimulator*]' => 'x86_64' }
end
