
#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
#import "UIButton+WebCache.h"
#import "UIImageView+WebCache.h"
#import "GDataXMLNode.h"
#import "HomeModel.h"
#import "HomeCell.h"
#import "DetailController.h"
#import "YiRefreshHeader.h"

@interface HomeController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) UIButton *leftButton;
@property (strong, nonatomic) UIButton *rightButton;

@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) NSMutableArray *imageArray;
@property (nonatomic, strong) YiRefreshHeader *refreshHeader;

@end
