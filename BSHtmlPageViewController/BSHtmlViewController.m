//
//  BSHtmlViewController.m
//
//  Created by Bogdan Stasjuk on 10/28/13.
//

#import "BSHtmlViewController.h"


@interface BSHtmlViewController ()

@property(nonatomic, assign) NSUInteger index;

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

        UIWebView *webView = [[UIWebView alloc] initWithFrame:self.view.frame];
        webView.scalesPageToFit = YES;
        self.view = webView;

        if (link) {
            [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:link]]];
        } else {
            [webView loadHTMLString:content baseURL:nil];
        }
    }
    return self;
}


#pragma mark - Private methods

#pragma mark -UIViewCotroller

- (void)viewDidLoad
{
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
    NSLog(@"didReceiveMemoryWarning");
}

@end