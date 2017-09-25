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
        _comparePriseButton.backgroundColor = JXMainColor;
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
        [self addSubview:self.resultImageView];
        [self addSubview:self.resultButton];
        [self addSubview:self.infoLabel];
        [self addSubview:self.detailLabel];
        [self addSubview:self.reportButton];
        [self addSubview:self.detailButton];
        [self setNeedsUpdateConstraints];
        
    }
    return self;
}

- (void)updateConstraints{
    CGFloat height = 30;
    //(25+132+15+25+8+16)+15+26+15 正品
    //(25+132+15+25+8+16)+10+13+15+44 可疑
    //(25+132+15+25+8+16)+10+13+15+44 伪品
    [self.bgImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.equalTo(self).offset(0);
    }];
    [self.resultImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(25*kPercent);
        make.centerX.equalTo(self.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(117*kPercent, 132*kPercent));
    }];
    [self.resultButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.resultImageView.mas_bottom).offset(15*kPercent);
        make.left.equalTo(self.mas_left).offset(20);
        make.right.equalTo(self.mas_right).offset(-20);
        make.height.mas_equalTo(25*kPercent);
    }];
    [self.infoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.resultButton.mas_bottom).offset(8*kPercent);
        make.centerX.mas_equalTo(self.centerX);
        make.height.mas_equalTo(16*kPercent);
    }];
    
    [self.detailLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(50);
        make.right.equalTo(self.mas_right).offset(-50);
        make.top.equalTo(self.infoLabel.mas_bottom).offset(10*kPercent);
        if (_type == Quality){
            make.height.mas_equalTo(0.1);
        } else{
            make.height.mas_equalTo(13*kPercent);
        }
    }];
    
    [self.reportButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        if (_type == Quality) {
            make.top.equalTo(self.infoLabel.mas_bottom).offset(15*kPercent);
            make.size.mas_equalTo(CGSizeMake(100*kPercent, 27*kPercent));
            make.centerX.equalTo(self.mas_centerX);
        }else{
            make.top.equalTo(self.detailLabel.mas_bottom).offset(15*kPercent);
            make.left.equalTo(self.mas_centerX);
            make.right.equalTo(self.mas_right);
            make.height.mas_equalTo(44*kPercent);
        }
    }];
    [self.detailButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_centerX).offset(-0.5);
        if (_type == Quality) {
            make.top.equalTo(self.infoLabel.mas_bottom).offset(15*kPercent);
            make.width.mas_equalTo(0.1);
            make.height.mas_equalTo(0.1);
        }else{
            make.left.equalTo(self.mas_left);
            make.top.equalTo(self.reportButton.mas_top);
            make.height.mas_equalTo(44*kPercent);
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
- (UIImageView *)resultImageView{
    if (!_resultImageView) {
        _resultImageView = [[UIImageView alloc ] init];
        _resultImageView.backgroundColor = JXDebugColor;
        
    }
    return _resultImageView;
}

- (UILabel *)infoLabel{
    if (!_infoLabel) {
        _infoLabel = [[UILabel alloc ]init ];
        _infoLabel.textColor = JXFfffffColor;
        _infoLabel.textAlignment = NSTextAlignmentCenter;
        _infoLabel.backgroundColor = JXDebugColor;
        _infoLabel.font = JXFontForNormal(16);
        _infoLabel.text = @"正品溯源码：111122223333444";
        _infoLabel.numberOfLines = 0;
    }
    return _infoLabel;
}
- (UILabel *)detailLabel{
    if (!_detailLabel) {
        _detailLabel = [[UILabel alloc ]init ];
        _detailLabel.textColor = JXFfffffColor;
        _detailLabel.textAlignment = NSTextAlignmentCenter;
        _detailLabel.backgroundColor = JXDebugColor;
        _detailLabel.font = JXFontForNormal(13*kPercent);
        _detailLabel.text = @"";
        _detailLabel.numberOfLines = 0;
    }
    return _detailLabel;
}
- (UIButton *)resultButton{
    if (!_resultButton) {
        _resultButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _resultButton.backgroundColor = JXDebugColor;
        [_resultButton setImage:JXImageNamed(@"") forState:UIControlStateNormal];
        [_resultButton setTitle:@"正品" forState:UIControlStateNormal];
        [_resultButton setTitleColor:JXFfffffColor forState:UIControlStateNormal];
        [_resultButton.titleLabel setFont:JXFontForNormal(15*kPercent)];
        
        _resultButton.imageEdgeInsets = UIEdgeInsetsMake(0, -5, 0, 5);
        _resultButton.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, -5);
        
        _resultButton.layer.cornerRadius = 3;
        
        _resultButton.enabled = NO;
    }
    return _resultButton;
}

