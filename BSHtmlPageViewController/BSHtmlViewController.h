//
//  BSHtmlViewController.h
//
//  Created by Bogdan Stasjuk on 10/28/13.
//

@interface BSHtmlViewController : UIViewController

@property(nonatomic, readonly, assign) NSUInteger index;

- (id)initWithLink:(NSString *)link andIndex:(Byte)index;
- (id)initWithContent:(NSString *)content andIndex:(Byte)index;

#pragma mark - Unavailable methods

#pragma mark -NSObject
+ (id)new __attribute__((unavailable));

#pragma mark -UIViewController
- (id)init __attribute__((unavailable));
- (id)initWithCoder:(NSCoder *)aDecoder __attribute__((unavailable));
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil __attribute__((unavailable));

@end