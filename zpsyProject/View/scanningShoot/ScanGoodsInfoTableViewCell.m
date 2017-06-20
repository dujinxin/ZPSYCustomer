//
//  ScanGoodsInfoTableViewCell.m
//  ZPSY
//
//  Created by 杜进新 on 2017/5/25.
//  Copyright © 2017年 zhouhao. All rights reserved.
//

#import "ScanGoodsInfoTableViewCell.h"

#pragma mark - 商品基本信息

@implementation ScanGoodsView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = JXFfffffColor;
        [self addSubview:self.goodsImage];
        
        [self addSubview:self.goodsName];
        [self addSubview:self.productCanpanyName];
        [self addSubview:self.productCode];
        [self addSubview:self.comparePriseButton];
        
        
        [self mas_layoutSubviews];
        
    }
    return self;
}

- (void)mas_layoutSubviews{
    [self.goodsImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(10);
        make.left.equalTo(self).offset(15);
        make.height.and.width.mas_equalTo(100);
    }];
   
    [self.goodsName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.goodsImage.mas_top);
        make.left.equalTo(self.goodsImage.mas_right).offset(10);
        make.right.equalTo(self.mas_right).offset(-15);
        make.height.mas_equalTo(20);
    }];
    
    [self.productCanpanyName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.goodsName.mas_bottom).offset(10);
        make.left.equalTo(self.goodsName.mas_left);
        make.right.equalTo(self.goodsName.mas_right);
        make.height.mas_equalTo(15);
    }];
    
    [self.productCode mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.productCanpanyName.mas_bottom).offset(10);
        make.left.equalTo(self.goodsName.mas_left);
        make.right.equalTo(self.goodsName.mas_right);
        make.height.mas_equalTo(15);
    }];
    
    [self.comparePriseButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.productCode.mas_bottom).offset(5);
        make.right.equalTo(self.mas_right).offset(-15);
        make.height.mas_equalTo(25);
        make.width.mas_equalTo(60);
    }];
}

- (void)setEntity:(ScanGoodsEntity *)entity{
    
}
- (UIImageView *)goodsImage{
    if (!_goodsImage) {
        _goodsImage = [[UIImageView alloc ] init];
        _goodsImage.backgroundColor = JXDebugColor;
        
    }
    return _goodsImage;
}

- (UILabel *)goodsName{
    if (!_goodsName) {
        _goodsName = [[UILabel alloc ]init ];
        _goodsName.textColor = JX333333Color;
        _goodsName.textAlignment = NSTextAlignmentLeft;
        _goodsName.backgroundColor = JXDebugColor;
        _goodsName.font = JXFontForNormal(13);
        _goodsName.text = @"山西跑步鸡";
    }
    return _goodsName;
}
- (UILabel *)productCanpanyName{
    if (!_productCanpanyName) {
        _productCanpanyName = [[UILabel alloc ]init ];
        _productCanpanyName.textColor = JX333333Color;
        _productCanpanyName.textAlignment = NSTextAlignmentLeft;
        _productCanpanyName.backgroundColor = JXDebugColor;
        _productCanpanyName.font = JXFontForNormal(11);
        _productCanpanyName.text = @"包装类型：";
    }
    return _productCanpanyName;
}
- (UILabel *)productCode{
    if (!_productCode) {
        _productCode = [[UILabel alloc ]init ];
        _productCode.textColor = JX333333Color;
        _productCode.textAlignment = NSTextAlignmentLeft;
        _productCode.backgroundColor = JXDebugColor;
        _productCode.font = JXFontForNormal(11);
        _productCode.text = @"包装规格：";
    }
    return _productCode;
}

- (UIButton *)comparePriseButton{
    if (!_comparePriseButton) {
        _comparePriseButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _comparePriseButton.backgroundColor = JXColorFromRGB(0xc3222c);
        [_comparePriseButton setTitle:@"比价" forState:UIControlStateNormal];
        [_comparePriseButton setTitleColor:JXFfffffColor forState:UIControlStateNormal];
        
        [_comparePriseButton.titleLabel setFont:JXFontForNormal(15)];
        
        _comparePriseButton.layer.cornerRadius = 3;
    }
    return _comparePriseButton;
}


