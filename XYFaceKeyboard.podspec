Pod::Spec.new do |s|

  s.name         = "XYFaceKeyboard"
  s.version      = "0.0.1"
  s.summary      = "a custom face keyboard"
  s.description  = <<-DESC
  a custom face keyboard(you can add youself face images)
                   DESC

  s.homepage     = "https://github.com/cryboyofyu/XYFaceKeyboard.git"

  s.license      = "MIT"
  # s.license      = { :type => "MIT", :file => "FILE_LICENSE" }


  

  s.author             = { "LV" => "cryboyofyu@gmail.com" }
  # Or just: s.author    = "LV"
  # s.authors            = { "LV" => "cryboyofyu@gmail.com" }
   s.platform     = :ios, "7.0"

  s.source       = { :git => "https://github.com/cryboyofyu/XYFaceKeyboard.git", :tag => "{0.0.1}" }


  s.source_files  = "XYFaceKeyboard/XYViews/*.{h,m}"
 

  s.resources = "XYFaceKeyboard/XYImgs/**/*.{png,gif}"
  s.resources = "XYFaceKeyboard/XYSource/*.plist"


  s.framework  = "UIKit"
  s.requires_arc = true
  s.dependency 'YYImage'
  s.dependency 'SDWebImage'
  s.dependency 'YYText'
end
