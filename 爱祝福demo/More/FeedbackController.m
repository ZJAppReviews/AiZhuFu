
#import "FeedbackController.h"

#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height

@implementation FeedbackController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"意见反馈";
    self.automaticallyAdjustsScrollViewInsets = NO;

    
    UIImageView *ideaImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 75, WIDTH-20, 150)];
    ideaImageView.image = [UIImage imageNamed:@"idea.png"];
    [self.view addSubview:ideaImageView];
    
    self.textView = [[UITextView alloc]initWithFrame:CGRectMake(25, 90, WIDTH-50, 120)];
    [self.view addSubview:self.textView];
    
    UIImageView *telImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"tel.png"]];
    telImageView.frame = CGRectMake(10, 235, WIDTH-20, 35);
    [self.view addSubview:telImageView];
    
    self.textField = [[UITextField alloc]initWithFrame:CGRectMake(25, 241, WIDTH-50, 20)];
    self.textField.placeholder = @"请输入您的邮箱";
    [self.view addSubview:self.textField];
    
    UIBarButtonItem *postItem = [[UIBarButtonItem alloc]initWithTitle:@"提交" style:UIBarButtonItemStylePlain target:self action:@selector(post)];
    self.navigationItem.rightBarButtonItem = postItem;
    
}



- (void)post
{
    [self.textField resignFirstResponder];
    [self.textView resignFirstResponder];
    
    NSString *path = [NSString stringWithFormat:@"http://211.155.224.10:8087/t/adviceContent.jhtml?content=%@&tel=%@",self.textView.text,self.textField.text];
    path = [path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url = [NSURL URLWithString:path];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue currentQueue]
     completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError)
    {
        NSString *string = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"返回%@",string);
    }];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


@end
