//
//  ZSBaseModelViewController.m
//  ZSBaseModel
//
//  Created by zzsat on 05/22/2017.
//  Copyright (c) 2017 zzsat. All rights reserved.
//

#import "ZSBaseModelViewController.h"

#import "ZSBaseModel.h"


@interface ZSBaseModelViewController ()

@end

@implementation ZSBaseModelViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    ZSBaseModel *zb = [[ZSBaseModel alloc] init];
    zb.name = @"kael";
    zb.age = @"18";
    NSLog(@"11------------\n姓名:%@--年龄:%@--性别:%@",zb.name,zb.age,zb.sex);
    //    [zb zs_resetIvarValueWithDefaultString:@"哥们儿是空"];
    [ZSBaseModel zs_resetIvarValueWithObject:zb andDefaultString:@"逗比"];
    NSLog(@"22------------\n姓名:%@--年龄:%@--性别:%@",zb.name,zb.age,zb.sex);
    
    NSLog(@"修改之前的值:\n");
    [zb logDog];
   
    //替换方法
    [ZSBaseModel replaceMethodWithInstanceOfClass:[zb class] newSelector:@selector(logCat) oldSelector:@selector(logDog)];

    
    ZSBaseModel *zb2 = [[ZSBaseModel alloc] init];
    zb.name = @"kael";
    zb.age = @"18";
    NSLog(@"修改之后的值:\n");
    [zb2 logDog];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
