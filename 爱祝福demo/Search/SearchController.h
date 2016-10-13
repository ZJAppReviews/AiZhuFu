
#import <UIKit/UIKit.h>
#import "SearchCell.h"
#import "SearchModel.h"
#import "GDataXMLNode.h"
#import "LoadingView.h"

@interface SearchController : UIViewController <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>

{
    BOOL isLoadMore;
}


@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *dataSource;
@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, strong) LoadingView *loadingView;
@property (nonatomic, strong) NSString *minid;


@end
