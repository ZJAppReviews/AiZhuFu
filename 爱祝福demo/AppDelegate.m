
#import "AppDelegate.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [self copyDatabaseToDocument];
    [self createShare];
    
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    BOOL isFirst = [userDefaults objectForKey:@"isFirst"];
    
    if(!isFirst)
    {
        WelcomeController *welcomeController = [[WelcomeController alloc]init];
        self.window.rootViewController = welcomeController;
    }
    else
    {
        TabBarController *tabBarController = [[TabBarController alloc]init];
        self.window.rootViewController = tabBarController;
    }
    
    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
    [self.window makeKeyAndVisible];
    
    return YES;
}


- (void)createShare
{
    //设置友盟社会化组件appkey
    [UMSocialData setAppKey:@"56e75d51e0f55a612a00063e"];
    
    //打开调试log的开关
    [UMSocialData openLog:YES];
    
    //如果你要支持不同的屏幕方向，需要这样设置，否则在iPhone只支持一个竖屏方向
    [UMSocialConfig setSupportedInterfaceOrientations:UIInterfaceOrientationMaskAll];
}




- (void)copyDatabaseToDocument
{
    NSString *sourcePath =[[NSBundle mainBundle] pathForResource:@"DB" ofType:@"sqlite"];
    NSString *targetPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES) firstObject];
    targetPath =[targetPath stringByAppendingPathComponent:@"DB.sqlite"];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if(![fileManager fileExistsAtPath:targetPath])
    {
        NSLog(@"db is not existed, ready to copy.");
        if([fileManager copyItemAtPath:sourcePath toPath:targetPath error:nil])
        {
            NSLog(@"copy success");
        }
        else
        {
            NSLog(@"copy fail");
        }
    }
    else
    {
        NSLog(@"copy fail, db is existed.");
    }
}


- (void)applicationWillResignActive:(UIApplication *)application
{

}

- (void)applicationDidEnterBackground:(UIApplication *)application
{

}

- (void)applicationWillEnterForeground:(UIApplication *)application
{

}

- (void)applicationDidBecomeActive:(UIApplication *)application
{

}

- (void)applicationWillTerminate:(UIApplication *)application
{

}

@end
