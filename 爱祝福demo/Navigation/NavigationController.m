
#import "NavigationController.h"

@implementation NavigationController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationBar.barTintColor = [UIColor colorWithRed:254/255.0 green:61/255.0 blue:80/255.0 alpha:1];
    self.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationBar.titleTextAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:22],
                                               NSForegroundColorAttributeName:[UIColor whiteColor]};
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
