
#import "DatabaseManager.h"

@implementation DatabaseManager

- (id)init
{
    if(self = [super init])
    {
        NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES) firstObject];
        path = [path stringByAppendingPathComponent:@"DB.sqlite"];
        self.database = [FMDatabase databaseWithPath:path];
    }
    return self;
}

- (BOOL)insertWithName:(NSString *)name Id:(NSString *)iid
{
    BOOL isInsertSuccess = nil;
    
    if([self.database open])
    {
        isInsertSuccess = [self.database executeUpdate:@"insert into collection(id,name)values(?,?)",iid,name];
    }
    [self.database close];
    
    return isInsertSuccess;
}

- (BOOL)deleteWithId:(NSString *)iid
{
    BOOL isDeleteSuccess = nil;
    
    if([self.database open])
    {
        isDeleteSuccess = [self.database executeUpdate:@"delete from collection where id = ?",iid];
    }
    [self.database close];
    
    return isDeleteSuccess;
}


- (NSMutableArray *)selectAll
{
    NSMutableArray *array = [[NSMutableArray alloc]init];

    if([self.database open])
    {
        FMResultSet *resultSet = [self.database executeQuery:@"select * from collection"];
        while([resultSet next])
        {
            NSString *iid = [resultSet stringForColumn:@"id"];
            NSString *name = [resultSet stringForColumn:@"name"];
            NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:name, iid, nil];
            [array addObject:dic];
        }
    }
    [self.database close];
    
    return array;
}


@end
