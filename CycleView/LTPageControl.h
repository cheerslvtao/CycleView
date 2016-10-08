//
//  LTPageControl.h
//  CycleView
//
//  Created by 吕涛 on 16/9/22.
//  Copyright © 2016年 轮播图. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LTPageControl : UIPageControl


/**
 直径
 */
@property (nonatomic) CGFloat diameter;



/**
 设置镂空颜色
 */
@property (nonatomic,strong) UIColor * tintColor;



/**
 设置当前page颜色
 */
@property (nonatomic,strong) UIColor * currentColor;



/**
 初始化

 @param frame        frame
 @param tintColor    tintColor  默认灰色
 @param currentColor currentColor 默认白色
 */
-(instancetype)initWithFrame:(CGRect)frame tintColor:(UIColor *)tintColor currentColor:(UIColor *)currentColor;


@end
