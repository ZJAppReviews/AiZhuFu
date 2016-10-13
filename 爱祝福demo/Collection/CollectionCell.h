
#import <UIKit/UIKit.h>
#import "CollectionModel.h"
#import "DatabaseManager.h"

@interface CollectionCell : UITableViewCell

@property (nonatomic, strong) UIButton *deleteBT;
@property (nonatomic, strong) UIButton *shareBT;

- (void)setCellWithModel:(CollectionModel *)model;

@end
