
#import <UIKit/UIKit.h>
#import "TabBarController.h"

@interface WelcomeController : UIViewController <UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIPageControl *pageControl;

@end
