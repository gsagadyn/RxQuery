Pod::Spec.new do |s|
  s.name             = 'RxQuery'
  s.version          = '1.8.0'
  s.summary          = 'Extension of RxSwift pod'
  s.homepage         = 'https://github.com/gsagadyn/RxQuery'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Grzegorz Sagadyn' => 'sagadyn@gmail.com' }
  s.source           = { :git => 'https://github.com/gsagadyn/RxQuery.git', :tag => s.version.to_s }

  s.swift_version = "5.1"
  s.ios.deployment_target = '11.0'
  s.frameworks = 'UIKit', 'Foundation'
  s.requires_arc = true
  s.default_subspecs = 'Core', 'Http'
  s.dependency 'RxSwift', '~> 5.1'

  s.subspec 'Core' do |sp|
    sp.source_files = 'RxQuery/Core/**/*'
  end

  s.subspec 'Http' do |sp|
    sp.source_files = 'RxQuery/Core/**/*', 'RxQuery/Http/**/*'
    sp.dependency 'Alamofire', '~> 5.0'
  end

end
