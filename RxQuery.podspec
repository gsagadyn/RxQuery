Pod::Spec.new do |s|
  s.name             = 'RxQuery'
  s.version          = '1.2.0'
  s.summary          = 'Extension of RxSwift pod'
  s.homepage         = 'https://github.com/gsagadyn/RxQuery'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Grzegorz Sagadyn' => 'sagadyn@gmail.com' }
  s.source           = { :git => 'https://github.com/gsagadyn/RxQuery.git', :tag => s.version.to_s }

  s.swift_version = "4.2"
  s.ios.deployment_target = '9.3'
  s.frameworks = 'UIKit', 'Foundation'
  s.requires_arc = true
  s.default_subspecs = 'Core', 'Http'
  s.dependency 'RxSwift'

  s.subspec 'Core' do |sp|
    sp.source_files = 'RxQuery/Core/**/*'
  end

  s.subspec 'Http' do |sp|
    sp.source_files = 'RxQuery/Core/**/*', 'RxQuery/Http/**/*'
    sp.dependency 'Alamofire'
  end

end