@end

#pragma mark - 认证结果

@implementation AuthResultView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.type = Quality;
        [self addSubview:self.bgImage];
        
        [self addSubview:self.titleLabel];
        [self addSubview:self.resultButton];
        [self addSubview:self.infoLabel];
        [self addSubview:self.reportButton];
        
        [self setNeedsUpdateConstraints];
        
    }
    return self;
}

- (void)updateConstraints{
    CGFloat space = 30;
    [self.bgImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.equalTo(self).offset(0);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(space);
        make.left.equalTo(self.mas_left).offset(20);
        make.right.equalTo(self.mas_right).offset(-20);
        make.height.mas_equalTo(20);
    }];
    
    [self.resultButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(space);
        make.centerX.mas_equalTo(self.centerX);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(120);
    }];
    
    [self.infoLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(50);
        make.right.equalTo(self.mas_right).offset(-50);
        make.top.equalTo(self.resultButton.mas_bottom).offset(5);
        
        if (_type == Quality) {
            make.height.mas_equalTo(0.1);
        }else if (_type == Doubt){
            make.height.mas_equalTo(50);
        } else{
            make.height.mas_equalTo(75);
        }
    }];
    
    [self.reportButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(100, 26));
        make.top.equalTo(self.infoLabel.mas_bottom).offset(10);
        if (_type == Quality) {
            make.width.mas_equalTo(0.1);
        }else if (_type == Doubt){
            make.left.equalTo(self.titleLabel.mas_centerX).offset(30);
        }else{
            make.centerX.equalTo(self.mas_centerX);
        }
    }];
    
    [super updateConstraints];
}

- (UIImageView *)bgImage{
    if (!_bgImage) {
        _bgImage = [[UIImageView alloc ] init];
        _bgImage.backgroundColor = JXDebugColor;
        
    }
    return _bgImage;
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc ]init ];
        _titleLabel.textColor = JXFfffffColor;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.backgroundColor = JXDebugColor;
        _titleLabel.font = JXFontForNormal(20);
        _titleLabel.text = @"正品溯源权威认证";
    }
    return _titleLabel;
}

- (UILabel *)infoLabel{
    if (!_infoLabel) {
        _infoLabel = [[UILabel alloc ]init ];
        _infoLabel.textColor = JXFfffffColor;
        _infoLabel.textAlignment = NSTextAlignmentLeft;
        _infoLabel.backgroundColor = JXDebugColor;
        _infoLabel.font = JXFontForNormal(13);
        _infoLabel.text = @"正品溯源码：111122223333444";
        _infoLabel.numberOfLines = 0;
    }
    return _infoLabel;
}

- (UIButton *)resultButton{
    if (!_resultButton) {
        _resultButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _resultButton.backgroundColor = JXColorFromR_G_B(135, 130, 120);
        [_resultButton setImage:JXImageNamed(@"") forState:UIControlStateNormal];
        [_resultButton setTitle:@"正品" forState:UIControlStateNormal];
        [_resultButton setTitleColor:JXFfffffColor forState:UIControlStateNormal];
        [_resultButton.titleLabel setFont:JXFontForNormal(20)];
        
        _resultButton.imageEdgeInsets = UIEdgeInsetsMake(0, -5, 0, 5);
        _resultButton.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, -5);
        
        _resultButton.layer.cornerRadius = 3;
        
        _reportButton.enabled = NO;
    }
    return _resultButton;
}

- (UIButton *)detailButton{
    if (!_detailButton) {
        _detailButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _detailButton.backgroundColor = JXColorFromRGB(0xc3222c);
        [_detailButton setTitle:@"查看详情" forState:UIControlStateNormal];
        [_detailButton setTitleColor:JXFfffffColor forState:UIControlStateNormal];
        
        [_detailButton.titleLabel setFont:JXFontForNormal(15)];
    }
    return _detailButton;
}

