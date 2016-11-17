# SlidingPositive
一个强大的轮播实现。


支持图片轮播，文字轮播，正反序，水平竖直方向只需要赋值调用即可，即可实现无限轮播
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


