//
//  BSHtmlPageViewController.m
//
//  Created by Bogdan Stasjuk on 10/28/13.
//

#import "BSHtmlPageViewController.h"

#import "BSHtmlViewController.h"


typedef NS_ENUM(Byte, WebViewLoadSource)
{
    WebViewLoadSourceNone,
    WebViewLoadSourceLink,
    WebViewLoadSourceContent,
};


const Byte ToolBarHeight = 66.f;
const Byte PageControllBottomShift = 10.f;


@interface BSHtmlPageViewController () <UIPageViewControllerDelegate, UIPageViewControllerDataSource>

@property(nonatomic, weak) id<BSHtmlPageViewControllerDataSource> dataSource;

@property(nonatomic, strong) UIToolbar          *toolbar;
@property(nonatomic, strong) UIPageControl      *pageControl;
@property(nonatomic, assign) WebViewLoadSource  webViewLoadSource;

@end


@implementation BSHtmlPageViewController

#pragma mark - Properties

#pragma mark -Public

- (UIPageControl *)pageControl
{
    return _pageControl;
}

#pragma Public methods

- (id)initWithDataSource:(id)dataSource andStartPageNum:(Byte)startPage
{
    self = [super init];
    if (self) {
        self.dataSource = dataSource;
        self.webViewLoadSource = [self.dataSource respondsToSelector:@selector(htmlLinkForPage:)] ? WebViewLoadSourceLink :
        ([self.dataSource respondsToSelector:@selector(htmlContentForPage:)] ? WebViewLoadSourceContent : WebViewLoadSourceNone);
        
        [self setupPageViewControllerWithStartPage:startPage];
        [self addToolBar];
        [self setupPageControlWithStartPage:startPage];
    }
    return self;
}

#pragma mark - Private methods

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
    // Dispose of any resources that can be recreated.
    NSLog(@"didReceiveMemoryWarning");
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    self.pageControl.hidden = YES;
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    CGFloat pageControlTop = ((self.interfaceOrientation == UIInterfaceOrientationLandscapeLeft ||
                               self.interfaceOrientation == UIInterfaceOrientationLandscapeRight) ?
                              [[UIScreen mainScreen] bounds].size.width : [[UIScreen mainScreen] bounds].size.height) - PageControllBottomShift;
    CGRect pageControlFrame = self.pageControl.frame;
    pageControlFrame.origin.y = pageControlTop;
    self.pageControl.frame = pageControlFrame;
    self.pageControl.hidden = NO;
}

#pragma mark -UIPageViewControllerDataSource

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController
      viewControllerBeforeViewController:(BSHtmlViewController *)viewController
{
    NSInteger currentIndex = viewController.index - 1;
    if (currentIndex < 0 || self.webViewLoadSource == WebViewLoadSourceNone) {
        return nil;
    }
    return self.webViewLoadSource == WebViewLoadSourceLink ? [[BSHtmlViewController alloc] initWithLink:[self.dataSource htmlLinkForPage:currentIndex] andIndex:currentIndex] :
            [[BSHtmlViewController alloc] initWithContent:[self.dataSource htmlContentForPage:currentIndex] andIndex:currentIndex];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController
       viewControllerAfterViewController:(BSHtmlViewController *)viewController
{
    NSInteger currentIndex = viewController.index + 1;
    if (self.dataSource == WebViewLoadSourceNone || currentIndex >= [self.dataSource numberOfHtmlPages]) {
        return nil;
    }
    return self.webViewLoadSource == WebViewLoadSourceLink ? [[BSHtmlViewController alloc] initWithLink:[self.dataSource htmlLinkForPage:currentIndex] andIndex:currentIndex] :
    [[BSHtmlViewController alloc] initWithContent:[self.dataSource htmlContentForPage:currentIndex] andIndex:currentIndex];
}


#pragma mark - UIPageViewControllerDelegate methods

- (void)pageViewController:(UIPageViewController *)viewController
        didFinishAnimating:(BOOL)finished
   previousViewControllers:(NSArray *)previousViewControllers
       transitionCompleted:(BOOL)completed
{
    if (!completed) return;
    
    BSHtmlViewController *currentViewController = (BSHtmlViewController *)[viewController.viewControllers lastObject];
    self.pageControl.currentPage = currentViewController.index;
}


#pragma mark - Private methods

- (void)setupPageViewControllerWithStartPage:(Byte)startPage
{
    if (self.webViewLoadSource == WebViewLoadSourceNone) {
        return;
    }
    BSHtmlViewController *htmlViewController = (self.webViewLoadSource == WebViewLoadSourceLink) ?
                                                [[BSHtmlViewController alloc] initWithLink:[self.dataSource htmlLinkForPage:startPage] andIndex:startPage] :
                                                [[BSHtmlViewController alloc] initWithContent:[self.dataSource htmlContentForPage:startPage] andIndex:startPage];
    
    UIPageViewController *pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll
                                                                               navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal
                                                                                             options:nil];
    pageViewController.dataSource = self;
    pageViewController.delegate = self;
    [pageViewController setViewControllers:@[htmlViewController]
                                 direction:UIPageViewControllerNavigationDirectionForward
                                  animated:NO
                                completion:nil];
    [self addChildViewController:pageViewController];
    pageViewController.view.frame = CGRectMake(0.f,
                                               ToolBarHeight,
                                               self.view.frame.size.width,
                                               self.view.frame.size.height - ToolBarHeight);
    
    [self.view addSubview:pageViewController.view];
}

- (void)setupPageControlWithStartPage:(Byte)startPage
{
    CGFloat pageControlTop = ((self.interfaceOrientation == UIInterfaceOrientationLandscapeLeft ||
                              self.interfaceOrientation == UIInterfaceOrientationLandscapeRight) ?
                              [[UIScreen mainScreen] bounds].size.width : [[UIScreen mainScreen] bounds].size.height) - PageControllBottomShift;
    self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake([[UIScreen mainScreen] bounds].size.width / 2,
                                                                       pageControlTop,
                                                                       0.f,
                                                                       0.f)];
    self.pageControl.numberOfPages = ([self.dataSource respondsToSelector:@selector(numberOfHtmlPages)]) ? [self.dataSource numberOfHtmlPages] : 0;
    self.pageControl.pageIndicatorTintColor = [UIColor grayColor];
    self.pageControl.currentPageIndicatorTintColor = [UIColor blackColor];
    self.pageControl.currentPage = startPage;
    [self.view addSubview:self.pageControl];
}

#pragma mark -Actions

- (void)doneButtonPressed
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark -Other

- (void)addToolBar
{
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneButtonPressed)];
    UIBarButtonItem *flexibleSpaceButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];

    self.toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0.f, 0.f, self.view.frame.size.width, ToolBarHeight)];
    self.toolbar.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    self.toolbar.items = @[doneButton, flexibleSpaceButton];
    
    [self.view addSubview:self.toolbar];
}

@end