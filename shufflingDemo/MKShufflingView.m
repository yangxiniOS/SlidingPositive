//
//  MKShufflingView.m
//  lianxiceshi
//
//  Created by 杨鑫 on 2016/11/16.
//  Copyright © 2016年 杨鑫. All rights reserved.
//

#import "MKShufflingView.h"



@interface MKShufflingView ()

@property (nonatomic,strong)UIButton *upButton;

@property (nonatomic,strong)UIButton *topButton;

@property (nonatomic,strong)UIButton *bottomButton;

@property (nonatomic,strong)NSLayoutConstraint *topLayoutConstraint;

@property (nonatomic,strong)NSLayoutConstraint *bottomLayoutConstraint;

@property (nonatomic,strong)NSTimer *timer;

@property (nonatomic,strong)NSMutableArray *myTextArray;

@property (nonatomic,copy)void (^myFuntion)(NSInteger selected);
@end




@implementation MKShufflingView
- (UIButton *)topButton{
    if (!_topButton) {
        self.topButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        self.topButton.tag = 1;
        [_topButton addTarget:self action:@selector(handleAction:) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _topButton;
}
- (UIButton *)bottomButton{
    if (!_bottomButton) {
        self.bottomButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        self.bottomButton.tag = 2;
    }
    return _bottomButton;
}
- (UIButton *)upButton{
    if (!_upButton) {
        self.upButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        self.upButton.tag = 3;
    }
    return _upButton;
}
- (void)initShufflingView:(void (^)(NSInteger selected))completion{
    [self layoutIfNeeded];
    self.clipsToBounds = YES;
    self.myTextArray = [NSMutableArray array];
    [self LayoutOfTheData];
    [self addMySubview];
    [self showView];
    [self addtimer];
    [self addMyGestureRecognizer];
    if (completion) {
        self.myFuntion = completion;
    }
}
- (void)updateMyShufflingView{
    [self removeMyConstraints];
    [self LayoutOfTheData];
    [self addMySubview];
    [self showView];
    [self addtimer];
}
- (void)removeMyConstraints{
    [self.topButton removeFromSuperview];
    [self.upButton removeFromSuperview];
    [self.bottomButton removeFromSuperview];
     self.bottomButton = nil;
     self.topButton = nil;
     self.upButton = nil;
    [self setNeedsLayout];
}
- (void)handleAction:(UIButton *)sender{
    self.myFuntion(self.MYslidingPositiveOrNegative == slidingPositive ?self.selected:[self.myTextArray indexOfObject:self.textArray[self.selected]]);
    if (_slidingOverBlock) {
        self.slidingOverBlock(self.MYslidingPositiveOrNegative == slidingPositive ?self.selected:[self.myTextArray indexOfObject:self.textArray[self.selected]]);
    }
}
- (void)showView{
    if (self.MYshufflingViewShowstyle == shufflingViewShowstyleText) {
        [self.topButton setTitle:self.myTextArray[self.selected] forState:(UIControlStateNormal)];
        [self.bottomButton setTitle:self.MYslidingPositiveOrNegative == slidingPositive ?(self.myTextArray[self.selected+1==self.myTextArray.count?0:self.selected+1]):(self.myTextArray[self.selected-1 < 0?self.myTextArray.count -1:self.selected-1]) forState:(UIControlStateNormal)];
        [self.upButton setTitle:self.MYslidingPositiveOrNegative == slidingPositive ?(self.myTextArray[self.selected-1 < 0?self.myTextArray.count -1:self.selected-1]):(self.myTextArray[self.selected+1==self.myTextArray.count?0:self.selected+1]) forState:(UIControlStateNormal)];
    }else{
        [self.topButton setImage:[UIImage imageNamed:self.myTextArray[self.selected]] forState:(UIControlStateNormal)];
        [self.bottomButton setImage:[UIImage imageNamed:self.MYslidingPositiveOrNegative == slidingPositive ?(self.myTextArray[self.selected+1==self.myTextArray.count?0:self.selected+1]):(self.myTextArray[self.selected-1 < 0?self.myTextArray.count -1:self.selected-1])] forState:(UIControlStateNormal)];
        [self.upButton setImage:[UIImage imageNamed:self.MYslidingPositiveOrNegative == slidingPositive ?(self.myTextArray[self.selected-1 < 0?self.myTextArray.count -1:self.selected-1]):(self.myTextArray[self.selected+1==self.myTextArray.count?0:self.selected+1])] forState:(UIControlStateNormal)];
    }
}
- (void)addMyGestureRecognizer{
    UIPanGestureRecognizer *panGesture;
    panGesture = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipeFrom:)];
    [self addGestureRecognizer:panGesture];
}
-(void)handleSwipeFrom:(UIPanGestureRecognizer *)panGesture{
    CGPoint point = [panGesture translationInView:self];
    [self.timer invalidate];
    self.topLayoutConstraint.constant =self.MYslidingDirection == slidingDirectionV? point.y:point.x;
    if ((self.MYslidingDirection == slidingDirectionV?fabs(point.y):fabs(point.x)) > (self.MYslidingDirection == slidingDirectionV? self.bounds.size.height/3:self.bounds.size.width/3)) {
        if (panGesture.state == UIGestureRecognizerStateEnded) {
            [panGesture setTranslation:CGPointMake(0, 0) inView:self];
            if ((self.MYslidingDirection == slidingDirectionV?point.y:point.x) < 0) {
                self.MYslidingPositiveOrNegative == slidingNegative? self.selected -- : self.selected++;
                [self subviewSliding: self.MYslidingPositiveOrNegative == slidingNegative? NO:YES];
                return;
            }
            if ((self.MYslidingDirection == slidingDirectionV?point.y:point.x) > 0) {
                self.MYslidingPositiveOrNegative == slidingNegative? self.selected ++:self.selected--;
                [self subviewSliding: self.MYslidingPositiveOrNegative == slidingNegative? YES:NO];
                return;
            }
        }
    }else{
        if (panGesture.state == UIGestureRecognizerStateEnded) {
            [UIView animateWithDuration:0.5f animations:^{
                self.topLayoutConstraint.constant = 0;
                [self layoutIfNeeded];
                [self addtimer];
            }];
        }
    }
}
- (void)addtimer{
    if (!self.isAutomatic) {
        [self.timer invalidate];
        return;
    }
    if (!self.timer.valid && self.isAutomatic) {
        self.timer = [NSTimer timerWithTimeInterval:self.countdown?self.countdown:5 target:self selector:@selector(startTheAnimation:) userInfo:nil repeats:YES];
        [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSDefaultRunLoopMode];
    }
}
- (void)subviewSliding:(BOOL)isUp{
    if (self.selected < 0) {
        self.selected = self.textArray.count-1;
    }
    if (self.selected == self.textArray.count) {
        self.selected = 0;
    }
    [UIView animateWithDuration:.5f animations:^{
        if (isUp) {
            self.topLayoutConstraint.constant = self.MYslidingDirection == slidingDirectionV? (self.MYslidingPositiveOrNegative == slidingPositive ?- self.bounds.size.height:self.bounds.size.height):(self.MYslidingPositiveOrNegative == slidingPositive ?- self.bounds.size.width:self.bounds.size.width);
        }else
        {
            self.topLayoutConstraint.constant = self.MYslidingDirection == slidingDirectionV? (self.MYslidingPositiveOrNegative == slidingPositive ?self.bounds.size.height:-self.bounds.size.height):(self.MYslidingPositiveOrNegative == slidingPositive ?self.bounds.size.width:-self.bounds.size.width);
        }
        [self layoutIfNeeded];
        
    } completion:^(BOOL finished) {
        [self showView];
        self.topLayoutConstraint.constant = 0;
        if (self.slidingOverBlock) {
            self.slidingOverBlock(self.selected);
        }
        [self layoutIfNeeded];
        [self addtimer];
    }];
}
- (void)startTheAnimation:(NSTimer *)timer{
    self.selected ++;
    [self subviewSliding:YES];
}

