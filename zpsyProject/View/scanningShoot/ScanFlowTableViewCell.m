//
//  ScanFlowTableViewCell.m
//  ZPSY
//
//  Created by 杜进新 on 2017/5/26.
//  Copyright © 2017年 zhouhao. All rights reserved.
//

#import "ScanFlowTableViewCell.h"

@implementation ScanFlowCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = JXFfffffColor;
    
        [self.contentView addSubview:self.line];
        [self.contentView addSubview:self.infoLabel];
        [self.contentView addSubview:self.firstImageView];
        [self.contentView addSubview:self.secondImageView];
        [self.contentView addSubview:self.thirdImageView];
        
        [self mas_layoutSubViews];
    }
    return self;
}


- (void)mas_layoutSubViews{
    
    CGFloat leading = 20;
    CGFloat trailing = 15;
    CGFloat pointWidth = 5;
    CGFloat pictureWidth = (kScreenWidth - leading -trailing -5 -25 *3)/3;
    CGFloat height = 10 *2 +15 +15 + pictureWidth;
    
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView);
        make.left.equalTo(self.contentView.mas_left).offset(leading);
        make.height.mas_equalTo(self.contentView.mas_height);
        make.width.mas_equalTo(0.5);
    }];

    [self.firstImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        //make.top.equalTo(self.infoLabel.mas_bottom).offset(15);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(0);
        make.left.equalTo(self.line.mas_right).offset(25);
        make.size.mas_equalTo(CGSizeMake(pictureWidth, pictureWidth));
    }];
    
    [self.secondImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.firstImageView);
        make.left.equalTo(self.firstImageView.mas_right).offset(25);
        make.size.mas_equalTo(self.firstImageView);
    }];
    
    [self.thirdImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.firstImageView);
        make.left.equalTo(self.secondImageView.mas_right).offset(25);
        make.size.mas_equalTo(self.firstImageView);
    }];
    
    [self.infoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(10);
        make.left.equalTo(self.line.mas_left).offset(25);
        //make.height.mas_equalTo(15);
        //make.width.mas_equalTo(kScreenWidth - leading*2 -10 -25);
        make.bottom.equalTo(self.firstImageView.mas_top).offset(-10);
        make.right.equalTo(self.contentView.mas_right).offset(-leading);
    }];
}


- (UIView *)line{
    if (!_line) {
        _line = [[UIView alloc ]init ];
        _line.backgroundColor = JX333333Color;
    }
    return _line;
}

- (UILabel *)infoLabel{
    if (!_infoLabel) {
        _infoLabel = [[UILabel alloc ]init ];
        _infoLabel.textColor = JX333333Color;
        _infoLabel.textAlignment = NSTextAlignmentLeft;
        _infoLabel.backgroundColor = JXDebugColor;
        _infoLabel.font = JXFontForNormal(10);
        _infoLabel.text = @"2017.1.1   生产地";
        _infoLabel.numberOfLines = 0;
    }
    return _infoLabel;
}

- (UIImageView *)firstImageView{
    if (!_firstImageView) {
        _firstImageView = [[UIImageView alloc ] init];
        _firstImageView.backgroundColor = JXDebugColor;
        _firstImageView.tag = 0;
        _firstImageView.userInteractionEnabled = YES;
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc ]initWithTarget:self action:@selector(tapClick:)];
        [_firstImageView addGestureRecognizer:tap];
        
    }
    return _firstImageView;
}

- (UIImageView *)secondImageView{
    if (!_secondImageView) {
        _secondImageView = [[UIImageView alloc ] init];
        _secondImageView.backgroundColor = JXDebugColor;
        _secondImageView.tag = 1;
        _secondImageView.userInteractionEnabled = YES;
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc ]initWithTarget:self action:@selector(tapClick:)];
        [_secondImageView addGestureRecognizer:tap];
        
    }
    return _secondImageView;
}

