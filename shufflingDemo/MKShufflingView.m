//
//  MKShufflingView.m
//  lianxiceshi
//
//  Created by 杨鑫 on 2016/11/16.
//  Copyright © 2016年 杨鑫. All rights reserved.
//

#import "MKShufflingView.h"
#import "UIButton+WebCache.h"



@interface MKShufflingView ()

@property (nonatomic,strong)UIButton *upButton;

@property (nonatomic,strong)UIButton *topButton;

@property (nonatomic,strong)UIButton *bottomButton;

@property (nonatomic,strong)NSLayoutConstraint *topLayoutConstraint;

@property (nonatomic,strong)NSLayoutConstraint *bottomLayoutConstraint;

@property (nonatomic,strong)NSTimer *timer;

@property (nonatomic,strong)NSMutableArray *myTextArray;

@property (nonatomic,copy)void (^myFuntion)(NSInteger selected);

@property (nonatomic,strong)MKMyPageControl *myPageControl;
@end




@implementation MKShufflingView
- (UIButton *)topButton{
    if (!_topButton) {
        self.topButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
         _topButton.tag = 1;
        [_topButton addTarget:self action:@selector(handleAction:) forControlEvents:(UIControlEventTouchUpInside)];
        _topButton.adjustsImageWhenHighlighted = NO;
        _topButton.titleLabel.numberOfLines = 0;
        
    }
    return _topButton;
}
- (UIButton *)bottomButton{
    if (!_bottomButton) {
        self.bottomButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _bottomButton.tag = 2;
        _bottomButton.titleLabel.numberOfLines = 0;
        _bottomButton.adjustsImageWhenHighlighted = NO;
        
    }
    return _bottomButton;
}
- (UIButton *)upButton{
    if (!_upButton) {
        self.upButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _upButton.tag = 3;
        _upButton.titleLabel.numberOfLines = 0;
        _upButton.adjustsImageWhenHighlighted = NO;
       
    }
    return _upButton;
}
- (void)initShufflingView:(void (^)(NSInteger selected))completion{
    [self layoutIfNeeded];
    self.clipsToBounds = YES;
    self.myTextArray = [NSMutableArray array];
    [self LayoutOfTheData];
    [self addMySubview];
    [self addMyPageControl];
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
    [self addMyPageControl];
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
- (void)addMyPageControl{
    if (self.isShowMyPage) {
        self.myPageControl  = [[MKMyPageControl alloc]init];
        if (!self.mypageStyle) {
            self.mypageStyle = [[MKpageStyle alloc]init];
        }
        self.myPageControl.mypageStyle = self.mypageStyle;
        self.myPageControl.textArray = self.textArray;
        self.myPageControl.current = self.selected;
        self.myPageControl.titleArray = self.titleArray;
        __weak typeof(self) weakSelf = self;
        self.myPageControl.myFunction = ^(BOOL isSequence){
            [weakSelf.timer invalidate];
            if (isSequence) {
                weakSelf.selected ++;
                [weakSelf subviewSliding:YES];
            }else{
                weakSelf.selected --;
                [weakSelf subviewSliding:NO];
            }
        };
        [self addSubview:self.myPageControl];
        [self addMyPageControlDetails];
        [self.myPageControl initMKMyPageControlView];
    }else{
        if (!self.isShowMyPage) {
            [self.myPageControl removeFromSuperview];
            self.myPageControl = nil;
            [self setNeedsLayout];
        }
    }
}
- (void)addMyPageControlDetails{
    self.myPageControl.translatesAutoresizingMaskIntoConstraints = NO;
    if (self.mypageStyle.myPageStyle == MKpageStyleLocationBottom || self.mypageStyle.myPageStyle == MKpageStyleLocationUp) {
        NSArray *array = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[page]-0-|" options:0 metrics:nil views:@{@"page":self.myPageControl}];
        NSArray *array1 = [NSLayoutConstraint constraintsWithVisualFormat:self.mypageStyle.myPageStyle == MKpageStyleLocationBottom ? @"V:[page(==height)]-distance-|":@"V:|-distance-[page(==height)]" options:0 metrics:@{@"height":@(self.mypageStyle.pageHeight),@"distance":@(self.mypageStyle.distance)} views:@{@"page":self.myPageControl}];
        [self addConstraints:array];
        [self addConstraints:array1];
    }
    if (self.mypageStyle.myPageStyle == MKpageStyleLocationLeft || self.mypageStyle.myPageStyle == MKpageStyleLocationRight) {
        NSArray *array = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[page]-0-|" options:0 metrics:nil views:@{@"page":self.myPageControl}];
        NSArray *array1 = [NSLayoutConstraint constraintsWithVisualFormat:self.mypageStyle.myPageStyle == MKpageStyleLocationLeft?@"H:|-distance-[page(==height)]":@"H:[page(==height)]-distance-|"  options:0 metrics:@{@"height":@(self.mypageStyle.pageHeight),@"distance":@(self.mypageStyle.distance)} views:@{@"page":self.myPageControl}];
        [self addConstraints:array];
        [self addConstraints:array1];
    }
    [self.myPageControl layoutIfNeeded];
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
        [_topButton setTitleColor:self.textColor forState:(UIControlStateNormal)];
        [_bottomButton setTitleColor:self.textColor forState:(UIControlStateNormal)];
        [_upButton setTitleColor:self.textColor forState:(UIControlStateNormal)];
    }else{
        if (self.isUrlImage) {
            [self.topButton sd_setImageWithURL:[NSURL URLWithString:self.myTextArray[self.selected]] forState:(UIControlStateNormal) placeholderImage:self.placeholderImage];
            [self.bottomButton sd_setImageWithURL:[NSURL URLWithString:self.MYslidingPositiveOrNegative == slidingPositive ?(self.myTextArray[self.selected+1==self.myTextArray.count?0:self.selected+1]):(self.myTextArray[self.selected-1 < 0?self.myTextArray.count -1:self.selected-1])] forState:(UIControlStateNormal)placeholderImage:self.placeholderImage];
            [self.upButton sd_setImageWithURL:[NSURL URLWithString: self.MYslidingPositiveOrNegative == slidingPositive ?(self.myTextArray[self.selected-1 < 0?self.myTextArray.count -1:self.selected-1]):(self.myTextArray[self.selected+1==self.myTextArray.count?0:self.selected+1])] forState:(UIControlStateNormal)placeholderImage:self.placeholderImage];
            
        }else{
            [self.topButton setImage:[UIImage imageNamed:self.myTextArray[self.selected]] forState:(UIControlStateNormal)];
            [self.bottomButton setImage:[UIImage imageNamed:self.MYslidingPositiveOrNegative == slidingPositive ?(self.myTextArray[self.selected+1==self.myTextArray.count?0:self.selected+1]):(self.myTextArray[self.selected-1 < 0?self.myTextArray.count -1:self.selected-1])] forState:(UIControlStateNormal)];
            [self.upButton setImage:[UIImage imageNamed:self.MYslidingPositiveOrNegative == slidingPositive ?(self.myTextArray[self.selected-1 < 0?self.myTextArray.count -1:self.selected-1]):(self.myTextArray[self.selected+1==self.myTextArray.count?0:self.selected+1])] forState:(UIControlStateNormal)];
        }
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
        if (self.isShowMyPage) {
           self.myPageControl.current = self.selected;
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




//------------------------------------华丽丽的分割线--------------------------------------------






@interface MKMyPageControl ()




@property (nonatomic,strong)NSMutableArray *dotArray;


@property (nonatomic,strong)NSLayoutConstraint *myLayoutConstraint1;

@property (nonatomic,strong)NSLayoutConstraint *myLayoutConstraint2;

@property (nonatomic,strong)UILabel *titleLabel;
@end



@implementation MKMyPageControl
- (void)dealloc{
    [self removeObserver:self forKeyPath:@"current"];
}

- (void)initMKMyPageControlView{
    self.backgroundColor = self.mypageStyle.backGroundColor;
    self.dotArray = [NSMutableArray array];
    [self addMySubview];
    [self updateCurrentDot:self.current];
    [self addObserver:self forKeyPath:@"current" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
}

- (void)addMySubview{
    NSLayoutConstraint *layoutConstraintHV;
    NSLayoutConstraint *layoutConstraintBT;
    for (NSInteger i = 0; i < self.textArray.count; i++) {
        UIButton *button = [UIButton buttonWithType:(UIButtonTypeCustom)];
        button.adjustsImageWhenHighlighted = NO;
        button.translatesAutoresizingMaskIntoConstraints = NO;
        button.layer.masksToBounds = YES;
        button.userInteractionEnabled = NO;
        button.enabled = YES;
        button.backgroundColor = self.mypageStyle.styleColor;
        button.titleLabel.font = [UIFont systemFontOfSize:self.mypageStyle.fount];
        [self addSubview:button];
        if (self.mypageStyle.myDotFillStyle == MKDotStyleImage) {
            NSLayoutConstraint *la1 =  [NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0.0 constant:self.mypageStyle.currentSize.width];
            NSLayoutConstraint *la2 =  [NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0.0 constant:self.mypageStyle.currentSize.height];
            button.layer.cornerRadius = self.mypageStyle.roundedCorners;
            if (i == self.current) {
                la1.constant = self.mypageStyle.currentSize.width;
                la2.constant = self.mypageStyle.currentSize.height;
                button.layer.cornerRadius = self.mypageStyle.currentRoundedCorners;
            }
            
            [self addConstraints:@[la1,la2]];
        }else{
            NSLayoutConstraint *la2 =  [NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0.0 constant:self.mypageStyle.styleSize.height];
            NSLayoutConstraint *la1 =  [NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0.0 constant:self.mypageStyle.styleSize.width];
            if (i == self.current) {
                la1.constant = self.mypageStyle.currentSize.width;
                la2.constant = self.mypageStyle.currentSize.height;
                button.layer.cornerRadius = self.mypageStyle.currentRoundedCorners;
            }else{
                button.layer.cornerRadius = self.mypageStyle.roundedCorners;
            }
            [self addConstraint:la1];
            [self addConstraint:la2];
            if (self.mypageStyle.titleArray.count) {
                [self removeConstraint:la1];
            }
        }
            if (self.mypageStyle.myPageStyle == MKpageStyleLocationBottom
            ||self.mypageStyle.myPageStyle == MKpageStyleLocationUp) {
            [self addConstraint:[NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1 constant:0]];
            UIView *v1 = layoutConstraintHV.firstItem;
            if (!v1) {
                switch (self.mypageStyle.myDotStyle) {
                    case MKDotStyleLocationCenter:
                       layoutConstraintHV = [NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1 constant:0];
                        break;
                    case MKDotStyleLocationLeft:
                        layoutConstraintHV = [NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1 constant:self.mypageStyle.constant];
                        break;
                    case MKDotStyleLocationRight:
                        layoutConstraintHV = [NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1 constant:-self.mypageStyle.constant];
                        break;
                    default:
                        break;
                }
                self.myLayoutConstraint1 = layoutConstraintHV;
                [self addConstraint:self.myLayoutConstraint1];
            }else{
                if (self.mypageStyle.myDotStyle == MKDotStyleLocationRight) {
                  layoutConstraintHV = [NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:v1 attribute:NSLayoutAttributeLeft multiplier:1 constant:-self.mypageStyle.spacingValue];
                }else{
                   layoutConstraintHV = [NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:v1 attribute:NSLayoutAttributeRight multiplier:1 constant:self.mypageStyle.spacingValue];
                }
                [self addConstraint:layoutConstraintHV];
            }
        }
        if (self.mypageStyle.myPageStyle == MKpageStyleLocationLeft
            ||self.mypageStyle.myPageStyle == MKpageStyleLocationRight) {
            [self addConstraint:[NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];
            UIView *v1 = layoutConstraintBT.firstItem;
            if (!v1) {
                switch (self.mypageStyle.myDotStyle) {
                    case MKDotStyleLocationCenter:
                        layoutConstraintBT = [NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1 constant:0];
                        break;
                    case MKDotStyleLocationLeft:
                        layoutConstraintBT = [NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1 constant:self.mypageStyle.constant];
                        break;
                    case MKDotStyleLocationRight:
                        layoutConstraintBT = [NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1 constant:-self.mypageStyle.constant];
                        break;
                    default:
                        break;
                }
                self.myLayoutConstraint2 = layoutConstraintBT;
                [self addConstraint:self.myLayoutConstraint2];
            }else{
                if (self.mypageStyle.myDotStyle == MKDotStyleLocationRight) {
                    layoutConstraintBT = [NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:v1 attribute:NSLayoutAttributeTop multiplier:1 constant:-self.mypageStyle.spacingValue];
                }else{
                    layoutConstraintBT = [NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:v1 attribute:NSLayoutAttributeBottom multiplier:1 constant:self.mypageStyle.spacingValue];
                }
                [self addConstraint:layoutConstraintBT];
            }
        }
        [self.dotArray addObject:button];
        [button layoutIfNeeded];
    }
    NSMutableArray *a = [NSMutableArray array];
    for (NSInteger i = self.dotArray.count - 1; i >= 0; i--) {
        [a addObject:self.dotArray[i]];
    }
    if (self.mypageStyle.myDotStyle == MKDotStyleLocationRight ) {
        self.dotArray = a;
    }
    UIButton *button = self.dotArray.firstObject;
    if (self.mypageStyle.myPageStyle == MKpageStyleLocationBottom
        ||self.mypageStyle.myPageStyle == MKpageStyleLocationUp) {
        if (self.mypageStyle.myDotStyle == MKDotStyleLocationCenter) {
            self.myLayoutConstraint1.constant = -((self.textArray.count) * button.bounds.size.width + (self.textArray.count)* self.mypageStyle.spacingValue)/2;
        }
        [self addTitileView];
    }
    if (self.mypageStyle.myPageStyle == MKpageStyleLocationRight
        ||self.mypageStyle.myPageStyle == MKpageStyleLocationLeft) {
        if (self.mypageStyle.myDotStyle == MKDotStyleLocationCenter) {
            self.myLayoutConstraint2.constant = -((self.textArray.count - 1) * button.bounds.size.height + (self.textArray.count - 1) * self.mypageStyle.spacingValue)/2;
        }
    }
}
- (void)addTitileView{
    if (self.titleArray.count) {
        self.titleLabel = [[UILabel alloc]init];
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
        self.titleLabel.textColor = self.mypageStyle.titleColor;
        [self addSubview:self.titleLabel];
        if (self.mypageStyle.myPageStyle == MKpageStyleLocationBottom
            ||self.mypageStyle.myPageStyle == MKpageStyleLocationUp) {
            if (self.mypageStyle.myDotStyle == MKDotStyleLocationLeft) {
                [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[titleLabel]-0-|" options:0 metrics:nil views:@{@"titleLabel":self.titleLabel}]];
                [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[button]-0-[titleLabel]-border-|" options:0 metrics:@{@"border":@(self.mypageStyle.border)} views:@{@"titleLabel":self.titleLabel,@"button":self.dotArray.lastObject}]];
                [self.titleLabel layoutIfNeeded];
                self.titleLabel.textAlignment = NSTextAlignmentRight;
            }
            if (self.mypageStyle.myDotStyle == MKDotStyleLocationRight) {
                [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[titleLabel]-0-|" options:0 metrics:nil views:@{@"titleLabel":self.titleLabel}]];
                [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-border-[titleLabel]-0-[button]" options:0 metrics:@{@"border":@(self.mypageStyle.border)} views:@{@"titleLabel":self.titleLabel,@"button":self.dotArray.firstObject}]];
                [self.titleLabel layoutIfNeeded];
                self.titleLabel.textAlignment = NSTextAlignmentLeft;
            }
        }
    }
}
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:@"current"]) {
        NSInteger current =[[change objectForKey:@"new"] integerValue];
        [self updateCurrentDot:current];
    }
}
- (void)updateCurrentDot:(NSInteger)current{
   for (NSInteger i = 0; i < self.dotArray.count; i++) {
        UIButton * button = (UIButton *)self.dotArray[i];
        if (i == current) {
            //当前的和传入的一样
            button.backgroundColor = self.mypageStyle.currentColor;
            button.bounds = CGRectMake(0, 0, self.mypageStyle.currentSize.width, self.mypageStyle.currentSize.height);
            if (self.mypageStyle.myDotFillStyle == MKDotStyleText) {
                [button setTitle:[NSString stringWithFormat:@"%ld",i] forState:(UIControlStateNormal)];
                if (self.mypageStyle.titleArray.count) {
                    [button setTitle:self.mypageStyle.titleArray[i] forState:(UIControlStateNormal)];
                }else{
                    button.layer.cornerRadius = self.mypageStyle.currentRoundedCorners;
                    button.bounds = CGRectMake(button.bounds.origin.x, button.bounds.origin.y, self.mypageStyle.currentSize.width, self.mypageStyle.currentSize.height);
                }
                [button setTitleColor:self.mypageStyle.currentTextColor forState:(UIControlStateNormal)];
            }if (self.mypageStyle.myDotFillStyle == MKDotStyleImage) {
                [button setImage:self.mypageStyle.currentImage forState:(UIControlStateNormal)];
            }
        }else{
            button.backgroundColor = self.mypageStyle.styleColor;
            button.bounds = CGRectMake(0, 0, self.mypageStyle.styleSize.width, self.mypageStyle.styleSize.height);
            if (self.mypageStyle.myDotFillStyle == MKDotStyleText) {
                [button setTitle:[NSString stringWithFormat:@"%ld",i] forState:(UIControlStateNormal)];
                if (self.mypageStyle.titleArray.count) {
                    [button setTitle:self.mypageStyle.titleArray[i] forState:(UIControlStateNormal)];
                }else{
                    button.layer.cornerRadius = self.mypageStyle.roundedCorners;
                    button.bounds = CGRectMake(button.bounds.origin.x, button.bounds.origin.y, self.mypageStyle.styleSize.width, self.mypageStyle.styleSize.height);
                }
                [button setTitleColor:self.mypageStyle.styleTextColor forState:(UIControlStateNormal)];
            }if (self.mypageStyle.myDotFillStyle == MKDotStyleImage) {
                [button setImage:self.mypageStyle.styleImage forState:(UIControlStateNormal)];
            }
        }
    }
    if (self.titleLabel) {
        self.titleLabel.text = self.titleArray[current];
    }
    if (self.mypageStyle.titleArray.count) {
        for (UIView *view in self.subviews) {
            [view layoutIfNeeded];
        }
    }
}



- (void)endTrackingWithTouch:(nullable UITouch *)touch withEvent:(nullable UIEvent *)event{
    NSSet *mytouch = [event allTouches];
    UITouch *t = [mytouch anyObject];
    CGPoint point = [touch locationInView:[t view]];
    UIButton *but = (UIButton *)self.dotArray[self.dotArray.count/2];
    if (self.mypageStyle.isClick) {
        if (_myFunction) {
            if (self.mypageStyle.myPageStyle == MKpageStyleLocationBottom
                ||self.mypageStyle.myPageStyle == MKpageStyleLocationUp) {
                if (point.x > but.frame.origin.x) {
                   self.myFunction(YES);
                }else {
                    self.myFunction(NO);
                }
            }
            if (self.mypageStyle.myPageStyle == MKpageStyleLocationRight
                ||self.mypageStyle.myPageStyle == MKpageStyleLocationLeft) {
                if (point.y >  but.frame.origin.y) {
                    self.myFunction(YES);
                }else {
                    self.myFunction(NO);
                }
            }
        }
    }
}



@end


