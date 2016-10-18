//
//  CircleBannerView.m
//  CircleBannerView
//
//  Created by Ezreal on 16/6/13.
//  Copyright © 2016年 上海朴元健康科技有限公司. All rights reserved.
//

#import "CircleBannerView.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface CircleBannerView () <UIScrollViewDelegate>

@property(nonatomic, strong) UIScrollView *scrollView;
@property(nonatomic, strong) UIPageControl *pageControl;

@property(nonatomic, strong) UIImageView *leftImageView;
@property(nonatomic, strong) UIImageView *centerImageView;
@property(nonatomic, strong) UIImageView *rightImageView;

@property(nonatomic, strong) UITapGestureRecognizer *leftTapGesture;
@property(nonatomic, strong) UITapGestureRecognizer *centerTapGesture;
@property(nonatomic, strong) UITapGestureRecognizer *rightTapGesture;

@property(nonatomic, strong) UIView *bottomBannerView;
@property(nonatomic, strong) UILabel *titleLabel;

@property(nonatomic, assign) NSInteger pageCount;
@property(nonatomic, assign) NSInteger currentPageIndex;

@end

@implementation CircleBannerView

- (instancetype)initWithFrame:(CGRect)frame {
    if (!(self = [super initWithFrame:frame])) {
        return nil;
    }
    
    [self setupPageViews];
    return self;
}

#pragma mark - 初始化页面视图
- (void)setupPageViews {
    CGFloat w = self.frame.size.width;
    CGFloat h = self.frame.size.height;
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, w, h)];
    _scrollView.bounces = NO;
    _scrollView.pagingEnabled = YES;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.delegate = self;
    _scrollView.contentSize = CGSizeMake(w * 3, h);
    _scrollView.contentOffset = CGPointMake(w, 0); // 显示中间的
    [self addSubview:_scrollView];
    
    _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake((w - 100) / 2, h - 25, 100, 20)];
    _pageControl.currentPageIndicatorTintColor = [UIColor colorWithHexString:@"DE6444"];
    [self addSubview:_pageControl];
    
    _leftTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pageClickWithSender:)];
    _leftImageView =[[UIImageView alloc] init];
    _leftImageView.frame = CGRectMake(w * 0, 0, w, h);
    _leftImageView.contentMode = UIViewContentModeScaleAspectFill;
    _leftImageView.userInteractionEnabled = YES;
    [_leftImageView addGestureRecognizer:_leftTapGesture];
    [_scrollView addSubview:_leftImageView];
    
    _centerTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pageClickWithSender:)];
    _centerImageView = [[UIImageView alloc] init];
    _centerImageView.frame = CGRectMake(w * 1, 0, w, h);
    _centerImageView.contentMode = UIViewContentModeScaleAspectFill;
    _centerImageView.userInteractionEnabled = YES;
    [_centerImageView addGestureRecognizer:_centerTapGesture];
    [_scrollView addSubview:_centerImageView];
    
    _rightTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pageClickWithSender:)];
    _rightImageView = [[UIImageView alloc] initWithFrame:CGRectMake(w * 2, 0, w, h)];
    _rightImageView.frame = CGRectMake(w * 2, 0, w, h);
    _rightImageView.contentMode = UIViewContentModeScaleAspectFill;
    _rightImageView.userInteractionEnabled = YES;
    [_rightImageView addGestureRecognizer:_rightTapGesture];
    [_scrollView addSubview:_rightImageView];
}

#pragma mark - 页面点击事件
- (void)pageClickWithSender:(UITapGestureRecognizer *)sender {
    if ([self.delegate respondsToSelector:@selector(circleBannerView:didSelectPageAtIndex:)]) {
        [self.delegate circleBannerView:self didSelectPageAtIndex:_currentPageIndex];
    }
}

