# Uncomment the next line to define a global platform for your project
# platform :ios, '15.0'

workspace 'Hobbyloop'
project './App/Hobbyloop.xcodeproj'


target 'Hobbyloop' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for Hobbyloop
  project './App/Hobbyloop.xcodeproj'

  pod 'naveridlogin-sdk-ios'
  pod 'NMapsMap', '3.16.2'

end

post_install do |installer|
  installer.pods_project.build_configurations.each do |config|
    config.build_settings["EXCLUDED_ARCHS[sdk-iphonesimulator*]"] = "arm64"
    config.build_settings.delete 'IPHONEOS_DEPLOYMENT_TARGET'
  end
end

