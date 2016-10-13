
#import <Foundation/Foundation.h>
#import "FMDB.h"

@interface DatabaseManager : NSObject

@property (nonatomic, strong) FMDatabase *database;

- (BOOL)insertWithName:(NSString *)name Id:(NSString *)iid;
- (BOOL)deleteWithId:(NSString *)iid;
- (NSMutableArray *)selectAll;

@end
