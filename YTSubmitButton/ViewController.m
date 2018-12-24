//
//  ViewController.m
//  YTSubmitButton
//
//  Created by yite on 2018/12/24.
//  Copyright © 2018 yite. All rights reserved.
//

#import "ViewController.h"
#import "YTSubmitButton.h"
@interface ViewController ()<YTSubmitButtonDelegate>
@property (weak, nonatomic) IBOutlet UITextField *inputText;
@property (strong,nonatomic)YTSubmitButton *submitView ;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    YTSubmitButton *submitView = [[YTSubmitButton alloc]initWithFrame:CGRectMake(0, 200, [UIScreen mainScreen].bounds.size.width, 50) animationRadius:15];
//    submitView.textFont = [UIFont systemFontOfSize:13];
//    submitView.textColor = [UIColor greenColor];
    
    submitView.delegate = self;
    self.submitView = submitView;
    
    [self.view addSubview:submitView];
}

- (void)didClickSubmitButton {
    [self.submitView setPayStatus:SubmitStatusDoing];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if([self.inputText.text isEqualToString:@"12345"])
        {
            [self.submitView setPayStatus:SubmitStatusSuccess];
        }
        else {
            [self.submitView setPayStatus:SubmitStatusFailed];
        }
    });
}

- (IBAction)resetButtonClick:(id)sender {
    [self.submitView setPayStatus:SubmitStatusNormal];
}


@end
