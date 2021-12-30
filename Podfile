# Uncomment the next line to define a global platform for your project
platform :ios, '11.0'

def swiftlint
  pod 'SwiftLint'
end

def sourcery
  pod 'Sourcery'
end

def snapKit
  pod 'SnapKit'
end

target 'DictionaryApp' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for DictionaryApp
  swiftlint
  sourcery
  snapKit
  
  target 'DictionaryAppTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'DictionaryAppUITests' do
    # Pods for testing
  end

end
