

#import <UIKit/UIKit.h>
#import "CollectionCell.h"
#import "DatabaseManager.h"
#import "CollectionModel.h"
#import "UMSocial.h"

@interface CollectionController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *dataSource;

@end
