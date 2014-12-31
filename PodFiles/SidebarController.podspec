Pod::Spec.new do |s|
  s.name     = 'SidebarController'
  s.version  = '1.0'
  s.platform = :ios
  s.summary  = 'A usable wrapper for UISplitViewController to act as a side bar.'
  s.homepage = 'https://github.com/justAnotherDev/SidebarController'
  s.author   = { 'Casey Evanoff' => 'cwe7976@gmail.com' }
  s.source   = { :git           => 'https://github.com/justAnotherDev/SidebarController.git' }

  s.source_files = 'SidebarController.{h,m}'

  s.requires_arc    = true
  s.ios.deployment_target = '8.0'

end