- (UIImageView *)thirdImageView{
    if (!_thirdImageView) {
        _thirdImageView = [[UIImageView alloc ] init];
        _thirdImageView.backgroundColor = JXDebugColor;
        _thirdImageView.tag = 2;
        _thirdImageView.userInteractionEnabled = YES;
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc ]initWithTarget:self action:@selector(tapClick:)];
        [_thirdImageView addGestureRecognizer:tap];
        
    }
    return _thirdImageView;
}
- (void)tapClick:(UITapGestureRecognizer *)tap{
    if (_block) {
        self.block(tap.view.tag);
    }
}
- (void)setModel:(GoodsFlowSubModel *)model{
    NSString * dateStr = [model.operationTime substringToIndex:10];
    NSString * contentStr = [NSString stringWithFormat:@"%@      %@",dateStr,model.contents];
    NSArray * fileArr = @[];
    if ([model.file hasPrefix:@"http"]) {
        fileArr = [model.file componentsSeparatedByString:@","];
    }
    
    
    if (fileArr.count > 0) {
        [self.firstImageView sd_setImageWithURL:[NSURL URLWithString:fileArr.firstObject] placeholderImage:nil];
    }
    if (fileArr.count >1) {
        [self.secondImageView sd_setImageWithURL:[NSURL URLWithString:fileArr[1]] placeholderImage:nil];
    }
    if (fileArr.count >2) {
        [self.thirdImageView sd_setImageWithURL:[NSURL URLWithString:fileArr[2]] placeholderImage:nil];
    }
    //self.infoLabel.text = model.event;
    //self.timerlab.text = CTUtility.string(from: Model?.date, sourceformat: "yyyy-MM-dd HH:mm:ss", toFormat: "yyyy-MM-dd")
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineSpacing = 5;
    //paragraphStyle.paragraphSpacing = 6;
    
    //    NSStringDrawingOptions option = NSStringDrawingTruncatesLastVisibleLine |  NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
    //    NSDictionary *attributes = @{NSFontAttributeName:self.infoLabel.font,NSParagraphStyleAttributeName:paragraphStyle};
    //    CGRect rect = [model.event boundingRectWithSize:CGSizeMake(kScreenWidth -(105 + 20+ 0.5), CGFLOAT_MAX) options:option attributes:attributes context:nil];
    
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc]initWithString:contentStr];
    [attStr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, attStr.length)];
    
    self.infoLabel.attributedText = attStr;
    //self.height = rect.size.height + 10;
    //[self.infoLabel sizeToFit];
    
    CGFloat pictureWidth = (kScreenWidth - 20 -15 -5 -25 *3)/3;
    [self.firstImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        //make.top.equalTo(self.infoLabel.mas_bottom).offset(15);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(0);
        make.left.equalTo(self.line.mas_right).offset(10);
        make.size.mas_equalTo(CGSizeMake(pictureWidth, pictureWidth));
    }];
    [self.line mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.contentView);
        make.left.equalTo(self.contentView).offset(20);
        //make.height.mas_equalTo(rect.size.height + 10);
        make.width.mas_equalTo(0.5);
    }];
    [self.infoLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(10);
        make.left.equalTo(self.line.mas_right).offset(10);
        make.right.equalTo(self.contentView.mas_right).offset(-15);
        make.bottom.equalTo(self.firstImageView.mas_top).offset(-10);
    }];
    if (fileArr.count >= 3) {
        self.firstImageView.hidden = NO;
        self.secondImageView.hidden = NO;
        self.thirdImageView.hidden = NO;
    }else if (fileArr.count ==2){
        self.firstImageView.hidden = NO;
        self.secondImageView.hidden = NO;
        self.thirdImageView.hidden = YES;
    }else if (fileArr.count == 1){
        self.firstImageView.hidden = NO;
        self.secondImageView.hidden = YES;
        self.thirdImageView.hidden = YES;
    }else{
        self.firstImageView.hidden = YES;
        self.secondImageView.hidden = YES;
        self.thirdImageView.hidden = YES;
        [self.firstImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
            //make.top.equalTo(self.infoLabel.mas_bottom).offset(15);
            make.bottom.equalTo(self.contentView.mas_bottom).offset(0);
            make.left.equalTo(self.line.mas_right).offset(10);
            make.size.mas_equalTo(CGSizeMake(0.1, 0.1));
        }];
        [self.infoLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView.mas_top).offset(10);
            make.left.equalTo(self.line.mas_right).offset(10);
            make.right.equalTo(self.contentView.mas_right).offset(-15);
            make.bottom.equalTo(self.firstImageView.mas_top).offset(0);
        }];
    }
}

