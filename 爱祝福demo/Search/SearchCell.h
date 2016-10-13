
#import <UIKit/UIKit.h>
#import "SearchModel.h"
#import "DatabaseManager.h"

@interface SearchCell : UITableViewCell

@property (nonatomic, strong) NSString *iid;
@property (nonatomic, strong) NSString *content;

- (void)setCellWithModel:(SearchModel *)model;

@end
