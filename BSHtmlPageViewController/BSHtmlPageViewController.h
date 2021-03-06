//
//  BSHtmlPageViewController.h
//
//  Created by Bogdan Stasjuk on 10/28/13.
//

@protocol BSHtmlPageViewControllerDelegate;


@interface BSHtmlPageViewController : UIViewController

/*!
 * @brief html view delegate property
 */
@property(weak, nonatomic) id<BSHtmlPageViewControllerDelegate> pageDelegate;

@property(nonatomic, strong, readonly) UIToolbar          *toolbar;
@property(nonatomic, strong, readonly) UIPageControl      *pageControl;

- (id)initWithDataSource:(id)dataSource andStartPageNum:(Byte)startPage;

#pragma mark - Unavailable methods

#pragma mark -NSObject
+ (id)new __attribute__((unavailable));

#pragma mark -UIViewController
- (id)init __attribute__((unavailable));
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil __attribute__((unavailable("initWithNibName:bundle: not available")));
- (id)initWithCoder:(NSCoder *)aDecoder __attribute__((unavailable("initWithCoder: not available")));

@end


@protocol BSHtmlPageViewControllerDataSource <NSObject>

@required
- (Byte)numberOfHtmlPages;

@optional
- (NSString *)htmlLinkForPage:(Byte)pageNumber;
- (NSString *)htmlContentForPage:(Byte)pageNumber;

@end


@protocol BSHtmlPageViewControllerDelegate <NSObject>

@optional
- (void)viewWillClose;

@end
