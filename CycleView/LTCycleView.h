//
//  LTCycleView.h
//  CycleView
//
//  Created by 吕涛 on 16/9/22.
//  Copyright © 2016年 轮播图. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LTCycleViewDelegate <NSObject>

@optional
/**
 点击当前的imageView  返回点击的第几张图片
 */
-(void)cycleViewDidSeleted:(NSInteger)pageIndex;


@end

@interface LTCycleView : UIView

//////////////////////////////////////////////////////////////////////////////////////
/**
    pagecontrol 没选中颜色
 */
@property (nonatomic,strong) UIColor * pageControlTintColor;


/**
    pageControl 选中颜色
 */
@property (nonatomic,strong) UIColor * currentPageControlTintColor;

/**
    原点的直径
 */
@property (nonatomic) CGFloat diameter;



//////////////////////////////////////////////////////////////////////////////////////

/**
    代理
 */
@property (nonatomic,weak) id <LTCycleViewDelegate> delegate;


/**
    停止播放
 */
-(void)lt_stopTimer;


/**
    开始播放
 */
-(void)lt_startTimer;


/**
 初始化View

 @param frame    frame
 @param duration 轮播图的时间间隔
 @param images   存储图片的数组

 @return self
 */
-(instancetype)initWithFrame:(CGRect)frame duration:(CGFloat)duration sourceImages:(NSArray <UIImage *>*)images;

/**
 更新轮播图数据
 */
-(void)updateImages:(NSArray *)imageArr;

@end
