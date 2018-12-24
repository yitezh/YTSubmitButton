//
//  PayAnimateView.m
//  PayLoadingView
//
//  Created by yite on 2018/12/21.
//  Copyright © 2018 yite. All rights reserved.
//

#import "YTSubmitAnimateView.h"
#import "UIView+ReRect.h"
@interface YTSubmitAnimateView()<CAAnimationDelegate>{
    float rate;
}
@property (strong,nonatomic)CAShapeLayer *roundLayer;
@property (strong,nonatomic)CAShapeLayer *checkLayer;
#define ANIMATETIME 0.8
@end

@implementation YTSubmitAnimateView

- (instancetype)initWithFrame:(CGRect)frame {
    if([super initWithFrame:frame]) {
        [self addAnimationLayer];
    }
    
    return self;
}


- (void)addAnimationLayer {
    UIBezierPath *roundPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:self.height/2];
    
    self.roundLayer.path = roundPath.CGPath;
    self.roundLayer.strokeColor = [UIColor whiteColor].CGColor;
    self.roundLayer.fillColor = [UIColor clearColor].CGColor;
    self.roundLayer.frame = CGRectMake(0, 0, self.width, self.height);
    self.roundLayer.lineWidth = 3;
    [self.layer addSublayer:self.roundLayer];
    
    
    CGFloat insideRadius =  self.height/2-3;
    
    UIBezierPath *checkPath = [UIBezierPath bezierPath];
    CGPoint secondPoint = [self calcCircleCoordinateWithCenter:CGPointMake(self.width/2, self.height/2) andWithAngle:240 andWithRadius:insideRadius];
    CGPoint thirdpoint =   [self calcCircleCoordinateWithCenter:CGPointMake(self.width/2, self.height/2) andWithAngle:30 andWithRadius:insideRadius];
    [checkPath moveToPoint:CGPointMake(0, self.height/2)];
    [checkPath addLineToPoint:secondPoint];
    [checkPath addLineToPoint:thirdpoint];
    
    self.checkLayer.path = checkPath.CGPath;
    self.checkLayer.strokeColor = [UIColor whiteColor].CGColor;
    self.checkLayer.fillColor = [UIColor clearColor].CGColor;
    self.checkLayer.frame = CGRectMake(0, 0, self.width, self.height);
    self.checkLayer.lineWidth = 3;
    self.checkLayer.strokeEnd = 0;
    [self.layer addSublayer:self.checkLayer];
}

// 计算圆圈上点在IOS系统中的坐标
- (CGPoint)calcCircleCoordinateWithCenter:(CGPoint) center  andWithAngle : (CGFloat) angle andWithRadius: (CGFloat) radius{
    CGFloat x2 = radius*cosf(angle*M_PI/180);
    CGFloat y2 = radius*sinf(angle*M_PI/180);
    return CGPointMake(center.x+x2, center.y-y2);
}




- (void)setSubmitStatus:(SubmitStatus)payStatus {
    switch (payStatus) {
        case SubmitStatusDoing:
            [self showDoingAnimation];
            break;
        case SubmitStatusSuccess:
            [self showSuccessAnimation];
            break;
        default:
            break;
    }
}

- (void)showDoingAnimation {
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    self.checkLayer.hidden = YES;
    
    
    CAAnimationGroup *group = [CAAnimationGroup new];
    group.repeatCount = MAXFLOAT;
    
    CABasicAnimation *startAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    startAnimation.fromValue = @(0);
    startAnimation.toValue = @(0.9);
    startAnimation.beginTime = 0 ;
    startAnimation.duration = ANIMATETIME;
    startAnimation.fillMode = kCAFillModeForwards;
    startAnimation.removedOnCompletion  = NO;
    startAnimation.timingFunction = [CAMediaTimingFunction functionWithControlPoints:0.62 :0.0 :0.38 :1.0];
    
    CABasicAnimation *endAnimation = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
    endAnimation.fromValue = @(0);
    endAnimation.toValue = @(0.9);
    endAnimation.duration = ANIMATETIME;
    endAnimation.beginTime = ANIMATETIME;
    endAnimation.fillMode = kCAFillModeForwards;
    endAnimation.timingFunction = [CAMediaTimingFunction functionWithControlPoints:0.62 :0.0 :0.38 :1.0];
    
    rate = M_PI/2;
    CABasicAnimation *rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.fromValue = @(rate);
    rotationAnimation.toValue = @(rate + 2 * M_PI);
    rotationAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    rotationAnimation.duration = 2*ANIMATETIME;
    rotationAnimation.fillMode = kCAFillModeForwards;
    rotationAnimation.removedOnCompletion = NO;
    
    group.removedOnCompletion = NO;
    group.animations = @[startAnimation,endAnimation,rotationAnimation];
    group.duration = 2*ANIMATETIME;
    [self.roundLayer removeAllAnimations];
    [self.roundLayer addAnimation:group forKey:@"round_group_ani"];
    
    [CATransaction commit];
}

- (void)showSuccessAnimation {
    
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    self.checkLayer.hidden = NO;
    [self.roundLayer removeAllAnimations];
    
    [self showRoundAnimation];
    [self showCheckAnimation];
    
    [CATransaction commit];
}

- (void)showRoundAnimation{
    CABasicAnimation *startAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    startAnimation.fromValue = @(0);
    startAnimation.toValue = @(1);
    startAnimation.beginTime = 0 ;
    startAnimation.duration = ANIMATETIME;
    startAnimation.fillMode = kCAFillModeForwards;
    startAnimation.removedOnCompletion  = NO;
    [self.roundLayer addAnimation:startAnimation forKey:@"check_round_ani"];
}


- (void)showCheckAnimation {
    CABasicAnimation *checkAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    checkAnimation.fromValue = @(0);
    checkAnimation.toValue = @(1);
    checkAnimation.beginTime = CACurrentMediaTime()+0.5;
    checkAnimation.duration = 0.3;
    checkAnimation.fillMode = kCAFillModeForwards;
    checkAnimation.removedOnCompletion  = NO;
    [self.checkLayer addAnimation:checkAnimation forKey:@"check_check_ani"];
}


- (CAShapeLayer *)roundLayer {
    if(!_roundLayer) {
        _roundLayer  = [CAShapeLayer layer];
    }
    return _roundLayer;
}

- (CAShapeLayer *)checkLayer {
    if(!_checkLayer) {
        _checkLayer  = [CAShapeLayer layer];
    }
    return _checkLayer;
}




@end
