Pod::Spec.new do |s|
  s.platform     = :ios, '7.0'
  s.name         = 'YJStretchableBar'
  s.version      = '1.0.1'
  s.summary      = 'An easy and stretchable tool bar.'
  s.homepage     = 'https://github.com/SplashZ/YJStretchableBar'
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.author            = { "splashz" => "splashz@163.com" }
  s.ios.deployment_target = '7.0'
  s.source       = { :git => 'https://github.com/SplashZ/YJStretchableBar.git', :tag => s.version.to_s }
  s.requires_arc = true
  s.source_files = "YJStretchableBar/*.{h,m}"
  s.public_header_files = 'YJStretchableBar/*.{h}'
end