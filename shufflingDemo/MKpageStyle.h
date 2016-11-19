//
//  MKpageStyle.h
//  shufflingDemo
//
//  Created by 杨鑫 on 2016/11/18.
//  Copyright © 2016年 Mr Yang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>





/**
 *  page的位置
 */
typedef NS_ENUM(NSInteger, MKPageStyleLocation) {
    /**
     *  居下
     */
    MKpageStyleLocationBottom = 0,
    /**
     *  居上
     */
    MKpageStyleLocationUp,
    /**
     *  居左
     */
    MKpageStyleLocationLeft,
    /**
     *  居右
     */
    MKpageStyleLocationRight,
};
/**
 *  page圆点的位置
 */
typedef NS_ENUM(NSInteger, MKDotStyleLocation) {
    /**
     *  居中
     */
    MKDotStyleLocationCenter = 0,
    /**
     *  居边
     */
    MKDotStyleLocationLeft,
    /**
     *  居右
     */
    MKDotStyleLocationRight
};
/**
 *  圆点格式
 */
typedef NS_ENUM(NSInteger, MKDotFillStyle) {
    /**
     *  图片指示
     */
    MKDotStyleImage = 0,
    /**
     *  文字指示
     */
    MKDotStyleText,
    
};
@interface MKpageStyle : NSObject
/**
 *  圆点大小
 */
@property (nonatomic,assign)CGSize styleSize;
/**
 *  居page边界多少 由myPageStyle决定  只针对对据左据右 居中时设置此值无效 默认为20
 */
@property (nonatomic,assign)CGFloat constant;

/**
 *  选中的圆点大小
 */
@property (nonatomic,assign)CGSize currentSize;
/**
 *  圆角大小
 */
@property (nonatomic,assign)CGFloat roundedCorners;
/**
 *  选中圆角大小
 */
@property (nonatomic,assign)CGFloat currentRoundedCorners;
/**
 *  文本距离边界多少 显示文本 目前只支持pageControl 居上下且原点局左右 设置有效
 */
@property (nonatomic,assign)CGFloat border;
/**
 *  圆点之间的间距
 */
@property (nonatomic,assign)CGFloat spacingValue;
/**
 *  page的整体高度 或者宽度 由page的位置来确定
 */
@property (nonatomic,assign)CGFloat pageHeight;
/**
 *  当前选中的第几个
 */
@property (nonatomic,assign)NSInteger currentValue;
/**
 *  圆点图片
 */
@property (nonatomic,strong)UIImage *styleImage;
/**
 *  选中的圆点图片
 */
@property (nonatomic,strong)UIImage *currentImage;
/**
 *  圆点的位置
 */
@property (nonatomic,assign)MKDotStyleLocation myDotStyle;
/**
 *  page的位置
 */
@property (nonatomic,assign)MKPageStyleLocation myPageStyle;
/**
 *  圆点样式
 */
@property (nonatomic,assign)MKDotFillStyle myDotFillStyle;
/**
 *  page距离边界多少
 */
@property (nonatomic,assign)CGFloat distance;
/**
 *  page背景颜色
 */
@property (nonatomic,strong)UIColor *backGroundColor;
/**
 *  圆点颜色
 */
@property (nonatomic,strong)UIColor *styleColor;
/**
 *  选中圆点颜色
 */
@property (nonatomic,strong)UIColor *currentColor;
/**
 *  圆点文字颜色
 */
@property (nonatomic,strong)UIColor *styleTextColor;
/**
 *  选中圆点文字颜色
 */
@property (nonatomic,strong)UIColor *currentTextColor;
/**
 *  是否支持点击切换 默认支持
 */
@property (nonatomic,assign)BOOL isClick;
/**
 *  文本颜色 显示文本 目前只支持pageControl 居上下且原点局左右 设置有效
 */
@property (nonatomic,strong)UIColor *titleColor;
/**
 *  设置此值标示当前指示器是对应的文本 只有设置圆点格式为MKDotStyleText有效
 */
@property (nonatomic,strong)NSArray *titleArray;
/**
 *  只有设置圆点格式为MKDotStyleText有效 设置文本大小
 */
@property (nonatomic,assign)CGFloat fount;

@end