- (void)addMySubview{
    [self addSubview:self.topButton];
    [self addSubview:self.bottomButton];
    [self addSubview:self.upButton];
    NSLog(@"%f",self.bounds.size.height);
    self.topButton.translatesAutoresizingMaskIntoConstraints = NO;
    NSArray *constraints1=[NSLayoutConstraint constraintsWithVisualFormat:self.MYslidingDirection == slidingDirectionV?@"H:|-0-[button]-0-|":@"V:|-0-[button]-0-|" options:0 metrics:nil views:@{@"button":self.topButton}];
    NSArray *constraints2=[NSLayoutConstraint constraintsWithVisualFormat:self.MYslidingDirection == slidingDirectionV?@"V:|-0-[button(==width)]":@"H:|-0-[button(==height)]" options:0 metrics:@{@"width":@(self.bounds.size.height),@"height":@(self.bounds.size.width)} views:@{@"button":self.topButton}];
    [self addConstraints:constraints1];
    [self addConstraints:constraints2];
    [self.topButton setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    self.bottomButton.translatesAutoresizingMaskIntoConstraints = NO;
    NSArray *constraints3=[NSLayoutConstraint constraintsWithVisualFormat:self.MYslidingDirection == slidingDirectionV?@"H:|-0-[button]-0-|":@"V:|-0-[button]-0-|" options:0 metrics:nil views:@{@"button":self.bottomButton}];
    NSArray *constraints4=[NSLayoutConstraint constraintsWithVisualFormat:self.MYslidingDirection == slidingDirectionV?@"V:[button2]-0-[button(==width)]":@"H:[button2]-0-[button(==height)]" options:0 metrics:@{@"width":@(self.bounds.size.height),@"height":@(self.bounds.size.width)} views:@{@"button":self.bottomButton,@"button2":self.topButton}];
    [self addConstraints:constraints3];
    [self addConstraints:constraints4];
    [self.topButton setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    [self.bottomButton setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    [self.upButton setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    for (NSLayoutConstraint *layout in constraints2) {
        if ([layout.secondItem isEqual:self]) {
            self.topLayoutConstraint = layout;
        }
    }
    self.upButton.translatesAutoresizingMaskIntoConstraints = NO;
    NSArray *constraints5=[NSLayoutConstraint constraintsWithVisualFormat:self.MYslidingDirection == slidingDirectionV?@"H:|-0-[button]-0-|":@"V:|-0-[button]-0-|" options:0 metrics:nil views:@{@"button":self.upButton}];
    NSArray *constraints6=[NSLayoutConstraint constraintsWithVisualFormat:self.MYslidingDirection == slidingDirectionV?@"V:[button(==width)]-0-[button1]":@"H:[button(==height)]-0-[button1]" options:0 metrics:@{@"width":@(self.bounds.size.height),@"height":@(self.bounds.size.width)} views:@{@"button":self.upButton,@"button1":self.topButton}];
    [self addConstraints:constraints5];
    [self addConstraints:constraints6];
}
- (void)LayoutOfTheData{

    if (self.MYslidingPositiveOrNegative == slidingPositive) {
        self.myTextArray = [self.textArray copy];
    }else{
        for (NSInteger i = self.textArray.count - 1;i>=0 ;i--) {
            [self.myTextArray addObject:self.textArray[i]];
        }
    }
}



@end
