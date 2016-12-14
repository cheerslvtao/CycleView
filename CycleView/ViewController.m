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
        UIImage * image = [UIImage imageNamed:str];
        [arr addObject:image];
    }
    
    //轮播图
    LTCycleView * cycleView= [[LTCycleView alloc]initWithFrame:[UIScreen mainScreen].bounds duration:3 sourceImages:arr];
    cycleView.delegate =self;
    
    cycleView.pageControlTintColor = [UIColor blackColor];
    cycleView.currentPageControlTintColor = [UIColor whiteColor];
    cycleView.diameter = 10;
    [self.view addSubview:cycleView];
  
    
    
    NSMutableArray * arr1 = [[NSMutableArray alloc]init];
    for (int i = 0; i<4; i++) {
        NSString * str=  [NSString stringWithFormat:@"%d.jpg",i+1];
        UIImage * image = [UIImage imageNamed:str];
        [arr1 addObject:image];
    }
    //更新数据
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [cycleView updateImages:arr1];
    });
    
}

-(void)updateImages{
    
}

-(void)cycleViewDidSeleted:(NSInteger)pageIndex{
    NSLog(@"%@",[NSString stringWithFormat:@"选中了第 %ld 张照片",pageIndex+1]);
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
