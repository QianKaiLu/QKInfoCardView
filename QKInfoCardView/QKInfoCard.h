//
//  QKDimInfoView.h
//  SHLink
//
//  Created by 钱凯 on 15/2/26.
//  Copyright (c) 2015年 Qiankai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QKInfoCard : UIView

/**
 *  The card background color, default is white color.
 */
@property (nonatomic) UIColor *cardBackgroundColor;

/**
 *  Close button tint color, defalut is skybule color.
 */
@property (nonatomic) UIColor *closeButtonTintColor;

/**
 *  Close button background color, default is white color.
 */
@property (nonatomic) UIColor *closeButtonBackgroundColor;

/**
 *  Card's corner radius, defalut is 10.0f.
 */
@property (nonatomic) CGFloat cornerRadius;

/**
 * Cover the card background with a radial gradient, default is YES.
 */
@property (nonatomic) BOOL dimBackground;

/**
 *  Info card's pageable container subviews.
 */
@property (nonatomic) NSArray *containerSubviews;

/**
 *  Min horizontal padding between card and superview, default is 25.0.
 */
@property (nonatomic) CGFloat minHorizontalPadding;

/**
 *  Min vertal padding between card and superview, defalut is 10.0.
 */
@property (nonatomic) CGFloat minVertalPadding;

/**
 *  Proportion of |card width|/|card height|, default is 3.0/4.0.
 */
@property (nonatomic) CGFloat proportion;

- (id)initWithView:(UIView *)view;

- (id)initWithWindow:(UIWindow *)window;

- (void)show;

- (void)hide;

@end
