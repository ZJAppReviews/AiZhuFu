
#import <UIKit/UIKit.h>
#import "FeedbackController.h"
#import "AboutController.h"

@interface MoreController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSArray *dataSource;
@property (nonatomic, strong) UITableView *tableView;

@end