- (UIButton *)reportButton{
    if (!_reportButton) {
        _reportButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _reportButton.backgroundColor = JXColorFromRGB(0xc3222c);
        [_reportButton setTitle:@"举报有奖" forState:UIControlStateNormal];
        [_reportButton setTitleColor:JXFfffffColor forState:UIControlStateNormal];
        
        [_reportButton.titleLabel setFont:JXFontForNormal(15)];
    }
    return _reportButton;
}


@end

#pragma mark - TitleView
@implementation  TitleView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = JXFfffffColor;
        self.open = YES;
        
        [self addSubview:self.titleLabel];
        [self addSubview:self.arrow];
        
        [self mas_layoutSubviews];
        
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc ]initWithTarget:self action:@selector(tapClick:)];
        [self addGestureRecognizer:tap];
    
    }
    return self;
}
- (void)mas_layoutSubviews{

    [self.arrow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-17);
        make.centerY.mas_equalTo(self);
        make.width.mas_equalTo(16);
        make.height.mas_offset(9);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self);
        make.left.equalTo(self.mas_left).offset(60);
        make.right.equalTo(self.mas_right).offset(-60);
    }];
}
- (UIImageView *)arrow{
    if (!_arrow) {
        _arrow = [[UIImageView alloc ] init];
        //_arrow.backgroundColor = JXDebugColor;
        _arrow.image = JXImageNamed(@"scrowdown");
    }
    return _arrow;
}

- (void)tapClick:(UITapGestureRecognizer *)tap{
    if (_block) {
        
        self.block(self.open,0);
        [UIView animateWithDuration:0.3 animations:^{
            self.arrow.transform = CGAffineTransformRotate(self.arrow.transform, DEGREES_TO_RADIANS(180));
        }];
        self.open = !self.open;
        NSLog(@"展开：%@",[NSNumber numberWithBool:self.open]);
    }
}
- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc ]init ];
        _titleLabel.textColor = JX333333Color;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        //_titleLabel.backgroundColor = JXDebugColor;
        _titleLabel.font = JXFontForNormal(13);
        _titleLabel.text = @"商品认证信息";
    }
    return _titleLabel;
}
@end
#pragma mark - 商品认证信息
@implementation ScanGoodsInfoView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = JXFfffffColor;
        
        [self addSubview:self.productImage];
        
//        [self addSubview:self.infolabel1];
//        [self addSubview:self.infolabel2];
//        [self addSubview:self.infolabel3];
//        [self addSubview:self.infolabel4];
//        [self addSubview:self.infolabel5];
//        
//        [self addSubview:self.productAddress];
//        [self addSubview:self.packageType];
//        [self addSubview:self.packageStandard];
//        [self addSubview:self.weight];
//        [self addSubview:self.ingredient];
        
        [self mas_layoutSubviews];
        
    }
    return self;
}
- (void)mas_layoutSubviews{
    [self.productImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.left.and.right.equalTo(self).offset(0);
        make.height.mas_equalTo(200*kPercent);
    }];
    //1
