
#import <UIKit/UIKit.h>
#import "DetailModel.h"
#import "GDataXMLNode.h"
#import "DetailCell.h"
#import "LoadingView.h"
#import "YiRefreshHeader.h"

@interface DetailController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) NSString *subjectid;
@property (nonatomic, strong) NSString *minid;
@property (nonatomic, strong) LoadingView *loadingView;
@property (nonatomic, strong) YiRefreshHeader *refreshHeader;

@end



