//
//  MKShufflingView.h
//  lianxiceshi
//
//  Created by 杨鑫 on 2016/11/16.
//  Copyright © 2016年 杨鑫. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MKpageStyle.h"

/**
 *  展示样式
 */
typedef NS_ENUM(NSInteger, shufflingViewShowstyle) {
    /**
     *  文字轮播形式
     */
    shufflingViewShowstyleText= 0,
    /**
     *  图片轮播形式
     */
    shufflingViewShowstyleImageView,
    /**
     *  自定义view形式
     */
    shufflingViewShowstyleView
};
/**
 *  滑动样式
 */
typedef NS_ENUM(NSInteger, slidingDirection) {
    /**
     *  水平滑动
     */
    slidingDirectionH = 0,
    /**
     *  数值滑动
     */
    slidingDirectionV
};
/**
 *  正反方向
 */
typedef NS_ENUM(NSInteger, slidingPositiveOrNegative) {
    /**
     *  正方向
     */
     slidingPositive = 0,
    /**
     *  反方向
     */
     slidingNegative
};


@interface MKShufflingView : UIView
/**
 *  当前传入过来的字符串数组
 */
@property (nonatomic,strong)NSArray *textArray;
/**
 *  显示文本 目前只支持pageControl 居上下且原点局左右 如果该数组不为空则判断需要显示文本指示器
 */
@property (nonatomic,strong)NSArray *titleArray;
/**
 *  传入的是图片地址 如果是网络图片必须设置为yes，依赖第三方SDWebImage 默认为非为加载本地图片
 */
@property (nonatomic,assign) BOOL isUrlImage;
/**
 *  如果是文字轮播文字颜色
 */
@property (nonatomic,strong) UIColor *textColor;
/**
 *  设置请求图片展位图
 */
@property (nonatomic,strong)UIImage *placeholderImage;
/**
 *  是否自动滚动 默认关闭滚动 为no
 */
@property (nonatomic,assign) BOOL isAutomatic;
/**
 *  设置当前所展示的是哪个 默认为0
 */
@property (nonatomic,assign)NSInteger selected;
/**
 *  设置当前倒计时时间 默认5秒
 */
@property (nonatomic,assign)NSInteger countdown;
/**
 *  样式（如果想要PageControl必传)
 */
@property (nonatomic,strong)MKpageStyle *mypageStyle;
/**
 *  是否需要PageControl（如果想要PageControl必传yes 默认为no)
 */
@property (nonatomic,assign) BOOL isShowMyPage;
/**
 *  滑动方向
 */
@property (nonatomic,assign)slidingDirection MYslidingDirection;
/**
 *  内容样式
 */
@property (nonatomic,assign)shufflingViewShowstyle MYshufflingViewShowstyle;
/**
 *  正反方向
 */
@property (nonatomic,assign)slidingPositiveOrNegative MYslidingPositiveOrNegative;
/**
 *  滑动完毕执行的block
 */
@property (nonatomic,copy)void (^slidingOverBlock)(NSInteger selected);
/**
 *  点击事件
 */
@property (nonatomic,copy)void (^openDownBlock)(NSInteger selected);
/**
 *  初始化
 *
 *  @param completion 点击哪一个
 */
- (void)initShufflingView:(void (^)(NSInteger selected))completion;
/**
 *  更新显示
 */
- (void)updateMyShufflingView;
@end







/**
 *  自定义PageControl
 */
@interface MKMyPageControl : UIControl


@property (nonatomic,strong)MKpageStyle *mypageStyle;

@property (nonatomic,strong)NSArray *textArray;

@property (nonatomic,strong)NSArray *titleArray;

@property (nonatomic,assign)NSInteger current;

@property (nonatomic,copy)void (^myFunction)(BOOL isSequence);
- (void)initMKMyPageControlView;
@end



@interface MKGetView : UIView



@end

