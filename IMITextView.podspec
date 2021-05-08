Pod::Spec.new do |s|
  s.name = 'IMITextView'
  s.version = '0.0.1'
  s.summary  = 'Provide background effects of textView like Instagram in iOS'
  
  s.homepage = 'https://github.com/immortal-it/IMITextView'
  s.license = { :type => 'MIT', :file => 'LICENSE' }
  s.author = { 'Immortal' => 'immortal@gmail.com' }
  s.source = { :git => 'https://github.com/immortal-it/IMITextView.git', :tag => s.version }

  s.ios.deployment_target = '11.0'
  s.requires_arc = true
  s.swift_versions = ['5.1', '5.2', '5.3']
  
  s.source_files = 'IMITextView/**/*.{swift}'

  s.pod_target_xcconfig = {
    'SWIFT_INSTALL_OBJC_HEADER' => 'NO'
  }
  
end
