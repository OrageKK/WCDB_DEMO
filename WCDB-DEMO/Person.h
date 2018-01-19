//
//  Person.h
//  WCDB-DEMO
//
//  Created by 黄坤 on 2018/1/18.
//  Copyright © 2018年 黄坤. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Person;
@interface PersonManager : NSObject
+ (instancetype)shareInstance;
/// 获取数据库路径
+ (NSString *)wcdbFilePath;
/// 创建数据库的操作
- (BOOL)creatDatabase;

- (BOOL)insertData:(Person *)person;

- (BOOL)insertDatas:(NSArray<Person *> *)person;

- (BOOL)deleteDataWithId:(NSInteger)studentId;

- (BOOL)deleteAllData;

- (BOOL)updateData:(NSString *)content byId:(NSInteger)studentId;
- (BOOL)updateData:(Person *)person;
- (NSArray<Person *> *)getAllData;
- (NSArray<Person *> *)getData:(NSInteger)studentId;
- (NSArray<Person *> *)seletePersonOrderBy;
@end


@interface Person:NSObject

@property (nonatomic,assign) NSInteger localID;

@property (nonatomic,assign) NSInteger studentId;
@property (nonatomic,copy) NSString * name;
@property (nonatomic,assign) NSInteger age;
/*
	在这里创建一个Person类，然后在这个类中声明我们需要的属性
	
	将一个已有的OC类进行QRM绑定的过程
	1、定义该类遵守WCTTableCoding协议，可以在类声明上定义，也可以通过文件模版在category内定义。
	
	这里推荐大家使用第二种，通过文件模板在category内定义，为什么要这样做，就是为了隔离Objective-C++代码
	WCDB基于WINQ，引入了Objective-C++代码，所以对于引入了WCDB的源文件，都需要把后缀.m改为.mm，为减少影响范围，可以通过Objective-C的category特性将其隔离，达到只在model层使用Objective-C++编译，而不影响Controller和View。这一点在
	Wiki中是有提到的，
	
	这样做的好处是不知道大家都有没有理解，这么说，要是你通过第一种方法，不通过category定义，而是选择了在类声明中写，这样的话Message.h 中就需要有宏WCDB_PROPERTY，这样你就在Message.h使用了WCDB的代码，当你把Message.h在其他Controller/View中引用的时候，那相应的Controller/View的.m就需要修改成.mm 。造成不必要的工作，但你用第二种方法写的时候，你就发现在Message.h中是没有任何的关于WCDB的代码的，后面你引用也不需要再去修改！希望大家理解这里
	
	2、使用WCDB_PROPERTY宏在头文件声明需要绑定到数据库表的字段（也就是把你的表里面需要的字段在这里用这宏声明一次）
	3、使用WCDB_IMPLEMENTATIO宏在类文件定义绑定到数据库表的类（把这个类绑定到数据库的表，你会在下面创建数据库的时候创建相应的表，表会和类绑定）
	4、使用WCDB_SYNTHESIZE宏在类文件定义绑定到数据库表的类（第二步声明了表需要的字段，第三步绑定了表中的类，第四步就等于把表和字段绑定）
	
	
	*/
@end

