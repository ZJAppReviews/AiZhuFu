
#import "AboutController.h"

#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height

#define CONTENT @"	《爱祝福》是一款短信增强工具，用简短的文字，通过送祝福的方式，在节日、重要纪念日、生日、日常的时候，通过手机短信给父母、爱人、同学、朋友、客户送去一个简单的祝福，用爱温暖我们的亲情、爱情、友情。\n\
爱祝福功能亮点：\n\
1、内容海量、原创、时时更新：涵盖节日、日常、结婚、生子、表白、康复、校园、商务、整蛊等。\n\
2、软件完全免费，无暗扣：仅需支付流量费用即可。在WIFI环境下完全免费。爱祝福还支持离线使用。\n\
3、短信随时发：专题中的每条内容都可通过短信直接发送给亲朋好友。\n\
4、收藏搜索全都有：看到喜欢的内容，收藏后可以直接使用！通过搜索关键字可找到你需要内容，还有常用热门的关键字供你选择。"

@implementation AboutController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"关于";
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.textView = [[UITextView alloc]initWithFrame:CGRectMake(0, 65, WIDTH, HEIGHT)];
    self.textView.editable = NO;
    self.textView.font = [UIFont systemFontOfSize:18];
    self.textView.text = CONTENT;
    [self.view addSubview:self.textView];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


@end
