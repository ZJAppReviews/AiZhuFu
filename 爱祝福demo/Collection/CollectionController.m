
#import "CollectionController.h"

#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height

@implementation CollectionController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"收藏";
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;

    self.dataSource = [[NSMutableArray alloc]init];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, WIDTH, HEIGHT-64-49) style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self createDataSource];
}

- (void)createDataSource
{
    DatabaseManager *manager = [[DatabaseManager alloc]init];
    if(self.dataSource.count != 0)
    {
        [self.dataSource removeAllObjects];
    }
    NSMutableArray *array = [manager selectAll];
    
    for(NSDictionary *dic in array)
    {
        CollectionModel *model = [[CollectionModel alloc]init];
        model.iid = [dic allKeys].firstObject;
        model.name = [dic allValues].firstObject;
        [self.dataSource addObject:model];
    }
    [self.tableView reloadData];
}




#pragma UITableViewDelegate, UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CollectionCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CELL"];
    
    if(cell==nil)
    {
        cell = [[CollectionCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CELL"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    for(UIView *view in cell.contentView.subviews)
    {
        [view removeFromSuperview];
    }
    
    [cell setCellWithModel:[self.dataSource objectAtIndex:indexPath.row]];
    
    cell.deleteBT.tag = indexPath.row;
    [cell.deleteBT addTarget:self action:@selector(deletee:) forControlEvents:UIControlEventTouchUpInside];
    
    cell.shareBT.tag = indexPath.row;
    [cell.shareBT addTarget:self action:@selector(share:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *string = [[self.dataSource objectAtIndex:indexPath.row] name];
    
    CGRect rect = [string boundingRectWithSize:CGSizeMake(WIDTH-WIDTH*0.04,NSMaximumStringLength)
                                       options:NSStringDrawingUsesLineFragmentOrigin
                                    attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:19]}
                                       context:nil];
    
    return rect.size.height + 70;
}
#pragma Mark


- (void)deletee:(id)sender
{
    DatabaseManager *manager = [[DatabaseManager alloc]init];
    CollectionModel *model = [self.dataSource objectAtIndex:[sender tag]];
    [manager deleteWithId:model.iid];
    [self createDataSource];
}



- (void)share:(id)sender
{
    CollectionModel *model = [self.dataSource objectAtIndex:[sender tag]];
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:@"56e75d51e0f55a612a00063e"
                                      shareText:model.name
                                     shareImage:nil
                                shareToSnsNames:@[UMShareToSina]
                                       delegate:nil];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
