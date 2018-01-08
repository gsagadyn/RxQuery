Pod::Spec.new do |s|
  s.name             = 'RxQuery'
  s.version          = '1.0.1'
  s.summary          = 'Extension of RxSwift pod'
  s.homepage         = 'https://github.com/gsagadyn/RxQuery'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Grzegorz Sagadyn' => 'sagadyn@gmail.com' }
  s.source           = { :git => 'https://github.com/gsagadyn/RxQuery.git', :tag => s.version.to_s }

  s.ios.deployment_target = '10.3'
  s.frameworks = 'UIKit', 'Foundation'
  s.requires_arc = true
  s.default_subspecs = 'Core', 'Internet'
  s.dependency 'RxSwift'
  s.dependency 'Alamofire'

  s.subspec 'Core' do |sp|
    s.source_files = 'RxQuery/Core/**/*'
  end

  s.subspec 'Internet' do |sp|
    sp.source_files = 'RxQuery/Core/**/*', 'RxQuery/Internet/**/*'
  end

end
