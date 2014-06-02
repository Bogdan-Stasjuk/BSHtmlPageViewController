//
//  BSHtmlViewController.m
//
//  Created by Bogdan Stasjuk on 10/28/13.
//

#import "BSHtmlViewController.h"


@interface BSHtmlViewController () <UIWebViewDelegate>

@property(assign, nonatomic) NSUInteger index;
@property(strong, nonatomic) UIWebView  *webView;

@end

@implementation BSHtmlViewController

#pragma mark - Public methods

- (id)initWithLink:(NSString *)link andIndex:(Byte)index
{
    return [self initWithLink:link orContent:nil andIndex:index];
}

- (id)initWithContent:(NSString *)content andIndex:(Byte)index
{
    return [self initWithLink:nil orContent:content andIndex:index];
}

- (id)initWithLink:(NSString *)link orContent:(NSString *)content andIndex:(Byte)index
{
    self = [super init];
    if (self) {
        
        self.index = index;

        self.webView = [[UIWebView alloc] initWithFrame:self.view.frame];
        self.webView.scalesPageToFit = YES;
        self.webView.delegate = self;
        self.view = self.webView;

        if (link) {
            [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:link]]];
        } else {
            [self.webView loadHTMLString:content baseURL:nil];
        }
    }
    return self;
}


#pragma mark - Private methods

#pragma mark -UIWebViewDelegate

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self zoomToFit];
}

#pragma mark -UIViewCotroller

- (void)viewDidLoad
{
    [super viewDidLoad];
    
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    [self zoomToFit];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
    NSLog(@"didReceiveMemoryWarning");
}

#pragma mark -Other

-(void)zoomToFit
{
    if ([self.webView respondsToSelector:@selector(scrollView)])
    {
        UIScrollView *scroll = [self.webView scrollView];
        float zoom = self.webView.bounds.size.width / scroll.contentSize.width;
        NSString *jsCommand = [NSString stringWithFormat:@"document.body.style.zoom = %f;", zoom];
        [self.webView stringByEvaluatingJavaScriptFromString:jsCommand];
    }
}

@end