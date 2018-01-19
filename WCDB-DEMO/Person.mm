//
//  Person.m
//  WCDB-DEMO
//
//  Created by 黄坤 on 2018/1/18.
//  Copyright © 2018年 黄坤. All rights reserved.
//

#import "Person.h"
#import "Person+WCTTableCoding.h"
@implementation Person
WCDB_IMPLEMENTATION(Person)
WCDB_SYNTHESIZE(Person, localID)
WCDB_SYNTHESIZE(Person, studentId)
WCDB_SYNTHESIZE(Person, name)
WCDB_SYNTHESIZE(Person, age)

WCDB_PRIMARY_AUTO_INCREMENT(Person, localID)
@end

@interface PersonManager()
{
    WCTDatabase * database;
}

@end
#define TABLE_WCDB_NAME @"Person"
@implementation PersonManager
+ (instancetype)shareInstance {
    static PersonManager * instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        instance = [[PersonManager alloc]init];
        
    });
    
    return instance;
}
+ (NSString *)wcdbFilePath{
    NSString *docDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSString *dbFilePath = [docDir stringByAppendingPathComponent:@"Person.db"];
    return dbFilePath;
}
- (BOOL)creatDatabase {
    
    database = [[WCTDatabase alloc] initWithPath:[PersonManager wcdbFilePath]];
    //测试数据库是否能够打开
    if ([database canOpen]) {
        // WCDB大量使用延迟初始化（Lazy initialization）的方式管理对象，因此SQLite连接会在第一次被访问时被打开。开发者不需要手动打开数据库。
        // 先判断表是不是已经存在
        if ([database isOpened]) {
            if ([database isTableExists:TABLE_WCDB_NAME]) {
                
                NSLog(@"表已经存在");
                return NO;
                
            }else {
                return [database createTableAndIndexesOfName:TABLE_WCDB_NAME withClass:Person.class];
            }
        }
    }
    return NO;
}
#pragma mark - 增
-(BOOL)insertData:(Person *)person {
    if (person == nil) {
        return NO;
    }
    if (database == nil) {
        [self creatDatabase];
    }
    return [database insertObject:person into:TABLE_WCDB_NAME];
}
- (BOOL)insertDatas:(NSArray<Person *> *)person {
    if (database == nil) {
        [self creatDatabase];
    }
    return [database insertObjects:person into:TABLE_WCDB_NAME];
}
-(BOOL)insertPerson{
    
    //插入
    Person *man = [[Person alloc] init];
    man.isAutoIncrement = YES;
    man.name = @"Hello, WCDB!";
    man.age = 12;
    return  [database insertObject:man into:TABLE_WCDB_NAME];
}
// WCTDatabase 事务操作，利用WCTTransaction
-(BOOL)insertPersonWithTransaction{
    
    
    BOOL ret = [database beginTransaction];
    ret = [self insertPerson];
    if (ret) {
        
        [database commitTransaction];
        
    }else
        
        [database rollbackTransaction];
    
    return ret;
}
// 另一种事务处理方法Block
-(BOOL)insertPersonWithBlock{
    
    BOOL commited  =  [database runTransaction:^BOOL{
        
        BOOL result = [self insertPerson];
        if (result) {
            
            return YES;
            
        }else
            return NO;
        
    } event:^(WCTTransactionEvent event) {
        
        NSLog(@"Event %d", event);
    }];
    return commited;
}
#pragma mark - 删
- (BOOL)deleteDataWithId:(NSInteger)studentId {
    if (database == nil) {
        [self creatDatabase];
    }
    return [database deleteObjectsFromTable:TABLE_WCDB_NAME where:Person.studentId == studentId];
}
-(BOOL)deleteAllData {
    if (database == nil) {
        [self creatDatabase];
    }
    return [database deleteAllObjectsFromTable:TABLE_WCDB_NAME];
}
#pragma mark - 改
-(BOOL)updateData:(NSString *)content byId:(NSInteger)studentId {
    if (database == nil) {
        [self creatDatabase];
    }
    Person *person = [[Person alloc] init];
    person.name = content;
    return [database updateRowsInTable:TABLE_WCDB_NAME onProperties:Person.name withObject:person where:Person.studentId == studentId];
}
- (BOOL)updateData:(Person *)person
{
    if (database == nil) {
        [self creatDatabase];
    }
    return [database updateRowsInTable:TABLE_WCDB_NAME onProperties:Person.name withObject:person where:Person.studentId == person.studentId];
}

#pragma mark - 查
- (NSArray<Person *> *)getAllData {
    if (database == nil) {
        [self creatDatabase];
    }
    return [database getAllObjectsOfClass:Person.class fromTable:TABLE_WCDB_NAME];
}
-(NSArray<Person *> *)getData:(NSInteger)studentId {
    if (database == nil) {
        [self creatDatabase];
    }
    return [database getObjectsOfClass:Person.class fromTable:TABLE_WCDB_NAME where:Person.studentId == studentId];
}
- (NSArray<Person *> *)seletePersonOrderBy {
    //SELECT * FROM message ORDER BY localID
    NSArray<Person *> * person = [database getObjectsOfClass:Person.class fromTable:TABLE_WCDB_NAME orderBy:Person.localID.order()];
    
    return person;
}
@end
