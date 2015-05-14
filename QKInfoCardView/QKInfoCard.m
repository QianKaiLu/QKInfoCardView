//
//  QKDimInfoView.m
//  SHLink
//
//  Created by 钱凯 on 15/2/26.
//  Copyright (c) 2015年 Qiankai. All rights reserved.
//

#import "QKInfoCard.h"

////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////
@interface QKInfoCardCloseButton : UIButton

@property (nonatomic) UIColor *buttonStrokeColor;

@end

@implementation QKInfoCardCloseButton

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setUp];
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setUp];
    }
    return self;
}

-(instancetype)init {
    
    return [self initWithFrame:CGRectZero];
}

- (void)setUp {
    
    self.backgroundColor = [UIColor whiteColor];
    
    self.showsTouchWhenHighlighted = YES;
}

- (void)drawRect:(CGRect)rect {
    
    CGFloat buttonWidth = MIN(CGRectGetWidth(rect), CGRectGetHeight(rect));
    CGFloat radius = buttonWidth / 2.0;
    
    self.layer.cornerRadius = radius;
    self.layer.masksToBounds = YES;
    
    CGContextRef contex = UIGraphicsGetCurrentContext();
    
    CGContextSetStrokeColorWithColor(contex, _buttonStrokeColor.CGColor);
    CGContextSetLineWidth(contex, 2);
    
    CGContextBeginPath(contex);
    
    CGPathRef path = [UIBezierPath bezierPathWithRoundedRect:CGRectInset(rect, 1, 1) cornerRadius:radius].CGPath;
    
    CGContextAddPath(contex, path);
    
    CGContextMoveToPoint(contex, 0, 0);
    CGContextAddLineToPoint(contex, CGRectGetMaxX(rect), CGRectGetMaxY(rect));
    
    CGContextMoveToPoint(contex, CGRectGetMaxX(rect), 0);
    CGContextAddLineToPoint(contex, 0, CGRectGetMaxY(rect));
    
    CGContextStrokePath(contex);
}
@end

////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////
@interface QKInfoCardContainerView : UIView

@property (assign, nonatomic) CGFloat cornerRadius;

@property (strong, nonatomic) UIColor *containerBackgroundColor;

@property (strong, nonatomic) UIColor *closeButtonTintColor;

@property (strong, nonatomic) UIColor *closeButtonBackgroundColor;

@property (strong, nonatomic) NSArray *containtViews;

@end

@implementation QKInfoCardContainerView {
    QKInfoCardCloseButton *_closeButton;
    UIView *_containerView;
    UIScrollView *_scrollView;
}

#pragma mark - Lifecycle
#pragma mark -

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setUp];
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setUp];
    }
    return self;
}

-(instancetype)init {
    return [self initWithFrame:CGRectZero];
}

- (void)setUp {
    self.backgroundColor = [UIColor clearColor];
    
    _closeButton = [[QKInfoCardCloseButton alloc] init];
    _containerView = [[UIView alloc] init];
    _scrollView = [[UIScrollView alloc] init];
    
    _scrollView.backgroundColor = [UIColor clearColor];
    _scrollView.pagingEnabled = YES;
    _scrollView.showsHorizontalScrollIndicator = YES;
    _scrollView.showsVerticalScrollIndicator = YES;
    
    _closeButton.buttonStrokeColor = _closeButtonTintColor;
    _closeButton.backgroundColor = _closeButtonBackgroundColor;
    [_closeButton addTarget:self.superview action:@selector(hide) forControlEvents:UIControlEventTouchUpInside];
    
    _containerView.layer.cornerRadius = _cornerRadius;
    _containerView.backgroundColor = _containerBackgroundColor;
    _containerView.layer.masksToBounds = YES;
    
    [_containerView addSubview:_scrollView];
    
    [self addSubview:_containerView];
    [self addSubview:_closeButton];
    
}

#pragma mark - Layout
#pragma mark -

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat kContainerPadding = 5.0f;
    CGFloat kCloseButtonWidth = 32.0f;
    
    unsigned long subviewCount = _containtViews.count;
    
    CGRect containerFrame = CGRectInset(self.bounds, kContainerPadding, kContainerPadding);
    
    _containerView.frame = containerFrame;
    _containerView.layer.cornerRadius = _cornerRadius;
    _containerView.backgroundColor = _containerBackgroundColor;
    
    _closeButton.buttonStrokeColor = _closeButtonTintColor;
    _closeButton.backgroundColor = _closeButtonBackgroundColor;
    _closeButton.bounds = CGRectMake(0, 0, kCloseButtonWidth, kCloseButtonWidth);
    _closeButton.center = CGPointMake(CGRectGetMaxX(_containerView.frame) - kCloseButtonWidth / 4.5, CGRectGetMinY(_containerView.frame) + kCloseButtonWidth / 4.5);
    [_closeButton setNeedsDisplay];
    
    _scrollView.frame = CGRectInset(_containerView.bounds, 5, 5);
    
    _scrollView.contentSize = CGSizeMake(CGRectGetWidth(_scrollView.frame) * subviewCount, CGRectGetHeight(_scrollView.frame));
    
    for (UIView *view in _scrollView.subviews) {
        [view removeFromSuperview];
    }
    
    for (unsigned int i = 0; i < subviewCount; i++) {
        UIView *viewToAdd = [_containtViews objectAtIndex:i];
        viewToAdd.frame = CGRectMake(i * CGRectGetWidth(_scrollView.frame), 0, CGRectGetWidth(_scrollView.frame), CGRectGetHeight(_scrollView.frame));
        [_scrollView addSubview:viewToAdd];
    }
    
    _scrollView.contentOffset = CGPointZero;
}

