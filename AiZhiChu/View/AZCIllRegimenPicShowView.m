//
//  AZHIllRegimenPicShowView.m
//  AiZhiChu
//
//  Created by Ezreal on 16/6/14.
//  Copyright © 2016年 Ezreal. All rights reserved.
//

#import "AZCIllRegimenPicShowView.h"

@interface AZCIllRegimenPicShowView () <UIScrollViewDelegate>

@property(nonatomic, strong) UIScrollView *scrollView;
@property(nonatomic, strong) UIButton *leftArrowButton;
@property(nonatomic, strong) UIButton *rightArrowButton;

@property(nonatomic, assign) NSInteger curPageIndex;
@property(nonatomic, assign) NSInteger pageAmount;

@end

@implementation AZCIllRegimenPicShowView

- (instancetype)initWithFrame:(CGRect)frame {
    if (!(self = [super initWithFrame:frame])) {
        return self;
    }
    
    _curPageIndex = 0;
    _scrollView = [[UIScrollView alloc] init];
    _scrollView.bounces = NO;
    _scrollView.pagingEnabled = YES;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.delegate = self;
    [self addSubview:_scrollView];
    
    _leftArrowButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_leftArrowButton setImage:[UIImage imageNamed:@"arrow_right_selected"] forState:UIControlStateNormal];
    [_leftArrowButton addTarget:self action:@selector(changePic:) forControlEvents:UIControlEventTouchUpInside];
    _leftArrowButton.tag = 1;
    [self addSubview:_leftArrowButton];
    
    _rightArrowButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_rightArrowButton setImage:[UIImage imageNamed:@"arrow_left_normal"] forState:UIControlStateNormal];
    [_rightArrowButton setImage:[UIImage imageNamed:@"arrow_left_selected"] forState:UIControlStateHighlighted];
    [_rightArrowButton addTarget:self action:@selector(changePic:) forControlEvents:UIControlEventTouchUpInside];
    _rightArrowButton.tag = 2;
    [self addSubview:_rightArrowButton];
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _scrollView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    NSArray *array = _scrollView.subviews;
    for (int i = 0; i < array.count; i++) {
        if ([array[i] isKindOfClass:[UIImageView class]]) {
            [array[i] setFrame:CGRectMake(SCREEN_WIDTH * i, 0, SCREEN_WIDTH, self.frame.size.height)];
        }
    }
    _leftArrowButton.frame = CGRectMake(10, self.frame.size.height / 2, 20, 30);
    _rightArrowButton.frame = CGRectMake(self.frame.size.width - 30, self.frame.size.height / 2, 20, 30);
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    CGPoint point = scrollView.contentOffset;
    _curPageIndex = point.x / SCREEN_WIDTH;
    
    [self showOrHideChangeButton];
}

#pragma mark - 点击切换图片
- (void)changePic:(UIButton *)sender {
    // 左切换
    if (sender.tag == 1) {
        if (_curPageIndex == 0) {
            return;
        }
         _curPageIndex--;
    }
    
    // 右切换
    else if (sender.tag == 2){
        if (_curPageIndex == _pageAmount - 1) {
            return;
        }
        _curPageIndex++;
    }
    
    [_scrollView setContentOffset:CGPointMake(SCREEN_WIDTH * _curPageIndex, 0) animated:YES];
    [self showOrHideChangeButton];
}

- (void)showOrHideChangeButton {
    if (_curPageIndex == 0) {
        _leftArrowButton.hidden = YES;
        _rightArrowButton.hidden = NO;
        
    } else if (_curPageIndex == _pageAmount - 1) {
        _leftArrowButton.hidden = NO;
        _rightArrowButton.hidden = YES;
        
    } else {
        _leftArrowButton.hidden = NO;
        _rightArrowButton.hidden = NO;
    }
}

-(void)setPicArray:(NSArray *)picArray {
    if (!picArray) {
        return;
    }
    _pageAmount = picArray.count;
    _scrollView.contentSize = CGSizeMake(SCREEN_WIDTH * picArray.count, self.frame.size.height);
    for (int i = 0; i < picArray.count; i++) {
        UIImageView *pic = [[UIImageView alloc] initWithImage:[UIImage imageNamed:picArray[i]]];
        pic.contentMode = UIViewContentModeScaleAspectFill;
        [_scrollView addSubview:pic];
    }

    if (_pageAmount == 1) {
        _leftArrowButton.hidden = YES;
        _rightArrowButton.hidden = YES;
    } else {
        [self showOrHideChangeButton];
    }
}

@end