//    [self.infolabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.productImage.mas_bottom).offset(20);
//        make.left.equalTo(self.mas_left).offset(25);
//        make.width.mas_equalTo(17 * 5);
//        make.height.mas_equalTo(16.5);
//    }];
//    
//    [self.productAddress mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.infolabel1.mas_top);
//        make.left.equalTo(self.infolabel1.mas_right).offset(0);
//        make.right.equalTo(self.mas_right).offset(-25);
//        make.height.mas_equalTo(16.5);
//    }];
//    //2
//    [self.infolabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.infolabel1.mas_bottom).offset(20);
//        make.left.equalTo(self.infolabel1.mas_left);
//        make.width.equalTo(self.infolabel1.mas_width);
//        make.height.equalTo(self.infolabel1.mas_height);
//    }];
//    
//    [self.packageType mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.infolabel2.mas_top);
//        make.left.equalTo(self.infolabel1.mas_right).offset(0);
//        make.width.and.height.mas_equalTo(75);
//    }];
//    
//    
//    [self.infolabel3 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.packageType.mas_bottom).offset(20);
//        make.left.equalTo(self.infolabel1.mas_left);
//        make.width.equalTo(self.infolabel1.mas_width);
//        make.height.equalTo(self.infolabel1.mas_height);
//    }];
//    
//    [self.packageStandard mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.infolabel3.mas_top);
//        make.left.equalTo(self.infolabel1.mas_right).offset(0);
//        make.right.equalTo(self.mas_right).offset(-25);
//        make.height.equalTo(self.infolabel1);
//    }];
//    
//    [self.infolabel4 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.infolabel3.mas_bottom).offset(20);
//        make.left.equalTo(self.infolabel1.mas_left);
//        make.width.equalTo(self.infolabel1.mas_width);
//        make.height.equalTo(self.infolabel1.mas_height);
//    }];
//    
//    [self.weight mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.infolabel4.mas_top);
//        make.left.equalTo(self.infolabel1.mas_right).offset(0);
//        make.right.equalTo(self.mas_right).offset(-25);
//        make.height.equalTo(self.infolabel1.mas_height);
//    }];
//    
//    [self.infolabel5 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.infolabel4.mas_bottom).offset(20);
//        make.left.equalTo(self.infolabel1.mas_left);
//        make.width.equalTo(self.infolabel1.mas_width);
//        make.height.equalTo(self.infolabel1.mas_height);
//    }];
//    
//    [self.ingredient mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.infolabel5.mas_top);
//        make.left.equalTo(self.infolabel1.mas_right).offset(0);
//        make.right.equalTo(self.mas_right).offset(-25);
//        make.height.equalTo(self.infolabel1.mas_height);
//    }];
    
}

- (void)setEntity:(ScanGoodsEntity *)entity{
    
}
- (UIImageView *)productImage{
    if (!_productImage) {
        _productImage = [[UIImageView alloc ] init];
        _productImage.backgroundColor = JXDebugColor;
        
    }
    return _productImage;
}

- (UILabel *)infolabel1{
    if (!_infolabel1) {
        _infolabel1 = [[UILabel alloc ]init ];
        _infolabel1.textColor = JX333333Color;
        _infolabel1.textAlignment = NSTextAlignmentLeft;
        _infolabel1.backgroundColor = JXDebugColor;
        _infolabel1.font = JXFontForNormal(16.5);
        _infolabel1.text = @"生产地址：";
    }
    return _infolabel1;
}
- (UILabel *)infolabel2{
    if (!_infolabel2) {
        _infolabel2 = [[UILabel alloc ]init ];
        _infolabel2.textColor = JX333333Color;
        _infolabel2.textAlignment = NSTextAlignmentLeft;
        _infolabel2.backgroundColor = JXDebugColor;
        _infolabel2.font = JXFontForNormal(16.5);
        _infolabel2.text = @"包装类型：";
    }
    return _infolabel2;
}
- (UILabel *)infolabel3{
    if (!_infolabel3) {
        _infolabel3 = [[UILabel alloc ]init ];
        _infolabel3.textColor = JX333333Color;
        _infolabel3.textAlignment = NSTextAlignmentLeft;
        _infolabel3.backgroundColor = JXDebugColor;
        _infolabel3.font = JXFontForNormal(16.5);
        _infolabel3.text = @"包装规格：";
    }
    return _infolabel3;
}
- (UILabel *)infolabel4{
    if (!_infolabel4) {
        _infolabel4 = [[UILabel alloc ]init ];
        _infolabel4.textColor = JX333333Color;
        _infolabel4.textAlignment = NSTextAlignmentLeft;
        _infolabel4.backgroundColor = JXDebugColor;
        _infolabel4.font = JXFontForNormal(16.5);
        _infolabel4.text = @"重        量：";
    }
    return _infolabel4;
}
- (UILabel *)infolabel5{
    if (!_infolabel5) {
        _infolabel5 = [[UILabel alloc ]init ];
        _infolabel5.textColor = JX333333Color;
        _infolabel5.textAlignment = NSTextAlignmentLeft;
        _infolabel5.backgroundColor = JXDebugColor;
        _infolabel5.font = JXFontForNormal(16.5);
        _infolabel5.text = @"主要成分：";
    }
    return _infolabel5;
}

