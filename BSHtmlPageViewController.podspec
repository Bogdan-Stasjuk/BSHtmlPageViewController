Pod::Spec.new do |s|
  s.name             	= "BSHtmlPageViewController"
  s.version          	= "0.1.0"
  s.summary          	= "HTML page viewer is based on UIPageViewController with UIWebView, Toolbar and UIPageControl."
  s.description      	= "HTML page viewer is based on UIPageViewController with UIWebView, Toolbar and UIPageControl. Toolbar and UIPageControl instances are available as readonly properties."
  s.homepage         	= "https://github.com/Bogdan-Stasjuk/BSHtmlPageViewController"
  s.license      		= { :type => 'MIT', :file => 'LICENSE' }
  s.author           	= { "Bogdan Stasjuk" => "Bogdan.Stasjuk@gmail.com" }
  s.source           	= { :git => "https://github.com/Bogdan-Stasjuk/BSHtmlPageViewController.git", :tag => '0.1.0' }
  s.social_media_url 	= 'https://twitter.com/Bogdan_Stasjuk'
  s.platform     		= :ios, '6.0'
  s.requires_arc 	= true
  s.source_files 	= 'BSHtmlPageViewController/*.{h,m}'
  s.public_header_files   	= 'BSHtmlPageViewController/*.h'
end
