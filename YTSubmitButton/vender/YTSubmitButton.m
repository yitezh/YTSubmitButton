//
//  PayView.m
//  PayLoadingView
//
//  Created by yite on 2018/12/21.
//  Copyright © 2018 yite. All rights reserved.
//

#import "YTSubmitButton.h"
#import "UIView+ReRect.h"
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
@interface YTSubmitButton()
@property (strong,nonatomic)UILabel *titleLabel;
@property (strong,nonatomic)YTSubmitAnimateView *animationView;

@property (assign,nonatomic)float animationRadius;
#define topInset 10
@end


@implementation YTSubmitButton

- (instancetype)initWithFrame:(CGRect)frame animationRadius:(float)radius{
    if([super initWithFrame:frame]) {
        [self setAnimationRadius:radius] ;
        [self setDefaultData];
        [self setUpContentView];
        [self setPayStatus:SubmitStatusNormal];
        [self addClickGesture];
    }
    return self;
}

- (void)setDefaultData {
    self.normalStatusText = @"提交";
    self.doingStatusText = @"提交中";
    self.successStatusText = @"提交成功";
    self.failedStatusText = @"重试";
}


- (void)showShakeAnimation {
    CABasicAnimation* shake = [CABasicAnimation animationWithKeyPath:@"transform.translation.x"];
    shake.fromValue = [NSNumber numberWithFloat:-1];
    shake.toValue = [NSNumber numberWithFloat:1];
    shake.duration = 0.05;//执行时间
    shake.autoreverses = YES; //是否重复
    shake.repeatCount = 2;//次数
    [self.layer addAnimation:shake forKey:@"shakeAnimation"];
}


- (void)setUpContentView {
    self.backgroundColor = UIColorFromRGB(0x108EE9);
    [self addSubview:self.titleLabel];
    [self addSubview:self.animationView];
    
}

- (void)addClickGesture {
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
    [self addGestureRecognizer:tap];
}

- (void)tapAction:(id)sender {
    if(self.payStatus == SubmitStatusNormal||self.payStatus == SubmitStatusFailed)
    {
        if([self.delegate respondsToSelector:@selector(didClickSubmitButton)]){
            [self.delegate didClickSubmitButton];
        }
    }
}


- (void)setPayStatus:(SubmitStatus)payStatus {
    _payStatus = payStatus;
    switch (payStatus) {
        case SubmitStatusNormal:
            [self showNormalView];
            break;
        case SubmitStatusDoing:
            [self showDoinglView];
            break;
        case SubmitStatusSuccess:
            [self showSuccessView];
            break;
        case SubmitStatusFailed:
            [self showFailedView];
            [self showShakeAnimation];
            break;
        default:
            break;
    }
    [self.animationView setSubmitStatus:payStatus];
    [self setNeedsLayout];
}

- (void)resetView {
    [self setPayStatus:SubmitStatusNormal];
    [self setNeedsLayout];
    
}

- (void)showNormalView {
    self.titleLabel.text = self.normalStatusText;
    [self.titleLabel sizeToFit];
    self.animationView.hidden = YES;
}

- (void)showDoinglView {
    self.titleLabel.text = self.doingStatusText;
    [self.titleLabel sizeToFit];
    self.animationView.hidden = NO;
}

- (void)showSuccessView {
    self.titleLabel.text = self.successStatusText;
    [self.titleLabel sizeToFit];
    self.animationView.hidden = NO;
}

- (void)showFailedView {
    self.titleLabel.text = self.failedStatusText;
    [self.titleLabel sizeToFit];
    self.animationView.hidden = YES;
}

- (void)layoutSubviews {
    self.titleLabel.center = CGPointMake(self.width/2, self.height/2);
    self.animationView.x = CGRectGetMinX(self.titleLabel.frame) - self.animationView.width- 10;
    self.animationView.center = CGPointMake(self.animationView.center.x, self.titleLabel.center.y);
}

#pragma mark -setter
- (void)setNormalStatusText:(NSString *)normalStatusText {
    _normalStatusText = normalStatusText;
    [self resetView];
}

- (void)setDoingStatusText:(NSString *)doingStatusText {
    _doingStatusText = doingStatusText;
    [self resetView];
}

- (void)setSuccessStatusText:(NSString *)successStatusText {
    _successStatusText = successStatusText;
    [self resetView];
}

- (void)setFailedStatusText:(NSString *)failedStatusText {
    _failedStatusText = failedStatusText;
    [self resetView];
}

- (void)setTextFont:(UIFont *)textFont {
    self.titleLabel.font =  textFont;
    [self resetView];
}

- (void)setTextColor:(UIColor *)textColor {
    self.titleLabel.textColor =  textColor;
}


#pragma mark -getter

- (UILabel *)titleLabel {
    if(!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.numberOfLines = 1;
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _titleLabel;
}

- (YTSubmitAnimateView *)animationView {
    if(!_animationView) {
        _animationView = [[YTSubmitAnimateView alloc]initWithFrame:CGRectMake(topInset, 10, self.animationRadius*2 , self.animationRadius*2)];
    }
    return _animationView;
    
}



@end
