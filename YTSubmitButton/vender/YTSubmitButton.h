//
//  PayView.h
//  PayLoadingView
//
//  Created by yite on 2018/12/21.
//  Copyright © 2018 yite. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YTSubmitAnimateView.h"
NS_ASSUME_NONNULL_BEGIN
@protocol YTSubmitButtonDelegate <NSObject>

@optional
- (void)didClickSubmitButton;
@end


@interface YTSubmitButton : UIView
//构造方法
- (instancetype)initWithFrame:(CGRect)frame animationRadius:(float)radius;

//各状态文本
@property (strong,nonatomic)NSString *normalStatusText;
@property (strong,nonatomic)NSString *doingStatusText;
@property (strong,nonatomic)NSString *successStatusText;
@property (strong,nonatomic)NSString *failedStatusText;

@property (strong,nonatomic)UIFont *textFont;
@property (strong,nonatomic)UIColor *textColor;


@property (nonatomic,assign)SubmitStatus payStatus;

@property (weak,nonatomic)id<YTSubmitButtonDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
