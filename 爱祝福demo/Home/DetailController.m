
#import "DetailController.h"

#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height

@implementation DetailController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"详情";
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    
    self.dataSource = [[NSMutableArray alloc]init];
    self.loadingView = [[LoadingView alloc]init];
    [self.loadingView.button addTarget:self action:@selector(loadmode) forControlEvents:UIControlEventTouchUpInside];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,64,WIDTH,HEIGHT-64-49) style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    
    self.refreshHeader = [[YiRefreshHeader alloc]init];
    [self createRefresh];
    

    [self loadDataWithSubjectid:self.subjectid minId:@"0"];

}


- (void)createRefresh
{
    self.refreshHeader.scrollView = self.tableView;
    [self.refreshHeader header];
    typeof(self.refreshHeader) __weak weakRefreshHeader = self.refreshHeader;
    self.refreshHeader.beginRefreshingBlock=^()
    {
        dispatch_async(dispatch_get_global_queue(0, 0), ^
       {
           sleep(2);
           dispatch_async(dispatch_get_main_queue(), ^
           {
              typeof(weakRefreshHeader) __strong strongRefreshHeader = weakRefreshHeader;
              [self loadDataWithSubjectid:self.subjectid minId:@"0"];
              [strongRefreshHeader endRefreshing];
           });
           
       });
    };
}


- (void)loadmode
{
    [self.loadingView start];
    [self loadDataWithSubjectid:self.subjectid minId:self.minid];
}



- (void)loadDataWithSubjectid:(NSString *)subjectid minId:(NSString *)minid
{
    NSString *string = [NSString stringWithFormat:@"http://211.155.224.10:8087/t/findSubjectContentList.jhtml?subjectId=%@&minId=%@",subjectid,minid];
    NSURL *url = [NSURL URLWithString:string];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue currentQueue]
    completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError)
    {
        
        GDataXMLDocument *document = [[GDataXMLDocument alloc]initWithData:data options:0 error:nil];
        GDataXMLElement *rootElement = document.rootElement;
        
        if([minid isEqualToString:@"0"])
        {
            
            if(self.dataSource.count != 0)
            {
                [self.dataSource removeAllObjects];
            }
            
            for(GDataXMLElement *element in rootElement.children)
            {
                if([element.name isEqualToString:@"bless"])
                {
                    DetailModel *model = [[DetailModel alloc]init];
                    model.content = [[element.children objectAtIndex:3] stringValue];
                    model.iid = [[element.children objectAtIndex:2] stringValue];
                    [self.dataSource addObject:model];
                }
            }
            
            self.minid = [[self.dataSource lastObject] iid];
            self.tableView.tableFooterView = self.loadingView;
            [self.tableView reloadData];
            
        }
        
        else
        {
            
            NSMutableArray * indexPaths = [[NSMutableArray alloc]init];
            
            for(GDataXMLElement *element in rootElement.children)
            {
                if([element.name isEqualToString:@"bless"])
                {
                    
                    NSIndexPath * indexPath = [NSIndexPath indexPathForRow:self.dataSource.count inSection:0];
                    [indexPaths addObject:indexPath];
                    DetailModel *model = [[DetailModel alloc]init];
                    model.content = [[element.children objectAtIndex:3] stringValue];
                    model.iid = [[element.children objectAtIndex:2] stringValue];
                    [self.dataSource addObject:model];

                }
            }
            
            [self.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationFade];
            self.minid = [[self.dataSource lastObject] iid];
            [self.tableView reloadData];
            [self.loadingView stop];
            
        }

    }];
    
}





#pragma UITableViewDataSource, UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CELL"];
    
    if(cell==nil)
    {
        cell = [[DetailCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CELL"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    for(UIView *view in cell.contentView.subviews)
    {
        [view removeFromSuperview];
    }
    
    [cell setCellWithModel:[self.dataSource objectAtIndex:indexPath.row]];
    
    cell.collectionBT.tag = indexPath.row;
    
    [cell.collectionBT addTarget:self action:@selector(collection:) forControlEvents:UIControlEventTouchUpInside];
    
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


- (void)collection:(id)sender
{
    DatabaseManager *manager = [[DatabaseManager alloc]init];
    DetailModel *model = [self.dataSource objectAtIndex:[sender tag]];
    [manager insertWithName:model.content Id:model.iid];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}




@end





