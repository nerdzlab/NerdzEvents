

Pod::Spec.new do |s|
  s.name             = 'NerdzEvents'
  s.version          = '1.0.11'
  s.summary          = 'Reactive approach for events tracking and triggering'
  s.homepage         = 'https://github.com/nerdzlab/NerdzEvents'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'NerdzLab' => 'supernerd@nerdzlab.com' }
  s.source           = { :git => 'https://github.com/nerdzlab/NerdzEvents.git', :tag => s.version }
  s.social_media_url = 'https://nerdzlab.com'
  s.ios.deployment_target = '12.0'
  s.swift_versions = ['5.0']
  s.source_files = 'Sources/**/*'
end
