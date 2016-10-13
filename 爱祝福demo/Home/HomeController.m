
#import "HomeController.h"

@implementation HomeController

#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"首页";
    self.automaticallyAdjustsScrollViewInsets = NO;

    self.dataSource = [[NSMutableArray alloc]init];
    self.imageArray = [[NSMutableArray alloc]init];
    
    self.leftButton = [UIButton buttonWithType:UIButtonTypeSystem];
    self.leftButton.frame = CGRectMake(10, 64+10, 170, 110);
    [self.leftButton setBackgroundImage:[UIImage imageNamed:@"content.png"] forState:UIControlStateNormal];
    [self.view addSubview:self.leftButton];
    
    self.rightButton = [UIButton buttonWithType:UIButtonTypeSystem];
    self.rightButton.frame = CGRectMake(10+170+15, 64+10, 170, 110);
    [self.rightButton setBackgroundImage:[UIImage imageNamed:@"content.png"] forState:UIControlStateNormal];
    [self.view addSubview:self.rightButton];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64+130, WIDTH, HEIGHT-64-49-130) style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    
    
    self.refreshHeader = [[YiRefreshHeader alloc]init];
    [self createRefreshHeader];
    
    [self loadData];
}


- (void)loadData
{
    
    NSURL *url = [NSURL URLWithString:@"http://211.155.224.10:8087/iphone/findSubjectList.jhtml?lastUpdateTime=0"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue currentQueue]
    completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError)
    {
        if(self.dataSource.count != 0)
        {
            [self.dataSource removeAllObjects];
        }
        
        GDataXMLDocument *document = [[GDataXMLDocument alloc]initWithData:data options:0 error:nil];
        GDataXMLElement *root = document.rootElement;
        for(GDataXMLElement *element in root.children)
        {
            if([element.name isEqualToString:@"subject"])
            {
                HomeModel *model = [[HomeModel alloc]init];
                
                model.name = [[element.children objectAtIndex:2] stringValue];
                model.iid = [[element.children objectAtIndex:1] stringValue];
                model.icon_big = [[element.children objectAtIndex:4] stringValue];
                model.icon_small = [[element.children objectAtIndex:3] stringValue];
                model.flag = [[element.children objectAtIndex:5] stringValue];
                
                if([model.flag isEqualToString:@"0"])
                {
                    [self.dataSource addObject:model];
                }
                else if([model.flag isEqualToString:@"1"])
                {
                    [self.imageArray addObject:model.icon_big];
                }
            }
        }
        
        [self.tableView reloadData];
        
        [self.leftButton sd_setBackgroundImageWithURL:[NSURL URLWithString:[self.imageArray firstObject]] forState:UIControlStateNormal];
        [self.rightButton sd_setBackgroundImageWithURL:[NSURL URLWithString:[self.imageArray firstObject]] forState:UIControlStateNormal];
        
    }];
    
}


- (void)createRefreshHeader
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
                [self loadData];
                [strongRefreshHeader endRefreshing];
            });

        });
    };
}




#pragma UITableViewDataSource, UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HomeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CELL"];
    
    if(cell==nil)
    {
        cell = [[HomeCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CELL"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    for(UIView *view in cell.contentView.subviews)
    {
        [view removeFromSuperview];
    }
    
    HomeModel *model = [self.dataSource objectAtIndex:indexPath.row];
    [cell setCellView:model];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DetailController *detailController = [[DetailController alloc]init];
    detailController.subjectid = [[self.dataSource objectAtIndex:indexPath.row] iid];
    [self.navigationController pushViewController:detailController animated:YES];
}

#pragma Mark




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


@end