//- (UICollectionViewLayoutAttributes *)preferredLayoutAttributesFittingAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes{
//    [super preferredLayoutAttributesFittingAttributes:layoutAttributes];
//    layoutAttributes.frame = CGRectMake(layoutAttributes.frame.origin.x, layoutAttributes.frame.origin.y, kScreenWidth, layoutAttributes.frame.size.height);
//    return layoutAttributes;
//}

@end


#pragma mark - ScanFlowCollectionReusableView


@implementation ScanFlowCollectionReusableView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = JXFfffffColor;
        [self addSubview:self.line];
        [self addSubview:self.point];
        [self addSubview:self.titleLabel];
        
        [self mas_layoutSubViews];
    }
    return self;
}


- (void)mas_layoutSubViews{
    
    CGFloat leading = 20;
    CGFloat pointWidth = 6;
    
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.left.equalTo(self).offset(leading);
        make.height.equalTo(self.mas_height);
        make.width.mas_equalTo(0.5);
    }];
    
    [self.point mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.line.mas_centerX);
        make.centerY.equalTo(self.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(pointWidth, pointWidth));
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(10);
        make.left.equalTo(self.point.mas_right).offset(15);
        make.right.equalTo(self.mas_right).offset(-leading);
        make.height.mas_equalTo(20);
    }];
}


- (UIView *)line{
    if (!_line) {
        _line = [[UIView alloc ]init ];
        _line.backgroundColor = JX333333Color;
    }
    return _line;
}

- (UIView *)point{
    if (!_point) {
        _point = [[UIView alloc ]init ];
        _point.backgroundColor = JXff5252Color;
        _point.layer.cornerRadius = 3.f;
    }
    return _point;
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc ]init ];
        _titleLabel.textColor = JX333333Color;
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.backgroundColor = JXDebugColor;
        _titleLabel.font = JXFontForNormal(14);
        _titleLabel.numberOfLines = 2;
        _titleLabel.text = @"生产地址：";
    }
    return _titleLabel;
}

//- (UICollectionViewLayoutAttributes *)preferredLayoutAttributesFittingAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes{
//    [super preferredLayoutAttributesFittingAttributes:layoutAttributes];
//    layoutAttributes.frame = CGRectMake(layoutAttributes.frame.origin.x, layoutAttributes.frame.origin.y, kScreenWidth, layoutAttributes.frame.size.height);
//    return layoutAttributes;
//}

@end

#pragma mark - ScanFlowOldCollectionViewCell


@implementation ScanFlowOldCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.height = 20;
        self.backgroundColor = JXFfffffColor;
        
        [self.contentView addSubview:self.line];
        [self.contentView addSubview:self.point];
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.infoLabel];

        [self mas_layoutSubViews];
    }
    return self;
}


- (void)mas_layoutSubViews{
    
    CGFloat leading = 20;
    CGFloat trailing = 15;
    CGFloat top = 10 + (10 -6)/2;//12
    CGFloat pointWidth = 6;
    CGFloat pictureWidth = (kScreenWidth - leading -trailing -5 -25 *3)/3;
    
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.contentView);
        make.left.equalTo(self.contentView).offset(leading);
        make.height.mas_equalTo(20 + 20);
        make.width.mas_equalTo(0.5);
    }];
    
    [self.point mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.line.mas_centerX);
        make.top.equalTo(self.contentView.mas_top).offset(top);
        make.size.mas_equalTo(CGSizeMake(pointWidth, pointWidth));
    }];

    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(10);
        make.left.equalTo(self.point.mas_right).offset(15);
        make.width.mas_equalTo(65);
        //make.right.equalTo(self.mas_right).offset(-leading);
        make.height.mas_equalTo(10);
    }];
    
    [self.infoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(10);
        make.left.equalTo(self.titleLabel.mas_right).offset(10);
        //make.width.mas_equalTo(100);
        make.right.equalTo(self.contentView.mas_right).offset(-leading);
        make.height.mas_equalTo(self.height);
        //make.bottom.equalTo(self.contentView.mas_bottom).offset(-10);
    }];
}


