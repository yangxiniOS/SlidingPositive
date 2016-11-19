//
//  MKpageStyle.m
//  shufflingDemo
//
//  Created by 杨鑫 on 2016/11/18.
//  Copyright © 2016年 Mr Yang. All rights reserved.
//

#import "MKpageStyle.h"
#import "MKShufflingView.h"



@implementation MKpageStyle


- (instancetype)init
{
    self = [super init];
    if (self) {
        
        [self defaultStyle];
    }
    return self;
}

- (void)defaultStyle{
    /**
     *  圆点大小
     */
    self.styleSize = CGSizeMake(10, 10);
    /**
     *  圆角大小
     */
    self.roundedCorners = 5.f;
    /**
     *  选中圆角大小
     */
    self.currentRoundedCorners = 5.f;
    /**
     *  文本距离边界多少 显示文本 目前只支持pageControl 居上下且原点局左右 设置有效
     */
    self.border = 12;
    /**
     *  圆点之间的间距
     */
    self.spacingValue = 10;
    /**
     *  选中的圆点大小
     */
    self.currentSize = CGSizeMake(10, 10);
    /**
     *  page的整体高度
     */
    self.pageHeight = 20;
    /**
     *  居page边界多少 由myPageStyle决定  只针对对据左据右 居中时设置此值无效
     */
    self.constant = 20;
    /**
     *  圆点的位置
     */
    self.myDotStyle = MKDotStyleLocationCenter;
    /**
     *  page的位置
     */
    self.myPageStyle = MKpageStyleLocationBottom;
    /**
     *  page距离边界多少
     */
     self.distance = 0;
    /**
     *  page背景颜色
     */
    self.backGroundColor = [UIColor grayColor];
    /**
     *  圆点颜色
     */
    self.styleColor = [UIColor whiteColor];
    /**
     *  选中圆点颜色
     */
    self.currentColor = [UIColor greenColor];
    /**
     *  文字字体颜色
     */
    self.styleTextColor = [UIColor blackColor];
    /**
     *  选中文字字体颜色
     */
    self.currentTextColor = [UIColor whiteColor];
    /**
     *  是否支持点击切换
     */
    self.isClick = YES;
    /**
     *  文本颜色 显示文本 目前只支持pageControl 居上下且原点局左右 设置有效
     */
    self.titleColor = [UIColor whiteColor];
    /**
     *  只有设置圆点格式为MKDotStyleText有效 设置文本大小
     */
    self.fount = 14;
}
@end

#import <objc/runtime.h>



@class MKGetView;
@implementation UIButton (UIbuttonExtention)



static char *UIbuttonNameKey = "UIbuttonNameKey";
- (void)setExtentionView:(UIView *)extentionView{
    objc_setAssociatedObject(self, UIbuttonNameKey, extentionView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    for (MKGetView *view in self.subviews) {
        [view removeFromSuperview];
    }
    extentionView.userInteractionEnabled = NO;
    extentionView.frame = self.bounds;
    [self addSubview:extentionView];
}
- (UIView *)extentionView{
    return objc_getAssociatedObject(self, UIbuttonNameKey);
}
@end


@implementation NSTimer (NSTimerExtention)

+ (NSTimer *)ez_scheduledTimerWithTimeInterval:(NSTimeInterval)inTimeInterval block:(void (^)())inBlock repeats:(BOOL)inRepeats
{
    void (^block)() = [inBlock copy];
    NSTimer * timer = [self scheduledTimerWithTimeInterval:inTimeInterval target:self selector:@selector(__executeTimerBlock:) userInfo:block repeats:inRepeats];
    return timer;
}

+ (NSTimer *)ez_timerWithTimeInterval:(NSTimeInterval)inTimeInterval block:(void (^)())inBlock repeats:(BOOL)inRepeats
{
    void (^block)() = [inBlock copy];
    NSTimer * timer = [self timerWithTimeInterval:inTimeInterval target:self selector:@selector(__executeTimerBlock:) userInfo:block repeats:inRepeats];
    return timer;
}

+ (void)__executeTimerBlock:(NSTimer *)inTimer
{
    if([inTimer userInfo])
    {
        void (^block)() = (void (^)())[inTimer userInfo];
        block();
    }
}
@end

