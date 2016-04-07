Pod::Spec.new do |s|
  s.name             = "ExpressiveEvents"
  s.version          = "0.1.0"
  s.summary          = "Idiomatic µ-framework for event handling."

  s.description      = <<-DESC
  Idiomatic event handling µ-framework.
  Fast, Swift-native implementation of events.
  Event bus approach.
  Compatible with NSNotificationCenter (on demand).
  Subscribe to NSNotificationCenter and KVO.
                       DESC

  s.license          = 'MIT'
  s.author           = { "Andrey Tarantsov" => "andrey@tarantsov.com" }
  s.homepage         = "https://github.com/ExpressiveSwift/ExpressiveEvents"
  s.source           = { :git => "https://github.com/ExpressiveSwift/ExpressiveEvents.git",
                         :tag => "#{s.version.to_s}" }

  s.ios.deployment_target = "8.0"
  s.osx.deployment_target = "10.9"

  s.source_files = 'Sources/*.swift'
end
