//
//  LTPageControl.m
//  CycleView
//
//  Created by 吕涛 on 16/9/22.
//  Copyright © 2016年 轮播图. All rights reserved.
//

#import "LTPageControl.h"

@implementation LTPageControl


-(instancetype)initWithFrame:(CGRect)frame tintColor:(UIColor *)tintColor currentColor:(UIColor *)currentColor{
    if (self = [super initWithFrame:frame]) {
        
        if (tintColor == nil) {
            self.tintColor = [UIColor grayColor];
        }else{
            self.tintColor = tintColor;
        }
        
        if (currentColor == nil) {
            self.currentColor = [UIColor whiteColor];
        }else{
            self.currentColor = currentColor;
        }
        
    }
    return self;
}



/**
 重写这个方法   当设置pageControl的currentPage的时候会调动这个方法
 */
-(void)setCurrentPage:(NSInteger)currentPage{
    [super setCurrentPage:currentPage];
    [self updateDots];
}


-(void)updateDots{
    
    for (UIView * dot in self.subviews) {
        CGSize size;
        if (self.diameter == 0) {
            self.diameter = 8.f;
        }else if(self.diameter > 15.f){
            self.diameter = 15.f;
        }
        
        dot.layer.masksToBounds = YES;
        dot.layer.cornerRadius  = self.diameter/2;
        
        size.height = self.diameter;
        size.width  = self.diameter;
        
        [dot setFrame:CGRectMake(dot.frame.origin.x, dot.frame.origin.y, size.width, size.height)];
        
        if ( self.currentPage == [self.subviews indexOfObject:dot]) {
            dot.backgroundColor = self.currentColor;
        }else{
            dot.backgroundColor = self.tintColor;
        }
    }
    
    
    
}




@end
