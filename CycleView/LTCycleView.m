//
//  LTCycleView.m
//  CycleView
//
//  Created by 吕涛 on 16/9/22.
//  Copyright © 2016年 轮播图. All rights reserved.
//

#import "LTCycleView.h"
#import "LTPageControl.h"

@interface LTCycleView ()<UIScrollViewDelegate>
{
    CGFloat view_width;
    CGFloat view_height;
}
/**
 数据源
 */
@property (nonatomic,strong) NSArray    * dataSource;


/**
 图片轮播的间隔  duration 时间间隔
 */
@property (nonatomic,assign) CGFloat       duration;


/**
 定时器
 */
@property (nonatomic,strong) NSTimer     * timer;


/**
 左侧的imageView
 */
@property (nonatomic,strong) UIImageView * leftImageView;

/**
 当前页的imageView
 */
@property (nonatomic,strong) UIImageView * midImageView;

/**
 左侧的imageView
 */
@property (nonatomic,strong) UIImageView * rightImageView;


/**
 页面控制器
 */
@property (nonatomic,strong) LTPageControl * pageControler;


/**
  滚动视图
 */
@property (nonatomic,strong) UIScrollView  * mainScollView;


/**
 当前页
 */
@property (nonatomic,assign) NSInteger   currentPage;

@end

@implementation LTCycleView

-(instancetype)initWithFrame:(CGRect)frame duration:(CGFloat)duration sourceImages:(NSArray *)images{
    
    if (self = [super initWithFrame:frame]) {

        view_width = frame.size.width;
        view_height = frame.size.height;
        
        self.dataSource = [[NSArray alloc]initWithArray:images];
        self.duration = duration;
        self.currentPage = 0;
        [self addSubview:self.mainScollView];
        
        [self.mainScollView addSubview:self.leftImageView];
        [self.mainScollView addSubview:self.midImageView];
        [self.mainScollView addSubview:self.rightImageView];
        
        [self setPageControl];
        [self createTimer]; 
    }
    return self;
}


/**
 创建scollview
 */
-(UIScrollView *)mainScollView{
    if (!_mainScollView) {
        _mainScollView = [[UIScrollView alloc]initWithFrame:self.bounds];
        _mainScollView.pagingEnabled = YES;
        _mainScollView.contentSize = CGSizeMake(view_width * 3, view_height);
        _mainScollView.contentOffset = CGPointMake(view_width, 0);
        _mainScollView.delegate = self;
        _mainScollView.showsVerticalScrollIndicator = NO;
        _mainScollView.showsHorizontalScrollIndicator = NO;
    }
    return _mainScollView;
}


/**
 创建左侧imageView
 */
-(UIImageView *)leftImageView{
    if (!_leftImageView) {
        _leftImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, view_width, view_height)];
        _leftImageView.image = [UIImage imageNamed:[self.dataSource lastObject]];
    }
    return _leftImageView ;
}

/**
 创建中间imageView  显示在界面的imageView
 */
-(UIImageView *)midImageView{
    
    if (!_midImageView) {
        _midImageView = [[UIImageView alloc]initWithFrame:CGRectMake(view_width, 0, view_width, view_height)];
        _midImageView.image = [UIImage imageNamed:self.dataSource[0]];
        _midImageView.userInteractionEnabled = YES;
        
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapImageView:)];
        [_midImageView addGestureRecognizer:tap];
    }
    return _midImageView;
}


/**
 创建右侧imageView
 */
-(UIImageView *)rightImageView{
    if (!_rightImageView) {
        _rightImageView = [[UIImageView alloc]initWithFrame:CGRectMake(view_width*2, 0, view_width, view_height)];
        _rightImageView.image = [UIImage imageNamed:self.dataSource[1]];
    }
    return _rightImageView;
}


/**
 点击 显示图片 事件
 */
-(void)tapImageView:(UITapGestureRecognizer *)tap
{
    if (_delegate && [_delegate respondsToSelector:@selector(cycleViewDidSeleted:)]) {
        [_delegate cycleViewDidSeleted:self.currentPage];
    }
}


/**
 创建定时器
 */
-(void)createTimer{
    
    if (!_timer){
        _timer = [NSTimer scheduledTimerWithTimeInterval:self.duration target:self selector:@selector(timerStar) userInfo:nil repeats:YES];
        
        [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    }
    
}

-(void)timerStar{
    
    [self.mainScollView setContentOffset: CGPointMake(view_width*2, 0) animated:YES];
}


/**
 scrollView偏移量改变时 切换数据
 */
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat x = scrollView.contentOffset.x;
    NSInteger count = self.dataSource.count;
    
    
    if (x == view_width*2) {
        //向左滚动
        self.currentPage++;
        if (self.currentPage == count) {
            
            [self setLeftImageView:count-1 mid:0 right:1];
            self.currentPage = 0;
            
        }else if (self.currentPage == count - 1){
            
            [self setLeftImageView:count-2 mid:count-1 right:0];

        }else if (self.currentPage == 0){
            [self setLeftImageView:count-1 mid:0 right:1];
            
        }else{
            [self setLeftImageView:self.currentPage - 1 mid:self.currentPage  right:self.currentPage+1];
        }
         [self.mainScollView setContentOffset:CGPointMake(view_width, 0)];
        self.pageControler.currentPage = self.currentPage;

    }
    
    
    //向右滚动
    if (x == 0) {
       
        self.currentPage--;
        
        if (self.currentPage == -1) {
            
            [self setLeftImageView:count-2 mid:count-1 right:0];
            self.currentPage = count - 1 ;
            
        }else if (self.currentPage == 0){

            [self setLeftImageView:count-1 mid:0 right:1];
            
        }else if (self.currentPage == count-1){
            
            [self setLeftImageView:count-2 mid:count-1 right:0];
            
        }else{

            [self setLeftImageView:self.currentPage-1 mid:self.currentPage right:self.currentPage+1];
            
        }
        [self.mainScollView setContentOffset:CGPointMake(view_width, 0)];
        self.pageControler.currentPage = self.currentPage;

    }
    
    
}

-(void)setLeftImageView:(NSInteger)left mid:(NSInteger)mid right:(NSInteger)right{
    self.leftImageView.image  = [UIImage imageNamed:self.dataSource[left]];
    self.midImageView.image  = [UIImage imageNamed:self.dataSource[mid]];//显示的图片
    self.rightImageView.image = [UIImage imageNamed:self.dataSource[right]];
}


/**
 当开始拖动scrollView的时候 停止定时器
 */
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self lt_stopTimer];
}

/**
 当scrollView 拖动结束的时候 开启定时器
 */
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [self lt_startTimer];
}

/**
 开启定时器
 */
-(void)lt_startTimer{
    [self createTimer];
}


/**
 暂停定时器
 */
-(void)lt_stopTimer{
    [self invalidate];
}


/**
 停止定时器
 */
-(void)invalidate{
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
}

/**
 设置pageControl
 */
-(void)setPageControl{
    
    CGFloat width = self.bounds.size.width;
    CGFloat height = self.bounds.size.height;
    
    self.pageControler = [[LTPageControl alloc]initWithFrame:CGRectMake(30, height-35, width-60, 30) tintColor:self.pageControlTintColor currentColor:self.currentPageControlTintColor];
    self.pageControler.currentPage = 0;
    self.pageControler.numberOfPages = self.dataSource.count;
    
    self.pageControler.diameter = self.diameter;
    
    [self addSubview:self.pageControler];
    
}

@end
