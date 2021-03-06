Pod::Spec.new do |s|
  s.name             = 'XTIUIKit'
  s.version          = '1.0'
  s.summary          = 'XTIUIKit'

  s.description      = <<-DESC
  TODO:
                       DESC

  s.homepage         = 'https://github.com/xtinput/XTIBaseTool'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'xt-input' => 'input@tcoding.cn' }
  s.source           = { :git => 'https://github.com/xtinput/XTIBaseTool.git', :tag => s.version.to_s }

  s.ios.deployment_target = '10.0'

  s.source_files = 'Source/UIKit/*.swift'
  s.dependency 'XTIBaseUIKit'

  s.swift_version = '5'
  s.requires_arc  = true
end