#pragma mark - UIScrollViewDelegate（滚动停止事件）
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    CGPoint offset = [scrollView contentOffset];
    if (offset.x > scrollView.frame.size.width) {
        _currentPageIndex = (_currentPageIndex + 1) % _pageCount;
        
    } else if (offset.x < scrollView.frame.size.width){
        _currentPageIndex = (_currentPageIndex + _pageCount - 1) % _pageCount;
    }
    
    _pageControl.currentPage = _currentPageIndex;
    NSInteger leftPageIndex = (_currentPageIndex + _pageCount - 1) % _pageCount;
    NSInteger rightPageIndex = (_currentPageIndex + 1) % _pageCount;
    
    // title 标题
    if (_styleType == CircleBannerStyleTypeTitle) {
        _titleLabel.text = _titleArray[_currentPageIndex];
    }
    
    // 图片
    [self loadPegeImageWithLeftPageIndex:leftPageIndex
                        currentPageIndex:_currentPageIndex
                          rightPageIndex:rightPageIndex];
}

- (void)loadPegeImageWithLeftPageIndex:(NSInteger)leftPageIndex
                      currentPageIndex:(NSInteger)currentPageIndex
                        rightPageIndex:(NSInteger)rightPageIndex {
    
    // 网络图片
    if (_resourceType == CircleBannerResourceTypeWeb) {
        [_leftImageView sd_setImageWithURL:[NSURL URLWithString:_imageArray[leftPageIndex]]placeholderImage:[UIImage imageNamed:@"placeholder"]];
        [_centerImageView sd_setImageWithURL:[NSURL URLWithString:_imageArray[currentPageIndex]] placeholderImage:[UIImage imageNamed:@"placeholder"]];
        [_rightImageView sd_setImageWithURL:[NSURL URLWithString:_imageArray[rightPageIndex]] placeholderImage:[UIImage imageNamed:@"placeholder"]];
    }
    
    // 本地图片
    else {
        _leftImageView.image = [UIImage imageNamed:_imageArray[leftPageIndex]];
        _centerImageView.image = [UIImage imageNamed:_imageArray[currentPageIndex]];
        _rightImageView.image = [UIImage imageNamed:_imageArray[rightPageIndex]];
    }
    
    [_scrollView setContentOffset:CGPointMake(_scrollView.frame.size.width, 0) animated:NO];
}

- (void)setStyleType:(CircleBannerStyleType)styleType {
    _styleType = styleType;
    if (_styleType == CircleBannerStyleTypeTitle) {
        CGFloat w = self.frame.size.width;
        CGFloat h = self.frame.size.height;
        _bottomBannerView = [[UIView alloc] initWithFrame:CGRectMake(0, h - 30, w, 30)];
        _bottomBannerView.backgroundColor = [UIColor blackColor];
        _bottomBannerView.alpha = 0.5;
        [self insertSubview:_bottomBannerView aboveSubview:_scrollView];
        
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, h - 30, w - 120, 30)];
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.font = [UIFont systemFontOfSize:13];
        [self insertSubview:_titleLabel aboveSubview:_bottomBannerView];
    }
}

- (void)setBannerType:(CircleBannerResourceType)resourceType {
    _resourceType = resourceType;
}

- (void)setImageArray:(NSArray *)imageArray {
    if (!imageArray) {
        return;
    }
    _imageArray = imageArray;
    _pageCount = [imageArray count];
    _pageControl.numberOfPages = _pageCount;
    _currentPageIndex = 0;
    NSInteger leftPageIndex = (_currentPageIndex + _pageCount - 1) % _pageCount;
    NSInteger rightPageIndex = (_currentPageIndex + 1) % _pageCount;
    [self loadPegeImageWithLeftPageIndex:leftPageIndex
                        currentPageIndex:_currentPageIndex
                          rightPageIndex:rightPageIndex];
}

- (void)setTitleArray:(NSArray *)titleArray {
    _titleArray = titleArray;
    _titleLabel.text = titleArray[_currentPageIndex];
}


@end
