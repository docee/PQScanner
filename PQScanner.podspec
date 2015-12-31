Pod::Spec.new do |s|
  s.name             = "PQScanner"
  s.version          = "0.1.0"
  s.summary          = "An awesome QR code and Barcode scanner base on iOS7 SDK."
  s.homepage         = "https://github.com/docee/PQScanner"
  s.license          = 'MIT'
  s.author           = { "Docee" => "docee@163.com" }
  s.source           = { :git => "https://github.com/docee/PQScanner.git", :tag => s.version.to_s }
  s.platform     = :ios, '7.0'
  s.requires_arc = true
  s.source_files = 'Pod/Classes/**/*'
  s.resource_bundles = {
    'PQScanner' => ['Pod/Assets/*.png']
  }


end
