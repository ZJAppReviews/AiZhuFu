
#import <UIKit/UIKit.h>

#define HEIGHT [UIScreen mainScreen].bounds.size.height
#define WIDTH [UIScreen mainScreen].bounds.size.width

@interface LoadingView : UIView

@property (nonatomic, strong) UIActivityIndicatorView *activityIndicatorView;
@property (nonatomic, strong) UILabel *textLable;
@property (nonatomic, strong) UIButton *button;

- (void)start;
- (void)stop;

@end


