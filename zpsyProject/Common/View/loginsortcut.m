//
//  loginsortcut.m
//  ZPSY
//
//  Created by zhouhao on 2017/2/13.
//  Copyright © 2017年 zhouhao. All rights reserved.
//

#import "loginsortcut.h"

@implementation loginsortcut


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    
    NSString *str=@"快捷登录";
    CGFloat W= [str boundingRectWithSize:CGSizeMake(kScreenWidth, 15) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size.width;
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineCap(context, kCGLineCapRound);
    CGContextSetLineWidth(context, 1);  //线宽
    CGContextSetAllowsAntialiasing(context, true);
    CGContextSetRGBStrokeColor(context, 255.0 / 255.0, 255.0 / 255.0, 255.0 / 255.0, 1.0);  //线的颜色
    CGContextBeginPath(context);
    
    CGFloat YY=rect.size.height/2;
    CGContextMoveToPoint(context, 15, YY);  //起点坐标
    CGContextAddLineToPoint(context, (kScreenWidth/2-15-W/2), YY);   //终点坐标
    CGContextMoveToPoint(context, (kScreenWidth/2+15+W/2), YY);  //起点坐标
    CGContextAddLineToPoint(context, (kScreenWidth-15), YY);   //终点坐标
    CGContextStrokePath(context);
    
    [str drawWithRect:CGRectMake((kScreenWidth/2-W/2), 0, W, rect.size.height) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15],NSForegroundColorAttributeName:[UIColor colorWithRed:255.0/ 255.0 green:255.0/ 255.0 blue:255.0/ 255.0 alpha:1]} context:nil];
}


@end
