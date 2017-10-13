Pod::Spec.new do |spec|
  spec.name = 'SKImageCache'
  spec.version = '2.0.0'
  spec.license = 'MIT'
  spec.summary = 'A simple image cache.'
  spec.homepage = 'https://github.com/skladek/SKImageCache'
  spec.authors = { 'Sean Kladek' => 'skladek@gmail.com' }
  spec.source = { :git => 'https://github.com/skladek/SKImageCache.git', :tag => spec.version }
  spec.ios.deployment_target = '9.0'
  spec.source_files = 'Source/*.swift'
end
