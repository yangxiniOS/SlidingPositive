# SlidingPositive
一个强大的轮播实现。


支持图片轮播，文字轮播，正反序，水平竖直方向只需要赋值调用即可，即可实现无限轮播


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
    shufflingViewShowstyleImageView
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
 *  是否自动滚动 默认开启滚动
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
 *  滑动方向
 */
@property (nonatomic,assign)slidingDirection MYslidingDirection;
/**
 *  图片样式
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



如何调用

   self.shufflingView  = [[MKShufflingView alloc]initWithFrame:CGRectMake(0, 100, self.view.bounds.size.width, 100)];
    [self.view addSubview:self.shufflingView];
    self.shufflingView.backgroundColor = [UIColor redColor];
    self.shufflingView.textArray =@[@"1",@"2",@"3",@"4",@"5"];
    self.shufflingView.selected = 2;
    self.shufflingView.isAutomatic = YES;
    self.shufflingView.MYslidingDirection = slidingDirectionH;
    self.shufflingView.MYslidingPositiveOrNegative = slidingPositive;
    
    [self.shufflingView initShufflingView:^(NSInteger selected) {
        NSLog(@"%ld",selected);
    }];