- (UIButton *)detailButton{
    if (!_detailButton) {
        _detailButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _detailButton.backgroundColor = JXColorFromRGB(0x2d8edd);
        [_detailButton setTitle:@"查看详情" forState:UIControlStateNormal];
        [_detailButton setTitleColor:JXFfffffColor forState:UIControlStateNormal];
        
        [_detailButton.titleLabel setFont:JXFontForNormal(17*kPercent)];
    }
    return _detailButton;
}

- (UIButton *)reportButton{
    if (!_reportButton) {
        _reportButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _reportButton.backgroundColor = JXColorFromRGB(0x2d8edd);
        [_reportButton setTitle:@"举报有奖" forState:UIControlStateNormal];
        [_reportButton setTitleColor:JXFfffffColor forState:UIControlStateNormal];
        
        [_reportButton.titleLabel setFont:JXFontForNormal(17*kPercent)];
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
        make.left.equalTo(self.mas_left).offset(20);
        make.right.equalTo(self.mas_right).offset(-20);
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
        _titleLabel.font = JXFontForNormal(14*kPercent);
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
        
        [self addSubview:self.leftImage];
        [self addSubview:self.centerImage];
        [self addSubview:self.rightImage];
        
        [self mas_layoutSubviews:NO];
        
    }
    return self;
}
- (void)mas_layoutSubviews:(BOOL)isImageExist{
    CGFloat leading = 20;
    CGFloat space = 10;
    CGFloat width = (kScreenWidth - 20*2 - 10 *2)/3;
    self.imageHeight = isImageExist == YES ? width : 0;
    
    [self.leftImage mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.left.equalTo(self.mas_left).offset(leading);
        make.size.mas_equalTo(CGSizeMake(width, self.imageHeight));
    }];
    [self.centerImage mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.left.equalTo(self.leftImage.mas_right).offset(space);
        make.size.mas_equalTo(CGSizeMake(width, self.imageHeight));
    }];
    [self.rightImage mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.left.equalTo(self.centerImage.mas_right).offset(space);
        make.size.mas_equalTo(CGSizeMake(width, self.imageHeight));
    }];
}

- (void)setImageArray:(NSArray *)imageArray{

    switch (imageArray.count) {
            case 0:
        {
            self.leftImage.hidden = YES;
            self.centerImage.hidden = YES;
            self.rightImage.hidden = YES;
        }
            break;
            case 1:
        {
            [self.leftImage sd_setImageWithURL:[NSURL URLWithString:imageArray[0]] placeholderImage:nil];
            self.centerImage.hidden = YES;
            self.rightImage.hidden = YES;
        }
            break;
            case 2:
        {
            [self.leftImage sd_setImageWithURL:[NSURL URLWithString:imageArray[0]] placeholderImage:nil];
            [self.centerImage sd_setImageWithURL:[NSURL URLWithString:imageArray[1]] placeholderImage:nil];
            self.rightImage.hidden = YES;
        }
            break;
        default:
        {
            [self.leftImage sd_setImageWithURL:[NSURL URLWithString:imageArray[0]] placeholderImage:nil];
            [self.centerImage sd_setImageWithURL:[NSURL URLWithString:imageArray[1]] placeholderImage:nil];
            [self.rightImage sd_setImageWithURL:[NSURL URLWithString:imageArray[2]] placeholderImage:nil];
        }
            break;
    }

    [self mas_layoutSubviews:(imageArray.count > 0)];
}