- (UIView *)line{
    if (!_line) {
        _line = [[UIView alloc ]init ];
        _line.backgroundColor = JX333333Color;
    }
    return _line;
}

- (UIView *)point{
    if (!_point) {
        _point = [[UIView alloc ]init ];
        _point.backgroundColor = JXff5252Color;
        _point.layer.cornerRadius = 3.f;
    }
    return _point;
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc ]init ];
        _titleLabel.textColor = JX333333Color;
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.backgroundColor = JXDebugColor;
        _titleLabel.font = JXFontForNormal(10);
        _titleLabel.numberOfLines = 0;
        _titleLabel.text = @"生产地址：";
    }
    return _titleLabel;
}
- (UILabel *)infoLabel{
    if (!_infoLabel) {
        _infoLabel = [[UILabel alloc ]init ];
        _infoLabel.textColor = JX333333Color;
        _infoLabel.textAlignment = NSTextAlignmentLeft;
        _infoLabel.backgroundColor = JXDebugColor;
        _infoLabel.font = JXFontForNormal(10);
        _infoLabel.numberOfLines = 0;
        //_infoLabel.textAlignment = NSTextAlignmentJustified;
        
        _infoLabel.text = @"生产地址：sdfjasdfjsl;kjdflskdfjsfjsdlkkjfdssdfgsgdgdsgdfsgdfgdfg";
    }
    return _infoLabel;
}
//- (UICollectionViewLayoutAttributes *)preferredLayoutAttributesFittingAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes{
//    
//    [super preferredLayoutAttributesFittingAttributes:layoutAttributes];
//    layoutAttributes.frame = CGRectMake(layoutAttributes.frame.origin.x, layoutAttributes.frame.origin.y, kScreenWidth, self.height + 20);
//    return layoutAttributes;
//}

- (void)setModel:(GoodsLotBatchModel *)model{
    self.titleLabel.text = [model.date substringToIndex:10];
    //self.infoLabel.text = model.event;
    //self.timerlab.text = CTUtility.string(from: Model?.date, sourceformat: "yyyy-MM-dd HH:mm:ss", toFormat: "yyyy-MM-dd")
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineSpacing = 5;
    //paragraphStyle.paragraphSpacing = 6;
    
//    NSStringDrawingOptions option = NSStringDrawingTruncatesLastVisibleLine |  NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
//    NSDictionary *attributes = @{NSFontAttributeName:self.infoLabel.font,NSParagraphStyleAttributeName:paragraphStyle};
//    CGRect rect = [model.event boundingRectWithSize:CGSizeMake(kScreenWidth -(105 + 20+ 0.5), CGFLOAT_MAX) options:option attributes:attributes context:nil];
    
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc]initWithString:model.event];
    [attStr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, attStr.length)];
    
    self.infoLabel.attributedText = attStr;
    //self.height = rect.size.height + 10;
    //[self.infoLabel sizeToFit];
    
    [self.infoLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(10);
        make.left.equalTo(self.titleLabel.mas_right).offset(10);
        //make.width.mas_equalTo(100);
        make.right.equalTo(self.contentView.mas_right).offset(-15);
        //make.height.mas_equalTo(rect.size.height);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(0);
    }];
    [self.line mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.contentView);
        make.left.equalTo(self.contentView).offset(20);
        //make.height.mas_equalTo(rect.size.height + 10);
        make.width.mas_equalTo(0.5);
    }];
}
@end


