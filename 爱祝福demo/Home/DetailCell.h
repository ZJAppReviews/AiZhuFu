

#import <UIKit/UIKit.h>
#import "DetailModel.h"
#import "DatabaseManager.h"
#import "UMSocial.h"

@interface DetailCell : UITableViewCell


@property (strong, nonatomic) NSString *iid;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) UIButton *collectionBT;
@property (nonatomic, strong) UIButton *recommendBT;


- (void)setCellWithModel:(DetailModel *)model;

@end
