BSHtmlPageViewController
========================

HTML page viewer for iPhone and iPad is based on UIPageViewController with UIWebView, Toolbar and UIPageControl.

__Toolbar__ and __UIPageControl__ are open for customization:

```objc
@property(nonatomic, strong, readonly) UIToolbar          *toolbar;
@property(nonatomic, strong, readonly) UIPageControl      *pageControl;
```

Method for __initialization__ is only one:

```objc
- (id)initWithDataSource:(id)dataSource andStartPageNum:(Byte)startPage;
```

__Data source protocol__ is below:

```objc
@protocol BSHtmlPageViewControllerDataSource <NSObject>

@required
- (Byte)numberOfHtmlPages;

@optional
- (NSString *)htmlLinkForPage:(Byte)pageNumber;
- (NSString *)htmlContentForPage:(Byte)pageNumber;

@end
```

One of the optional methods is required to be implemented.


Demo
====

Clone project and run it. You can find examples of usage at `TestViewController.m`.


Compatibility
=============

This class has been tested back to iOS 6.0.


Installation
============

__CocoaPods__: `pod 'BSHtmlPageViewController'`<br />
__Manual__: Copy the __BSHtmlPageViewController__ folder in your project and import header:

    #import "BSHtmlPageViewController.h"


License
=======

This code is released under the MIT License. See the LICENSE file for
details.
