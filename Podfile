platform :ios, '9.0'

use_frameworks!
inhibit_all_warnings!

target 'SKImageCache' do
	project 'SKImageCache.xcodeproj'
	workspace 'SKImageCache.xcworkspace'
	pod 'SwiftLint', '= 0.26.0'
end

target 'SKImageCacheTests' do
	project 'SKImageCache.xcodeproj'
	pod 'Nimble', '= 7.1.3'
	pod 'Quick', '= 1.3.1'
end

target 'SampleProject' do
	project 'SampleProject/SampleProject.xcodeproj'
	pod 'SKTableViewDataSource', '= 2.0.0'
	pod 'SKWebServiceController', '= 1.0.0'
end