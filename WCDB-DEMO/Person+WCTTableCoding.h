//
//  Person+WCTTableCoding.h
//  WCDB-DEMO
//
//  Created by 黄坤 on 2018/1/19.
//  Copyright © 2018年 黄坤. All rights reserved.
//

#import "Person.h"
#import <WCDB/WCDB.h>
@interface Person (WCTTableCoding)<WCTTableCoding>
WCDB_PROPERTY(studentId)
WCDB_PROPERTY(name)
@end
