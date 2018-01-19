//
//  ViewController.m
//  WCDB-DEMO
//
//  Created by 黄坤 on 2018/1/18.
//  Copyright © 2018年 黄坤. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *addBtn;
@property (weak, nonatomic) IBOutlet UIButton *deleteBtn;
@property (weak, nonatomic) IBOutlet UIButton *updateBtn;
@property (weak, nonatomic) IBOutlet UIButton *selectBtn;
@property (weak, nonatomic) IBOutlet UIButton *creatBtn;
@property (nonatomic,assign) NSInteger num;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [_creatBtn addTarget:self action:@selector(creatButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    [_addBtn  addTarget:self action:@selector(insertButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    [_deleteBtn addTarget:self action:@selector(deleteButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    [_selectBtn addTarget:self action:@selector(seleteButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    
    [_updateBtn addTarget:self action:@selector(updateButtonClick) forControlEvents:UIControlEventTouchUpInside];
    self.num = 0;
}
// 创建数据库
-(void)creatButtonClick{
    
    BOOL  result = [[PersonManager shareInstance] creatDatabase];
    NSLog(@"%@",((result == YES)?@"创建数据库成功":@"创建数据库失败"));
    
}


// 插入数据
-(void)insertButtonClick{
    int x = arc4random() % 100;
    self.num++;
    Person *pp = [[Person alloc]init];
    pp.localID = self.num;
    pp.studentId = 9200+self.num;
    pp.name = [NSString stringWithFormat:@"Hello WCDB%lu",self.num];
    pp.age = x;
    BOOL  result = [[PersonManager shareInstance] insertData:pp];
    NSLog(@"%@",((result == YES)?@"数据插入成功":@"数据插入失败"));
    
}


// 删除
-(void)deleteButtonClick
{

    BOOL  result = [[PersonManager shareInstance]deleteDataWithId:9202];
    NSLog(@"%@",((result == YES)?@"删除9202数据成功":@"删除数据失败"));
    
}


// 查找数据
-(void)seleteButtonClick{
    
    NSArray * array = [[PersonManager shareInstance]seletePersonOrderBy];
    NSLog(@"%@",array);
    
}


// 更新数据
-(void)updateButtonClick{
    
    BOOL  result = [[PersonManager shareInstance]updateData:@"改名了" byId:9203];
    NSLog(@"%@",((result == YES)?@"修改9203数据成功":@"修改数据失败"));
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
