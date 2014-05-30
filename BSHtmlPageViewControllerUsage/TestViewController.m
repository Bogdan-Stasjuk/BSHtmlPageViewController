//
//  TestViewController.m
//  BSHtmlPageViewControllerUsage
//
//  Created by Bogdan Stasjuk on 5/30/14.
//  Copyright (c) 2014 Bogdan Stasjuk. All rights reserved.
//

#import "TestViewController.h"

#import "BSHtmlPageViewController.h"


@interface TestViewController () <BSHtmlPageViewControllerDataSource>

@end

@implementation TestViewController

#pragma mark - Private methods

#pragma mark -UIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    BSHtmlPageViewController *htmlPageViewController = [[BSHtmlPageViewController alloc] initWithDataSource:self];
    htmlPageViewController.modalPresentationStyle = UIModalPresentationFullScreen;
    
    UIBarButtonItem *mailButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemReply target:self action:@selector(buttonMailPressed)];
    UIBarButtonItem *printButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCompose target:self action:@selector(buttonPrintPressed)];
    NSMutableArray *toobarItems = htmlPageViewController.toolbar.items.mutableCopy;
    [toobarItems addObjectsFromArray:@[mailButton, printButton]];
    htmlPageViewController.toolbar.items = toobarItems;
    
    [self presentViewController:htmlPageViewController animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -BSHtmlPageViewControllerDataSource

//- (NSString *)htmlLinkForPage:(Byte)pageNumber
//{
//    switch (pageNumber) {
//        case 0:
//            return @"http://google.com/";
//        case 1:
//            return @"http://apple.com/";
//        case 2:
//            return nil;
//        case 3:
//            return @"http://news.com/";
//        case 4:
//            return @"";
//            
//        default:
//            return nil;
//    }
//}

- (NSString *)htmlContentForPage:(Byte)pageNumber
{
    NSString* path = [[NSBundle mainBundle] pathForResource:@"HtmlContent" ofType:@"txt"];
    NSString* content = [NSString stringWithContentsOfFile:path
                                                  encoding:NSUTF8StringEncoding
                                                     error:NULL];
    switch (pageNumber) {
        case 0:
            return content;
        case 1:
            return content;
        case 2:
            return content;

        default:
            return nil;
    }
}

- (Byte)numberOfHtmlPages
{
    return 3;
}

#pragma mark -Actions

- (void)buttonMailPressed
{
    
}

- (void)buttonPrintPressed
{
    
}

@end