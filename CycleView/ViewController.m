//
//  ViewController.m
//  CycleView
//
//  Created by 吕涛 on 16/9/22.
//  Copyright © 2016年 轮播图. All rights reserved.
//

#import "ViewController.h"

#import "LTCycleView.h"
@interface ViewController ()<LTCycleViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    NSMutableArray * arr = [[NSMutableArray alloc]init];
    for (int i = 0; i<7; i++) {
        NSString * str=  [NSString stringWithFormat:@"%d.jpg",i+1];
        [arr addObject:str];
    }
    
    //轮播图
    LTCycleView * cycleView= [[LTCycleView alloc]initWithFrame:[UIScreen mainScreen].bounds duration:3 sourceImages:arr];
    cycleView.delegate =self;
    
    cycleView.pageControlTintColor = [UIColor blackColor];
    cycleView.currentPageControlTintColor = [UIColor whiteColor];
    cycleView.diameter = 10;
    
    [self.view addSubview:cycleView];
  
    
}


-(void)cycleViewDidSeleted:(NSInteger)pageIndex{
    NSLog(@"%@",[NSString stringWithFormat:@"选中了第 %ld 张照片",pageIndex+1]);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
