
#import "HomeCell.h"

#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height

@implementation HomeCell

- (void)setCellView:(HomeModel *)model
{
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(WIDTH*0.03, 5, 40, 40)];
    imageView.layer.cornerRadius = 10;
    [imageView sd_setImageWithURL:[NSURL URLWithString:model.icon_small]];
    [self.contentView addSubview:imageView];
    
    UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(WIDTH*0.16, 10, 270, 29)];
    lab.text = model.name;
    [self.contentView addSubview:lab];
}

@end
