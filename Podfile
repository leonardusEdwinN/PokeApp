# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'PokeApp' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
  pod 'SDWebImage'
  pod 'SwiftEntryKit', '2.0.0'

  # Pods for PokeApp

  target 'PokeAppTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'PokeAppUITests' do
    # Pods for testing
  end

end


post_install do |installer|
    installer.generated_projects.each do |project|
        project.targets.each do |target|
            target.build_configurations.each do |config|
                config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.0'
            end
        end
    end
end
