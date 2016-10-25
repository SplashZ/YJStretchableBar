//
//  ViewController.m
//  YJStretchableBarDemo
//
//  Created by macintosh on 2016/10/25.
//  Copyright © 2016年 splashz. All rights reserved.
//

#import "ViewController.h"
#import "UIDevice+InterfaceOrientation.h"
#import "YJStretchableBar.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UISlider *spacingSlider;
@property (weak, nonatomic) IBOutlet UISlider *demensionSlider;
@property (weak, nonatomic) IBOutlet UILabel *spacing;
@property (weak, nonatomic) IBOutlet UILabel *demension;
@property (nonatomic, strong) YJStretchableBar *controlBar;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSMutableArray *btnArr = [NSMutableArray array];
    
    {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.backgroundColor = [UIColor yellowColor];
        [btnArr addObject:btn];
        [btn addTarget:self action:@selector(btnClick1) forControlEvents:UIControlEventTouchUpInside];
    }
    
    {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.backgroundColor = [UIColor yellowColor];
        [btnArr addObject:btn];
        [btn addTarget:self action:@selector(btnClick2) forControlEvents:UIControlEventTouchUpInside];
    }
    
    {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.backgroundColor = [UIColor yellowColor];
        [btnArr addObject:btn];
        [btn addTarget:self action:@selector(btnClick3) forControlEvents:UIControlEventTouchUpInside];
    }
    
    {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.backgroundColor = [UIColor yellowColor];
        [btnArr addObject:btn];
        [btn addTarget:self action:@selector(btnClick4) forControlEvents:UIControlEventTouchUpInside];
    }
    
    {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.backgroundColor = [UIColor yellowColor];
        [btnArr addObject:btn];
        [btn addTarget:self action:@selector(btnClick5) forControlEvents:UIControlEventTouchUpInside];
    }
    
    _controlBar = [YJStretchableBar toolBarWithButtons:btnArr
                                           barItemSize:CGSizeMake(50, 50)
                                         portraitPoint:CGPointMake(0, CGRectGetMidY(self.view.frame) - 25 + 1)
                                        landscapePoint:CGPointMake(CGRectGetHeight(self.view.frame) * 0.5 - 25 - 1, 0)];
    _spacingSlider.value = _controlBar.spacing;
    _spacing.text = @((int)_spacingSlider.value).stringValue;
    _demensionSlider.value = _controlBar.demension;
    _demension.text = @((int)_demensionSlider.value).stringValue;
    
    [self.view addSubview:_controlBar];
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (UIDeviceOrientationIsPortrait([UIDevice currentDevice].orientation)) {
        [[UIDevice currentDevice] setOrientation:UIDeviceOrientationLandscapeLeft];
    } else {
        [[UIDevice currentDevice] setOrientation:UIDeviceOrientationPortrait];
    }
    [UIViewController attemptRotationToDeviceOrientation];
}

- (IBAction)spacingChange:(UISlider *)sender {
    _spacing.text = @((int)sender.value).stringValue;
    _controlBar.spacing = sender.value;
}

- (IBAction)demensionChange:(UISlider *)sender {
    _demension.text = @((int)sender.value).stringValue;
    _controlBar.demension = sender.value;
}

- (void)btnClick1
{
    NSLog(@"%@ clicked", NSStringFromSelector(_cmd));
}

- (void)btnClick2
{
    NSLog(@"%@ clicked", NSStringFromSelector(_cmd));
}

- (void)btnClick3
{
    NSLog(@"%@ clicked", NSStringFromSelector(_cmd));
}

- (void)btnClick4
{
    NSLog(@"%@ clicked", NSStringFromSelector(_cmd));
}

- (void)btnClick5
{
    NSLog(@"%@ clicked", NSStringFromSelector(_cmd));
}

@end
