Pod::Spec.new do |s|
  s.name             = 'XTIBaseTool'
  s.version          = '1.0'
  s.summary          = 'XTIBaseTool'

  s.description      = <<-DESC
  TODO:
                       DESC

  s.homepage         = 'https://github.com/xt-input/XTIBaseTool'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'xt-input' => 'input@tcoding.cn' }
  s.source           = { :git => 'https://github.com/xt-input/XTIBaseTool.git', :tag => s.version.to_s }

  s.ios.deployment_target = '10.0'

  s.source_files = 'Source/**/*.swift'

  s.swift_version = '5'
  s.requires_arc  = true
end
