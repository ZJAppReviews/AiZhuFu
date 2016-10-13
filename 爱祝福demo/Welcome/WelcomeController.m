
#import "WelcomeController.h"

#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height

@implementation WelcomeController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(WIDTH/2-25, HEIGHT*0.92, 50,10)];
    self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
    
    self.scrollView.delegate = self;
    self.scrollView.contentSize = CGSizeMake(WIDTH*3, HEIGHT);
    self.scrollView.pagingEnabled = YES;
    self.scrollView.bounces = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    
    self.pageControl.numberOfPages = 3;
    self.pageControl.pageIndicatorTintColor = [UIColor grayColor];
    self.pageControl.currentPageIndicatorTintColor = [UIColor redColor];
    
    [self.view addSubview:self.scrollView];
    [self.view addSubview:self.pageControl];
    
    for(int i=1;i<4;i++)
    {
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake((i-1)*WIDTH, 0, WIDTH, HEIGHT)];
        imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d.png",i]];
        [self.scrollView addSubview:imageView];
    }
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = CGRectMake(2*WIDTH+WIDTH*0.7, 40, 90, 35);
    button.layer.cornerRadius = 5;
    button.layer.borderColor = [UIColor redColor].CGColor;
    button.layer.borderWidth = 1;
    [button setTitle:@"立即体验" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:15];
    [button addTarget:self action:@selector(goToTab) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollView addSubview:button];
    
}

- (void)goToTab
{
    TabBarController *tabBarController = [[TabBarController alloc]init];
    [self presentViewController:tabBarController animated:YES completion:nil];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setBool:YES forKey:@"isFirst"];
}


#pragma UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    self.pageControl.currentPage = scrollView.contentOffset.x/WIDTH;
}
#pragma Mark



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}



@end