- (AdScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[AdScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 200*kPercent)];
    }
    return _scrollView;
}
- (UIImageView *)leftImage{
    if (!_leftImage) {
        _leftImage = [[UIImageView alloc ] init];
        _leftImage.backgroundColor = JXDebugColor;
        _leftImage.userInteractionEnabled = YES;
        _leftImage.tag = 0;
        [_leftImage addGestureRecognizer: [[UITapGestureRecognizer alloc ] initWithTarget:self action:@selector(imageClick:)]];
    }
    return _leftImage;
}
- (UIImageView *)centerImage{
    if (!_centerImage) {
        _centerImage = [[UIImageView alloc ] init];
        _centerImage.backgroundColor = JXDebugColor;
        _centerImage.userInteractionEnabled = YES;
        _centerImage.tag = 1;
        [_centerImage addGestureRecognizer: [[UITapGestureRecognizer alloc ] initWithTarget:self action:@selector(imageClick:)]];
    }
    return _centerImage;
}
- (UIImageView *)rightImage{
    if (!_rightImage) {
        _rightImage = [[UIImageView alloc ] init];
        _rightImage.backgroundColor = JXDebugColor;
        _rightImage.userInteractionEnabled = YES;
        _rightImage.tag = 2;
        [_rightImage addGestureRecognizer: [[UITapGestureRecognizer alloc ] initWithTarget:self action:@selector(imageClick:)]];
    }
    return _rightImage;
}

- (void)imageClick:(UITapGestureRecognizer *)tap {
    if (_block) {
        self.block(NO,tap.view.tag);
    }
}

@end

@implementation ExtraView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = JXFfffffColor;
//        CGFloat imageViewWidth = 60;
//        CGFloat space = (kScreenWidth - imageViewWidth* 3) /4;
//        
//        NSArray * titleArray = @[@"企业介绍",@"检测报告",@"认证信息"];
//        NSArray * imageNameArray = @[@"companyProfile",@"examiningReport",@"authentication"];
//        
//        for (int i = 0; i < 3; i ++) {
//            UIImageView * imageView = [[UIImageView alloc ]init ];
//            imageView.image = JXImageNamed(imageNameArray[i]);
//            //imageView.backgroundColor = JXDebugColor;
//            imageView.tag = i;
//            imageView.userInteractionEnabled = YES;
//            
//            UILabel * label = [[UILabel alloc ] init];
//            //label.backgroundColor = JXDebugColor;
//            label.textAlignment = NSTextAlignmentCenter;
//            label.font = JXFontForNormal(13.3);
//            label.text = titleArray[i];
//            label.tag = 10 +i;
//            label.textColor = JX333333Color;
//            label.userInteractionEnabled = YES;
//            
//            [self addSubview:imageView];
//            [self addSubview:label];
//            
//            
//            UITapGestureRecognizer * tap1 = [[UITapGestureRecognizer alloc ]initWithTarget:self action:@selector(tapClick:)];
//            UITapGestureRecognizer * tap2 = [[UITapGestureRecognizer alloc ]initWithTarget:self action:@selector(tapClick:)];
//            [imageView addGestureRecognizer:tap1];
//            [label addGestureRecognizer:tap2];
//            
//            [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
//                make.top.equalTo(self).offset(10);
//                make.left.mas_equalTo(self.mas_left).offset(space + (space +imageViewWidth) *i);
//                make.size.mas_equalTo(CGSizeMake(imageViewWidth, imageViewWidth));
//            }];
//            [label mas_makeConstraints:^(MASConstraintMaker *make) {
//                make.top.equalTo(imageView.mas_bottom).offset(10);
//                make.centerX.mas_equalTo(imageView);
//                make.height.mas_equalTo(14);
//                make.width.mas_equalTo(80);
//            }];
//        }
    }
    return self;
}

- (void)tapClick:(UITapGestureRecognizer * )tap{
    if (_block) {
        self.block(NO, tap.view.tag);
    }
}

@end
