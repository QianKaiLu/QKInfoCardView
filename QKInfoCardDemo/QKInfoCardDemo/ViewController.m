//
//  ViewController.m
//  QKInfoCardDemo
//
//  Created by 钱凯 on 15/5/14.
//  Copyright (c) 2015年 Qiankai. All rights reserved.
//

#import "ViewController.h"
#import "QKInfoCard.h"
#import "PureLayout.h"

@interface ViewController ()

@end

@implementation ViewController {
    QKInfoCard *_infoCard;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _infoCard = [[QKInfoCard alloc] initWithView:self.view];
    
    NSMutableArray *array = [[NSMutableArray alloc] init];
    for (int i = 0; i < 4; i ++) {
        UIView *viewToAdd = [[UIView alloc] init];
        
        UILabel *label = [[UILabel alloc] init];
        
        label.font = [UIFont boldSystemFontOfSize:20.0];
        label.textAlignment = NSTextAlignmentCenter;
        label.text = [NSString stringWithFormat:@"Step %d", i+1];
        label.textColor = [UIColor whiteColor];
        label.backgroundColor = [UIColor colorWithRed:0 green:183.0/255.0 blue:238.0/255.0 alpha:1.000];
        label.layer.cornerRadius = 60;
        label.layer.masksToBounds = YES;
        
        [viewToAdd addSubview:label];
        
        [label autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
        [label autoAlignAxisToSuperviewAxis:ALAxisVertical];
        
        [label autoSetDimension:ALDimensionWidth toSize:120];
        [label autoSetDimension:ALDimensionHeight toSize:120];
        
        
        [array addObject:viewToAdd];
    }
    
    _infoCard.containerSubviews = array;
    
    [self.view addSubview:_infoCard];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
//    [[UIApplication sharedApplication].keyWindow addSubview:_infoCard];
    [super viewDidAppear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
    [_infoCard removeFromSuperview];
    [super viewDidDisappear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)show:(id)sender {
    [_infoCard show];
}

@end
