
#import "SearchCell.h"

#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height

@implementation SearchCell

- (void)setCellWithModel:(SearchModel *)model
{
    self.iid = model.iid;
    self.content = model.content;
    
    NSString *string = model.content;
    CGRect rect = [string boundingRectWithSize:CGSizeMake(WIDTH-20,NSMaximumStringLength)
                                       options:NSStringDrawingUsesLineFragmentOrigin
                                    attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]}
                                       context:nil];
    
    CGRect autoImageRect = CGRectMake(10, 10, WIDTH-20, rect.size.height+10);
    CGRect autoLabRect = CGRectMake(17, 15, WIDTH-24, rect.size.height);
    
    UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"listitem_bg.png"]];
    imageView.frame = autoImageRect;
    [self.contentView addSubview:imageView];
    
    UILabel *lab = [[UILabel alloc]init];
    lab.frame = autoLabRect;
    lab.text = model.content;
    lab.font = [UIFont systemFontOfSize:17];
    lab.numberOfLines = 0;
    lab.lineBreakMode = NSLineBreakByWordWrapping;
    [self.contentView addSubview:lab];
    
    UIButton *collectionBT = [UIButton buttonWithType:UIButtonTypeSystem];
    collectionBT.frame = CGRectMake(WIDTH-100, 20+imageView.frame.size.height, 30, 30);
    [collectionBT setBackgroundImage:[UIImage imageNamed:@"Collection.png"] forState:UIControlStateNormal];
    [collectionBT addTarget:self action:@selector(collection) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:collectionBT];
    
    UIButton *shareBT = [UIButton buttonWithType:UIButtonTypeSystem];
    shareBT.frame = CGRectMake(WIDTH-60, 20+imageView.frame.size.height, 30, 30);
    [shareBT setBackgroundImage:[UIImage imageNamed:@"share.png"] forState:UIControlStateNormal];
    [self.contentView addSubview:shareBT];
    
}


- (void)collection
{
    DatabaseManager *manager = [[DatabaseManager alloc]init];
    [manager insertWithName:self.content Id:self.iid];
}

@end


