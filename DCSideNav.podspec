Pod::Spec.new do |s|
  s.name         = "DCSideNav"
  s.version      = "0.1.1"
  s.summary      = "Custom Navigation for iPad. Similar to iPad twitter app navigation"
  s.homepage     = "https://github.com/daltoniam/DCSideNav"
  s.license      = 'Apache License, Version 2.0'
  s.author       = { "Dalton Cherry" => "daltoniam@gmail.com" }
  s.social_media_url = 'http://twitter.com/daltoniam'
  s.source       = { :git => "https://github.com/daltoniam/DCSideNav.git", :tag => "#{s.version}" }
  s.screenshot  = "https://raw.github.com/daltoniam/DCSideNav/master/screenshots/demo.png"
  s.ios.deployment_target = '7.0'
  s.source_files = '*.{h,m}'
  s.requires_arc = true
end