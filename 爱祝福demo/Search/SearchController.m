
#import "SearchController.h"

@implementation SearchController

#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"搜索";
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.dataSource = [[NSMutableArray alloc]init];
    
    self.loadingView = [[LoadingView alloc]init];
    [self.loadingView.button addTarget:self action:@selector(loadMore) forControlEvents:UIControlEventTouchUpInside];
    
    isLoadMore = NO;
    
    self.searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 64, WIDTH, 50)];
    self.searchBar.barTintColor = [UIColor colorWithRed:254/255.0 green:146/255.0 blue:149/255.0 alpha:1];
    self.searchBar.tintColor = [UIColor whiteColor];
    self.searchBar.delegate = self;
    self.searchBar.showsCancelButton = YES;
    self.searchBar.placeholder = @"爱生活，爱祝福。";
    [self.view addSubview:self.searchBar];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64+50, WIDTH, HEIGHT-64-49-50) style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];

}



- (void)loadMore
{
    [self.loadingView start];
    isLoadMore = YES;
    [self loadDataWithKeyword:self.searchBar.text MinId:self.minid];
}



- (void)loadDataWithKeyword:(NSString *)keyWord MinId:(NSString *)minid;
{
    NSString *path = [NSString stringWithFormat:@"http://211.155.224.10:8087/t/findSearchList.jhtml?key=%@&minId=%@&flag=0",keyWord,minid];
    path = [path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url = [NSURL URLWithString:path];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue currentQueue]
     completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError)
    {
        
        if(self.dataSource.count != 0 && isLoadMore == NO)
        {
            [self.dataSource removeAllObjects];
        }
        
        GDataXMLDocument *document = [[GDataXMLDocument alloc]initWithData:data options:0 error:nil];
        GDataXMLElement *rootElement = document.rootElement;
        
        NSMutableArray *indexPaths = [[NSMutableArray alloc]init];
        
        for(GDataXMLElement *element in rootElement.children)
        {
            
            if([element.name isEqualToString:@"bless"])
            {
                
                if(isLoadMore == YES)
                {
                    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.dataSource.count inSection:0];
                    [indexPaths addObject:indexPath];
                }
                SearchModel *model = [[SearchModel alloc]init];
                model.iid = [[element.children objectAtIndex:2] stringValue];
                model.content = [[element.children objectAtIndex:3] stringValue];
                [self.dataSource addObject:model];
                
            }
        }
        
        if(isLoadMore==YES)
        {
            [self.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationFade];
            [self.loadingView stop];
        }
        
        if(self.dataSource.count != 0)
        {
            self.tableView.tableFooterView = self.loadingView;
        }
        else
        {
            self.tableView.tableFooterView = nil;
        }
        
        self.minid = [[self.dataSource lastObject]iid];
        
        [self.tableView reloadData];
        
    }];
}




#pragma UISearchBarDelegate
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    isLoadMore = NO;
    [self loadDataWithKeyword:searchBar.text MinId:@"0"];
    [searchBar resignFirstResponder];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    isLoadMore = NO;
    searchBar.text = nil;
    [searchBar resignFirstResponder];
    [self.dataSource removeAllObjects];
    self.tableView.tableFooterView = nil;
    [self.tableView reloadData];
}


#pragma mark





#pragma UITableViewDataSource, UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SearchCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CELL"];
    if(cell==nil)
    {
        cell = [[SearchCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CELL"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    for(UIView *view in cell.contentView.subviews)
    {
        [view removeFromSuperview];
    }
    [cell setCellWithModel:[self.dataSource objectAtIndex:indexPath.row]];
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *string = [[self.dataSource objectAtIndex:indexPath.row] content];
    
    CGRect rect = [string boundingRectWithSize:CGSizeMake(WIDTH-WIDTH*0.04,NSMaximumStringLength)
                                       options:NSStringDrawingUsesLineFragmentOrigin
                                    attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:19]}
                                       context:nil];
    
    return rect.size.height + 70;
}
#pragma Mark








- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


@end
