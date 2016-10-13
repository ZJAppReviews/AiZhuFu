
#import "LoadingView.h"

@implementation LoadingView

- (id)init
{
    if(self = [super init])
    {
        self.frame = CGRectMake(0, 0, WIDTH, 40);
        self.backgroundColor = [UIColor yellowColor];
        
        self.textLable = [[UILabel alloc]initWithFrame:CGRectMake(WIDTH/2-40, 0, 80, 40)];
        self.textLable.text = @"加载更多";
        self.textLable.textAlignment = NSTextAlignmentCenter;
        self.textLable.textColor = [UIColor redColor];
        [self addSubview:self.textLable];
        
        self.activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        self.activityIndicatorView.frame = CGRectMake(WIDTH/2-60, 0, 40, 40);
        [self addSubview:self.activityIndicatorView];
        
        self.button = [UIButton buttonWithType:UIButtonTypeCustom];
        self.button.frame = self.frame;
        self.button.backgroundColor = [UIColor clearColor];
        [self addSubview:self.button];
    }
    return self;
}

- (void)start
{
    self.textLable.frame = CGRectMake(WIDTH/2-20, 0, 80, 40);
    self.textLable.text = @"正在加载";
    [self.activityIndicatorView startAnimating];
}

- (void)stop
{
    [self.activityIndicatorView stopAnimating];
    self.textLable.frame = CGRectMake(WIDTH/2-40, 0, 80, 40);
    self.textLable.text = @"加载更多";
}

@end
