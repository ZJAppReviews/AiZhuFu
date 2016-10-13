
#import "CollectionCell.h"

#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height

@implementation CollectionCell

- (void)setCellWithModel:(CollectionModel *)model
{
    CGRect rect = [model.name boundingRectWithSize:CGSizeMake(WIDTH-20,NSMaximumStringLength)
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
    lab.text = model.name;
    lab.font = [UIFont systemFontOfSize:17];
    lab.numberOfLines = 0;
    lab.lineBreakMode = NSLineBreakByWordWrapping;
    [self.contentView addSubview:lab];
    
    self.deleteBT = [UIButton buttonWithType:UIButtonTypeSystem];
    self.deleteBT.frame = CGRectMake(WIDTH-100, 20+imageView.frame.size.height, 30, 30);
    [self.deleteBT setBackgroundImage:[UIImage imageNamed:@"unCollection.png"] forState:UIControlStateNormal];
    [self.contentView addSubview:self.deleteBT];
    
    self.shareBT = [UIButton buttonWithType:UIButtonTypeSystem];
    self.shareBT.frame = CGRectMake(WIDTH-60, 20+imageView.frame.size.height, 30, 30);
    [self.shareBT setBackgroundImage:[UIImage imageNamed:@"share.png"] forState:UIControlStateNormal];
    [self.contentView addSubview:self.shareBT];
}


@end