@end

////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////
@implementation QKInfoCard {
    QKInfoCardContainerView *_containerView;
}

#pragma mark - Lifecycle
#pragma mark -

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setUp];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setUp];
    }
    return self;
}

- (instancetype)init {
    return [self initWithFrame:CGRectZero];
}

- (id)initWithView:(UIView *)view {
    NSAssert(view, @"View must not be nil.");
    return [self initWithFrame:view.bounds];
}

- (id)initWithWindow:(UIWindow *)window {
    return [self initWithView:window];
}

- (void)setUp {
    self.backgroundColor = [UIColor clearColor];
    self.alpha = 0.0f;
    
    _cardBackgroundColor = [UIColor whiteColor];
    _closeButtonTintColor = [UIColor colorWithRed:0 green:183.0/255.0 blue:238.0/255.0 alpha:1.000];
    _closeButtonBackgroundColor = [UIColor whiteColor];
    _cornerRadius = 10.f;
    _dimBackground = YES;
    _minHorizontalPadding = 25.0f;
    _minVertalPadding = 10.f;
    _proportion = 3.0/4.0f;
    
    _containerView = [[QKInfoCardContainerView alloc] init];
    
    [self addSubview:_containerView];
    
    [self registerForKVO];
    [self registerForNotifications];
}

- (void)dealloc {
    [self unregisterFromKVO];
    [self unregisterFromNotifications];
}

#pragma mark - APIs
#pragma mark -

- (void)show {
    [self showUsingAnimation:YES];
}

- (void)hide {
    [self hideUsingAnimation:YES];
}

#pragma mark - Tools
#pragma mark -

- (void)hideUsingAnimation:(BOOL)animated {

    if (animated) {
        [UIView animateWithDuration:0.2 animations:^{
            self.alpha = 0.0f;
        } completion:^(BOOL finished) {
        }];
    }
    else {
        self.alpha = 0.0f;
    }
}

- (void)showUsingAnimation:(BOOL)animated {

    if (animated) {
        [UIView animateWithDuration:0.2 animations:^{
            self.alpha = 1.0f;
        } completion:^(BOOL finished) {
        }];
    }
    else {
        self.alpha = 1.0f;
    }
}

#pragma mark - KVO
#pragma mark -

- (void)registerForKVO {
    for (NSString *keyPath in [self observableKeypaths]) {
        [self addObserver:self forKeyPath:keyPath options:NSKeyValueObservingOptionNew context:NULL];
    }
}

- (void)unregisterFromKVO {
    for (NSString *keyPath in [self observableKeypaths]) {
        [self removeObserver:self forKeyPath:keyPath];
    }
}

- (NSArray *)observableKeypaths {
    return [NSArray arrayWithObjects:@"containerSubviews", @"cardBackgroundColor", @"closeButtonTintColor", @"closeButtonBackgroundColor", @"cornerRadius", @"dimBackground", @"minHorizontalPadding", @"minVertalPadding", @"proportion", nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if (![NSThread isMainThread]) {
        [self performSelectorOnMainThread:@selector(updateUIForKeypath:) withObject:keyPath waitUntilDone:NO];
    } else {
        [self updateUIForKeypath:keyPath];
    }
}

- (void)updateUIForKeypath:(NSString *)keyPath {
    if ([keyPath isEqualToString:@"containerSubviews"]) {
        _containerView.containtViews = self.containerSubviews;
    }
    [self setNeedsLayout];
    [self setNeedsDisplay];
    
    for (UIView *subView in self.subviews) {
        [subView setNeedsLayout];
        [subView setNeedsDisplay];
    }
}

#pragma mark - Notifications
#pragma mark -

- (void)registerForNotifications {
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    
    [nc addObserver:self selector:@selector(statusBarOrientationDidChange:)
               name:UIApplicationDidChangeStatusBarOrientationNotification object:nil];
}

- (void)unregisterFromNotifications {
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc removeObserver:self name:UIApplicationDidChangeStatusBarOrientationNotification object:nil];
}

- (void)statusBarOrientationDidChange:(NSNotification *)notification {
    UIView *superview = self.superview;
    if (!superview) {
        return;
    }else {
        self.frame = self.superview.bounds;
        [self setNeedsDisplay];
    }
}

#pragma mark - Properties
#pragma mark -

#pragma mark - Layout
#pragma mark -

- (void)drawRect:(CGRect)rect {
    //Draw dim background
    if (_dimBackground) {
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetFillColorWithColor(context, [UIColor colorWithRed:0 green:0 blue:0 alpha:0.65].CGColor);
        CGContextFillRect(context, rect);
    }
}

- (void)layoutSubviews {
    CGFloat kWidthPadding = _minHorizontalPadding;
    CGFloat kHeightPadding = _minVertalPadding;

    CGFloat kProportion = _proportion;
    
    _containerView.containerBackgroundColor = _cardBackgroundColor;
    _containerView.closeButtonBackgroundColor = _closeButtonBackgroundColor;
    _containerView.closeButtonTintColor = _closeButtonTintColor;
    _containerView.cornerRadius = _cornerRadius;
    
    if (CGRectGetWidth(self.bounds) > CGRectGetHeight(self.bounds)) {
        
        CGFloat containerHeight = CGRectGetHeight(self.bounds) - kHeightPadding * 2.0;
        
        _containerView.bounds = CGRectMake(0, 0, containerHeight * kProportion, containerHeight);
    } else {
        
        CGFloat containerWidth = CGRectGetWidth(self.bounds) - kWidthPadding * 2.0;
        
        _containerView.bounds = CGRectMake(0, 0, containerWidth, containerWidth / kProportion);
    }
    
    _containerView.center = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
}

@end
