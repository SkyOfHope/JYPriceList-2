//
//  LeftTableViewCell.m
//  JYPriceList
//
//  Created by jiangkuiquan on 2018/11/6.
//  Copyright © 2018年 jiangkuiquan. All rights reserved.
//

#import "LeftTableViewCell.h"

#import "MallSecondFilterListModel.h"

@interface LeftTableViewCell()
@property (weak, nonatomic) IBOutlet UILabel *nameLab;

@end

@implementation LeftTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    
    [shapeLayer setBounds:self.bounds];
    
    [shapeLayer setPosition:self.center];
    
    [shapeLayer setFillColor:[UIColor redColor].CGColor];
    
    //设置虚线颜色为blackColor
//    [shapeLayer setStrokeColor:RGBA(230, 230, 230, 1).CGColor];
    [shapeLayer setStrokeColor:[UIColor darkGrayColor].CGColor];
    
    //设置虚线的高度
    [shapeLayer setLineWidth:1.0];
    [shapeLayer setLineJoin:kCALineJoinRound];
    
    //3=线的宽度 1=每条线的间距
    [shapeLayer setLineDashPattern:[NSArray arrayWithObjects:[NSNumber numberWithInt:6], [NSNumber numberWithInt:3],nil]];
    
    //设置路径
    //创建一个path句柄
    CGMutablePathRef path =CGPathCreateMutable();
    
    //初始化该path到一个初始点
    CGPathMoveToPoint(path,NULL, 10,38);
    
    //添加一条直线,从初始点到该函数指定的终点
    CGPathAddLineToPoint(path, NULL, ScreenWidth - 10, 38);
    
    [shapeLayer setPath:path];
    
    CGPathRelease(path);
    
    //  把绘制好的虚线添加上来
    
    [self.layer addSublayer:shapeLayer];
    
}

-(void)buildWithModel:(MallSecondFilterListModel *)model{
    
    self.nameLab.text = model.value;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
