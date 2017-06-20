//
//  FdbackAndReportShowPicCell.m
//  ZPSY
//
//  Created by zhouhao on 2017/2/27.
//  Copyright © 2017年 zhouhao. All rights reserved.
//

#import "FdbackAndReportShowPicCell.h"

@implementation FdbackAndReportShowPicCell
-(UILabel*)mainlab{
    if (!_mainlab) {
        _mainlab=[[UILabel alloc] init];
    }
    return _mainlab;
}
-(UILabel*)titleLab{
    if (!_titleLab) {
        _titleLab=[[UILabel alloc] init];
    }
    return _titleLab;
}
-(UILabel*)timelab{
    if (!_timelab) {
        _timelab=[[UILabel alloc] init];
        _timelab.textAlignment=NSTextAlignmentRight;
    }
    return _timelab;
}
-(KevenPicEditAndShowView *)PicShowView{

    if (!_PicShowView) {
        _PicShowView=[[KevenPicEditAndShowView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth-45, 100) ImagsUrl:nil maxCount:3 IsEdit:NO];
    }
    return _PicShowView;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self= [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle=UITableViewCellSelectionStyleNone;
        self.layer.shouldRasterize = true;
        self.layer.rasterizationScale = [UIScreen mainScreen].scale;
        [self viewinit];
    }
    return self;
}
-(void)viewinit{

    [self.contentView addSubview:self.titleLab];
    [self.contentView addSubview:self.timelab];
    [self.contentView addSubview:self.mainlab];
    [self.contentView addSubview:self.PicShowView];
    
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).with.offset(15);
        make.right.mas_equalTo(self.contentView.mas_right).with.offset(-15);
        make.top.mas_equalTo(self.contentView.mas_top).with.offset(5);
        make.height.equalTo(@20);
    }];
    [self.timelab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.contentView.mas_right).with.offset(-15);
        make.top.mas_equalTo(self.contentView.mas_top).with.offset(5);
        make.height.equalTo(@20);
    }];
    [self.mainlab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).with.offset(30);
        make.right.mas_equalTo(self.contentView.mas_right).with.offset(-15);
        make.top.mas_equalTo(self.titleLab.mas_bottom).with.offset(5);
    }];

    [self.PicShowView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).with.offset(30);
        make.right.mas_equalTo(self.contentView.mas_right).with.offset(-15);
        make.top.mas_equalTo(self.mainlab.mas_bottom).with.offset(5);
        make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(-5);
        make.height.equalTo(@(kScreenWidth/3-15));
    }];
    
}



- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
