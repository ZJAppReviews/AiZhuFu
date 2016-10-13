
#import "TabBarController.h"

#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height

@implementation TabBarController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    HomeController *homeController = [[HomeController alloc]init];
    CollectionController *collectionController = [[CollectionController alloc]init];
    SearchController *searchController = [[SearchController alloc]init];
    MoreController *moreController = [[MoreController alloc]init];
    
    NavigationController *homeNavController = [[NavigationController alloc]initWithRootViewController:homeController];
    NavigationController *collectionNavController = [[NavigationController alloc]initWithRootViewController:collectionController];
    NavigationController *searchNavController = [[NavigationController alloc]initWithRootViewController:searchController];
    NavigationController *moreNavController = [[NavigationController alloc]initWithRootViewController:moreController];
    
    [self setViewControllers:@[homeNavController,collectionNavController,searchNavController,moreNavController] animated:YES];
    
    
    self.delegate = self;
    
    self.tabBar.barTintColor = [UIColor colorWithRed:254/255.0 green:61/255.0 blue:80/255.0 alpha:1];
    self.tabBar.tintColor = [UIColor yellowColor];
    
    homeNavController.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"首页" image:[UIImage imageNamed:@"icon_home.png"] tag:1];
    
    collectionNavController.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"收藏" image:[UIImage imageNamed:@"icon_fav.png"] tag:2];
    
    searchNavController.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"搜索" image:[UIImage imageNamed:@"icon_search.png"] tag:3];
    
    moreNavController.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"更多" image:[UIImage imageNamed:@"icon_more.png"] tag:4];

    
    
    for(UITabBarItem *item in self.tabBar.items)
    {
        [item setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],
                                       NSFontAttributeName:[UIFont systemFontOfSize:12]} forState:UIControlStateNormal];
        
        item.image = [item.image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        item.imageInsets = UIEdgeInsetsMake(4, 0, -4, 0);
    }
    
    
}





- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    
    for(UIViewController * ViewController in tabBarController.viewControllers)
    {

        [ViewController.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],
                                                            NSFontAttributeName:[UIFont systemFontOfSize:12]} forState:UIControlStateNormal];
    }
    
    [viewController.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor yellowColor],
                                                        NSFontAttributeName:[UIFont systemFontOfSize:12]} forState:UIControlStateNormal];
}





- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}






@end
