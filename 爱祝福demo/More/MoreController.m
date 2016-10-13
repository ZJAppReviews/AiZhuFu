
#import "MoreController.h"

#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height

@implementation MoreController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"更多";
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.dataSource = @[@"意见反馈",@"版本更新",@"关于"];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, WIDTH, HEIGHT-64-49) style:UITableViewStyleGrouped];
    self.tableView.scrollEnabled = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.view addSubview:self.tableView];
}

#pragma UITableViewDataSource, UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"CELL"];
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CELL"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.textLabel.text = [self.dataSource objectAtIndex:indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 0)
    {
        FeedbackController *feedbackController = [[FeedbackController alloc]init];
        [self.navigationController pushViewController:feedbackController animated:YES];
    }
    else if(indexPath.row == 1)
    {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.apple.com/cn/itunes/charts/"]];
    }
    else if(indexPath.row == 2)
    {
        AboutController *aboutController = [[AboutController alloc]init];
        [self.navigationController pushViewController:aboutController animated:YES];
    }
}

#pragma mark







- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


@end