- (UILabel *)productAddress{
    if (!_productAddress) {
        _productAddress = [[UILabel alloc ]init ];
        _productAddress.textColor = JX333333Color;
        _productAddress.textAlignment = NSTextAlignmentLeft;
        _productAddress.backgroundColor = JXDebugColor;
        _productAddress.font = JXFontForNormal(16.5);
    }
    return _productAddress;
}

- (UIImageView *)packageType{
    if (!_packageType) {
        _packageType = [[UIImageView alloc ] init];
        _packageType.backgroundColor = JXDebugColor;
        
    }
    return _packageType;
}

- (UILabel *)packageStandard{
    if (!_packageStandard) {
        _packageStandard = [[UILabel alloc ]init ];
        _packageStandard.textColor = JX333333Color;
        _packageStandard.textAlignment = NSTextAlignmentLeft;
        _packageStandard.backgroundColor = JXDebugColor;
        _packageStandard.font = JXFontForNormal(16.5);
    }
    return _packageStandard;
}

- (UILabel *)weight{
    if (!_weight) {
        _weight = [[UILabel alloc ]init ];
        _weight.textColor = JX333333Color;
        _weight.textAlignment = NSTextAlignmentLeft;
        _weight.backgroundColor = JXDebugColor;
        _weight.font = JXFontForNormal(16.5);
    }
    return _weight;
}

- (UILabel *)ingredient{
    if (!_ingredient) {
        _ingredient = [[UILabel alloc ]init ];
        _ingredient.textColor = JX333333Color;
        _ingredient.textAlignment = NSTextAlignmentLeft;
        _ingredient.backgroundColor = JXDebugColor;
        _ingredient.font = JXFontForNormal(16.5);
    }
    return _ingredient;
}

@end

@implementation ExtraView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = JXFfffffColor;
        CGFloat imageViewWidth = 60;
        CGFloat space = (kScreenWidth - imageViewWidth* 3) /4;
        
        NSArray * titleArray = @[@"企业介绍",@"检测报告",@"认证信息"];
        NSArray * imageNameArray = @[@"companyProfile",@"examiningReport",@"authentication"];
        
        for (int i = 0; i < 3; i ++) {
            UIImageView * imageView = [[UIImageView alloc ]init ];
            imageView.image = JXImageNamed(imageNameArray[i]);
            //imageView.backgroundColor = JXDebugColor;
            imageView.tag = i;
            imageView.userInteractionEnabled = YES;
            
            UILabel * label = [[UILabel alloc ] init];
            //label.backgroundColor = JXDebugColor;
            label.textAlignment = NSTextAlignmentCenter;
            label.font = JXFontForNormal(13.3);
            label.text = titleArray[i];
            label.tag = 10 +i;
            label.textColor = JX333333Color;
            label.userInteractionEnabled = YES;
            
            [self addSubview:imageView];
            [self addSubview:label];
            
            
            UITapGestureRecognizer * tap1 = [[UITapGestureRecognizer alloc ]initWithTarget:self action:@selector(tapClick:)];
            UITapGestureRecognizer * tap2 = [[UITapGestureRecognizer alloc ]initWithTarget:self action:@selector(tapClick:)];
            [imageView addGestureRecognizer:tap1];
            [label addGestureRecognizer:tap2];
            
            [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self).offset(10);
                make.left.mas_equalTo(self.mas_left).offset(space + (space +imageViewWidth) *i);
                make.size.mas_equalTo(CGSizeMake(imageViewWidth, imageViewWidth));
            }];
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(imageView.mas_bottom).offset(10);
                make.centerX.mas_equalTo(imageView);
                make.height.mas_equalTo(14);
                make.width.mas_equalTo(80);
            }];
        }
    }
    return self;
}

- (void)tapClick:(UITapGestureRecognizer * )tap{
    if (_block) {
        self.block(NO, tap.view.tag);
        NSLog(@"click:%ld",tap.view.tag);
    }
}

@end
