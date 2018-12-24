//
//  PayAnimateView.h
//  PayLoadingView
//
//  Created by yite on 2018/12/21.
//  Copyright © 2018 yite. All rights reserved.
//

#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSInteger,SubmitStatus) {
    SubmitStatusNormal = 0,
    SubmitStatusDoing ,
    SubmitStatusSuccess,
    SubmitStatusFailed,
};
@interface YTSubmitAnimateView : UIView

@property (nonatomic,assign)SubmitStatus submitStatus;
@end

NS_ASSUME_NONNULL_END
