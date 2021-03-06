//
//  ScanChickenDetailController.m
//  ZPSY
//
//  Created by 杜进新 on 2018/1/16.
//  Copyright © 2018年 zhouhao. All rights reserved.
//

#import "ScanChickenDetailController.h"
#import "ScanGoodsInfoTableViewCell.h"
#import "ScanFlowTableViewCell.h"
#import "JXSelectView.h"
#import "JZAlbumViewController.h"



/**
 headview
 
 section0 运动状态 表格
 section1 饲养农户 图文
 section2 养殖环境 地图，图文，检验报告
 section3 食疗信息 说明加图文列表，检验报告
 section4 肉质口感 说明加检验报告
 section5 溯源信息 标题
 section6 溯源信息列表...
     .
     .
     .
 */

@interface ScanChickenDetailController ()<UITableViewDelegate,UITableViewDataSource,WaterFlowLayoutDelegate>{
    CGFloat              _headViewHeight;//头视图总高度
    UIView             * _headView;
    AuthResultView     * _resultView;
    CGFloat              _resultViewHeight;//鉴定结果高度
    
    TitleView          * _firstTitleView;
    UIView             * _firstView;
    CGFloat              _firstViewHeight;//首次扫描高度
    
    TitleView          * _authTitleView;
    ScanGoodsInfoView  * _infoView;
    CGFloat              _infoViewHeight;//产品出厂信息
    CGFloat              _varHeight;//动态高度
    
    
    ExtraView          * _extraView;
    CGFloat              _extraViewHeight;//企业信息
    TitleView          * _flowTitleView;
    
    BOOL                 _isCollectionViewOpen;
    CGPoint              _contentOffset;
    
    priceCompareView   * _priceView;
    
    JXSelectView       * _companySelectView;
    JXSelectView       * _deviceSelectView;
    
    NSMutableArray     * _deviceArray;
    
    NSMutableArray     * _titleArray;
    NSMutableArray     * _imageNameArray;
}

@property (nonatomic, strong) priceCompareView * priceView;
@property (nonatomic, strong) JXSelectView * companySelectView;
@property (nonatomic, strong) JXSelectView * deviceSelectView;

@end

@implementation ScanChickenDetailController

static NSString * const reuseIdentifierCell = @"Cell";
static NSString * const reuseIdentifierOldCell = @"OldCell";
static NSString * const reuseIdentifierHeader = @"Header";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.title = @"正品溯源";
    
    [self.collectionView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (UICollectionView *)collectionView{
    if (!_collectionView) {
        
        CGSize itemSize = CGSizeMake(kScreenWidth, 40);
        // +15 +15 +pictureWidth;
        
        GuiderViewFlowLayout *flowLayout= [[GuiderViewFlowLayout alloc] init];
        flowLayout.delegate = self;
        flowLayout.columnCount = 1;
        flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;//滚动方向
        flowLayout.minimumLineSpacing = 0.0;//行间距(最小值)
        flowLayout.minimumInteritemSpacing = 0.0;//item间距(最小值)
        //flowLayout.itemSize = UICollectionViewFlowLayoutAutomaticSize;//item的大小
        flowLayout.itemSize = itemSize;
        //flowLayout.estimatedItemSize = itemSize;
        flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);//设置section的边距,默认(0,0,0,0)
        if (self.scanFinishModel.goodsLotBatchArr.count > 0) {
            flowLayout.headerReferenceSize = CGSizeMake(0.1, 0.1);
        }else{
            flowLayout.headerReferenceSize = CGSizeMake(kScreenWidth, 40);
        }
        
        //flowLayout.headerReferenceSize = UICollectionViewFlowLayoutAutomaticSize;
        //flowLayout.footerReferenceSize = CGSizeMake(320, 20);
        
        _collectionView = [[UICollectionView alloc ]initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight -64) collectionViewLayout:flowLayout];
        _collectionView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        // Register cell classes
        if (self.scanFinishModel.goodsLotBatchArr.count > 0) {
            [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:reuseIdentifierHeader];
            
            [_collectionView registerClass:[ScanFlowOldCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifierOldCell];
        }else{
            
            [_collectionView registerClass:[ScanFlowCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:reuseIdentifierHeader];
        }
        [_collectionView registerClass:[ScanFlowCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifierCell];
    }
    return _collectionView;
}
- (void)addSubviews{
    _resultView = ({
        AuthResultView * resulltView = [[AuthResultView alloc ]init ];
        resulltView;
    });
    _firstTitleView = ({
        TitleView * titleView = [[TitleView alloc ]init ];
        titleView.arrow.hidden = YES;
        titleView.titleLabel.textAlignment = NSTextAlignmentLeft;
        titleView.titleLabel.text = @"查询信息";
        titleView;
    });
    _firstView = ({
        UIView * view = [[UIView alloc] init ];
        view.backgroundColor = [UIColor whiteColor];
        
        UIView * line = [[UIView alloc ] init ];
        line.backgroundColor = [UIColor lightGrayColor];
        line.frame = CGRectMake(0, 0, kScreenWidth, 0.5);
        [view addSubview:line];
        
        view;
    });
    _authTitleView = ({
        TitleView * titleView = [[TitleView alloc ]init ];
        titleView.titleLabel.textAlignment = NSTextAlignmentLeft;
        titleView.titleLabel.text = @"商品认证信息";
        titleView;
    });
    _infoView = ({
        ScanGoodsInfoView * infoView = [[ScanGoodsInfoView alloc ]init ];
        infoView;
    });
    _extraView = ({
        ExtraView * extraView = [[ExtraView alloc ]init ];
        extraView;
    });
    _flowTitleView = ({
        TitleView * titleView = [[TitleView alloc ]init ];
        titleView.titleLabel.text = @"溯源信息";
        titleView.titleLabel.font = JXFontForNormal(15*kPercent);
        titleView.arrow.transform = CGAffineTransformRotate(titleView.arrow.transform, DEGREES_TO_RADIANS(180));
        titleView.open = NO;
        titleView;
    });
    [_headView addSubview:_resultView];
    //    [_headView addSubview:_firstTitleView];
    //    [_headView addSubview:_firstView];
    [_headView addSubview:_authTitleView];
    [_headView addSubview:_infoView];
    [_headView addSubview:_extraView];
    
    [_headView addSubview:_flowTitleView];
    
    [_resultView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(_headView);
        make.height.mas_equalTo(_resultViewHeight);
    }];
    //    [_firstTitleView mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.top.equalTo(_resultView.mas_bottom).offset(10);
    //        make.left.right.equalTo(_headView);
    //        make.height.mas_equalTo(40);
    //    }];
    //    [_firstView mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.top.equalTo(_firstTitleView.mas_bottom);
    //        make.left.right.equalTo(_headView);
    //        make.height.mas_equalTo(_firstViewHeight);
    //    }];
    [_authTitleView mas_makeConstraints:^(MASConstraintMaker *make) {
        //make.top.equalTo(_firstView.mas_bottom).offset(10);
        make.top.equalTo(_resultView.mas_bottom).offset(10);
        make.left.right.equalTo(_headView);
        make.height.mas_equalTo(40);
    }];
    [_infoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_authTitleView.mas_bottom);
        make.left.right.equalTo(_headView);
        make.height.mas_equalTo(_infoViewHeight);
    }];
    [_extraView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (_myProductType == Doubt) {
            make.top.equalTo(_infoView.mas_bottom).offset(0);
        }else{
            make.top.equalTo(_infoView.mas_bottom).offset(10);
        }
        make.top.equalTo(_infoView.mas_bottom).offset(10);
        make.left.right.equalTo(_headView);
        make.height.mas_equalTo(_extraViewHeight);
    }];
    [_flowTitleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_extraView.mas_bottom).offset(10);
        make.left.right.equalTo(_headView);
        make.height.mas_equalTo(40);
    }];
    
}
- (void)headViewConfig{
    _contentOffset = CGPointMake(0, 0);
    _varHeight = 0;
    
    _firstViewHeight = 0;
    _infoViewHeight = 0 + _varHeight;
    _extraViewHeight = 0;
    _headViewHeight =  10*4 + _resultViewHeight +40 *3 + _infoViewHeight + _extraViewHeight;
    
    self.collectionView.contentInset = UIEdgeInsetsMake(_headViewHeight, 0, 0, 0);
    
    //300 +20*6 + 16.5 *3 + 75 + 16.5 *2;
    
    _headView = [[UIView alloc]init];
    _headView.backgroundColor = JXF1f1f1Color;
    _headView.frame = CGRectMake(0, -_headViewHeight, kScreenWidth, _headViewHeight);
    [self.collectionView addSubview:_headView];
    
    [self addSubviews];
}
#pragma mark: 扫码结果-跑步鸡
#pragma mark: 扫码结果-其他
- (priceCompareView *)priceView{
    if (!_priceView) {
        _priceView = [[priceCompareView alloc ]initWithFrame:[UIScreen mainScreen].bounds];
        [[UIApplication sharedApplication].keyWindow addSubview:_priceView];
    }
    return _priceView;
}
- (JXSelectView *)companySelectView{
    if (!_companySelectView) {
        if ([_scanFinishModel.proDetailModel.countryType isEqualToString:@"kr"]) {
            _companySelectView = [[JXSelectView alloc ]initWithCustomView:[self addKrSelectSubViews]];
        } else {
            _companySelectView = [[JXSelectView alloc ]initWithCustomView:[self addCnSelectSubViews]];
        }
        _companySelectView.selectViewPosition = JXSelectViewShowPositionMiddle;
        _companySelectView.useTopButton = NO;
    }
    return _companySelectView;
}
- (JXSelectView *)deviceSelectView{
    if (!_deviceSelectView) {
        _deviceSelectView = [[JXSelectView alloc ]initWithCustomView:[self addDeviceTableView]];
        _deviceSelectView.selectViewPosition = JXSelectViewShowPositionMiddle;
        _deviceSelectView.useTopButton = NO;
    }
    return _deviceSelectView;
}
- (UIView *)addCnSelectSubViews{
    UIView * contentView = [[UIView alloc ]initWithFrame:CGRectMake(0, 0, kScreenWidth -40, kScreenWidth -40)];
    contentView.layer.masksToBounds = YES;
    contentView.layer.cornerRadius = 5;
    contentView.clipsToBounds = YES;
    contentView.backgroundColor = [UIColor whiteColor];
    //    contentView.layer.borderWidth = 10;
    //    contentView.layer.borderColor = JXMainColor.CGColor;
    
    UIView * blueBgView = [[UIView alloc ]init ];
    blueBgView.backgroundColor = JXColorFromRGB(0x00b9de);
    [contentView addSubview:blueBgView];
    
    UIImageView * logoImageView = [[UIImageView alloc ]init ];
    logoImageView.backgroundColor = JXDebugColor;
    logoImageView.image = JXImageNamed(@"company");
    [contentView addSubview:logoImageView];
    
    UIButton * closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [closeButton setImage:[JXImageNamed(@"popover_btn_close") imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]forState:UIControlStateNormal];
    closeButton.tintColor = [UIColor whiteColor];
    //[closeButton setTitle:@"ⅹ" forState:UIControlStateNormal];
    closeButton.backgroundColor = JXDebugColor;
    [closeButton addTarget:self action:@selector(close1) forControlEvents:UIControlEventTouchUpInside];
    [contentView addSubview:closeButton];
    
    
    UILabel * titleLabel = [[UILabel alloc] init ];
    titleLabel.text = @"企业介绍";
    titleLabel.textColor = JX333333Color;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = JXFontForNormal(16);
    [contentView addSubview:titleLabel];
    
    UILabel * nameLabel = [[UILabel alloc] init ];
    nameLabel.text = @"企业名称：正品溯源";
    nameLabel.text = [NSString stringWithFormat:@"企业名称：%@",self.scanFinishModel.proDetailModel.officeName];
    nameLabel.textColor = JX333333Color;
    nameLabel.textAlignment = NSTextAlignmentCenter;
    nameLabel.font = JXFontForNormal(13);
    [contentView addSubview:nameLabel];
    
    UILabel * numLabel = [[UILabel alloc] init ];
    numLabel.text = @"营业执照注册号：1234567656432425364";
    numLabel.text = [NSString stringWithFormat:@"营业执照注册号：%@",self.scanFinishModel.proDetailModel.regNo];
    numLabel.textColor = JX333333Color;
    numLabel.textAlignment = NSTextAlignmentCenter;
    numLabel.font = JXFontForNormal(13);
    [contentView addSubview:numLabel];
    
    
    UIButton * bottomButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [bottomButton setImage:JXImageNamed(@"auth") forState:UIControlStateNormal];
    [bottomButton setTitle:@"企业信息已认证" forState:UIControlStateNormal];
    [bottomButton setTitleColor:JXColorFromRGB(0xaf0808) forState:UIControlStateNormal];
    bottomButton.backgroundColor = JXDebugColor;
    bottomButton.titleLabel.font = JXFontForNormal(15);
    bottomButton.imageEdgeInsets = UIEdgeInsetsMake(0, -7.5, 0, 7.5);
    bottomButton.titleEdgeInsets = UIEdgeInsetsMake(0, 7.5, 0, -7.5);
    bottomButton.imageView.backgroundColor = JXDebugColor;
    bottomButton.titleLabel.backgroundColor = JXDebugColor;
    //bottomButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [contentView addSubview:bottomButton];
    
    
    
    [blueBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(contentView).offset(5);
        make.right.equalTo(contentView).offset(-5);
        make.height.mas_equalTo(100*kPercent);
    }];
    [logoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(blueBgView);
        make.size.mas_equalTo(CGSizeMake(70*kPercent, 70*kPercent));
    }];
    [closeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.equalTo(blueBgView);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(blueBgView.mas_bottom).offset(20);
        make.left.right.equalTo(contentView);
        make.height.mas_equalTo(20*kPercent);
    }];
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleLabel.mas_bottom).offset(35*kPercent);
        make.left.right.equalTo(contentView);
        make.height.mas_equalTo(20*kPercent);
    }];
    [numLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(nameLabel.mas_bottom).offset(30*kPercent);
        make.left.right.equalTo(contentView);
        make.height.mas_equalTo(20*kPercent);
    }];
    [bottomButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(numLabel.mas_bottom).offset(30*kPercent);
        make.left.right.equalTo(contentView);
        make.height.mas_equalTo(20*kPercent);
    }];
    
    return contentView;
}
- (UIView *)addKrSelectSubViews{
    UIView * contentView = [[UIView alloc ]initWithFrame:CGRectMake(0, 0, kScreenWidth -40, kScreenWidth -40)];
    contentView.layer.masksToBounds = YES;
    contentView.layer.cornerRadius = 5;
    contentView.clipsToBounds = YES;
    contentView.backgroundColor = [UIColor whiteColor];
    //    contentView.layer.borderWidth = 10;
    //    contentView.layer.borderColor = JXMainColor.CGColor;
    
    UIView * blueBgView = [[UIView alloc ]init ];
    blueBgView.backgroundColor = JXColorFromRGB(0x00b9de);
    [contentView addSubview:blueBgView];
    
    UIImageView * logoImageView = [[UIImageView alloc ]init ];
    logoImageView.backgroundColor = JXDebugColor;
    logoImageView.image = JXImageNamed(@"KrCompany");
    [contentView addSubview:logoImageView];
    
    UIButton * closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [closeButton setImage:[JXImageNamed(@"popover_btn_close") imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]forState:UIControlStateNormal];
    closeButton.tintColor = [UIColor whiteColor];
    //[closeButton setTitle:@"ⅹ" forState:UIControlStateNormal];
    closeButton.backgroundColor = JXDebugColor;
    [closeButton addTarget:self action:@selector(close1) forControlEvents:UIControlEventTouchUpInside];
    [contentView addSubview:closeButton];
    
    
    //    UILabel * titleLabel = [[UILabel alloc] init ];
    //    titleLabel.text = @"企业介绍";
    //    titleLabel.textColor = JX333333Color;
    //    titleLabel.textAlignment = NSTextAlignmentCenter;
    //    titleLabel.font = JXFontForNormal(16);
    //    [contentView addSubview:titleLabel];
    
    UILabel * nameLabel = [[UILabel alloc] init ];
    nameLabel.text = @"企业名称：正品溯源";
    nameLabel.text = [NSString stringWithFormat:@"企业名称：%@",self.scanFinishModel.proDetailModel.officeName];
    nameLabel.textColor = JX333333Color;
    nameLabel.textAlignment = NSTextAlignmentCenter;
    nameLabel.font = JXFontForNormal(14*kPercent);
    [contentView addSubview:nameLabel];
    
    UILabel * numLabel = [[UILabel alloc] init ];
    numLabel.text = @"营业执照注册号：1234567656432425364";
    numLabel.text = [NSString stringWithFormat:@"营业执照注册号：%@",self.scanFinishModel.proDetailModel.regNo];
    numLabel.textColor = JX333333Color;
    numLabel.textAlignment = NSTextAlignmentCenter;
    numLabel.font = JXFontForNormal(14*kPercent);
    [contentView addSubview:numLabel];
    
    UIImageView * leftImage = [[UIImageView alloc ]init ];
    leftImage.image = JXImageNamed(@"auth");
    [contentView addSubview:leftImage];
    
    UILabel * infoLabel = [[UILabel alloc] init ];
    infoLabel.text = @"该企业已通过中国电子商会（cecc）和正品溯源公司认证";
    infoLabel.textColor = JXColorFromRGB(0xaf0808);
    infoLabel.numberOfLines = 0;
    infoLabel.textAlignment = NSTextAlignmentCenter;
    infoLabel.font = JXFontForNormal(14*kPercent);
    [contentView addSubview:infoLabel];
    
    
    [blueBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(contentView).offset(5);
        make.right.equalTo(contentView).offset(-5);
        make.height.mas_equalTo(100*kPercent);
    }];
    [logoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(blueBgView);
        make.size.mas_equalTo(CGSizeMake(70*kPercent, 70*kPercent));
    }];
    [closeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.equalTo(blueBgView);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
    
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(blueBgView.mas_bottom).offset(35*kPercent);
        make.left.right.equalTo(contentView);
        make.height.mas_equalTo(20*kPercent);
    }];
    [numLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(nameLabel.mas_bottom).offset(35*kPercent);
        make.left.right.equalTo(contentView);
        make.height.mas_equalTo(20*kPercent);
    }];
    [leftImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(numLabel.mas_bottom).offset(30*kPercent);
        make.left.equalTo(contentView).offset(35);
        make.width.height.mas_equalTo(20*kPercent);
    }];
    [infoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(numLabel.mas_bottom).offset(30*kPercent);
        make.left.equalTo(leftImage.mas_right).offset(10);
        make.right.equalTo(contentView.mas_right).offset(-35);
        //make.height.mas_equalTo(40*kPercent);
    }];
    
    return contentView;
}
- (UIView *)addDeviceTableView{
    UIView * contentView = [[UIView alloc ]initWithFrame:CGRectMake(0, 0, kScreenWidth - 40, kScreenWidth - 40)];
    contentView.layer.masksToBounds = YES;
    contentView.layer.cornerRadius = 5;
    contentView.clipsToBounds = YES;
    contentView.backgroundColor = [UIColor whiteColor];
    
    UIView * blueBgView = [[UIView alloc ]init ];
    blueBgView.backgroundColor = JXColorFromRGB(0x00b9de);
    [contentView addSubview:blueBgView];
    
    UIImageView * logoImageView = [[UIImageView alloc ]init ];
    logoImageView.backgroundColor = JXDebugColor;
    logoImageView.image = JXImageNamed(@"scanDetail");
    [contentView addSubview:logoImageView];
    
    UIButton * closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [closeButton setImage:[JXImageNamed(@"popover_btn_close") imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]forState:UIControlStateNormal];
    closeButton.tintColor = [UIColor whiteColor];
    //[closeButton setTitle:@"ⅹ" forState:UIControlStateNormal];
    closeButton.backgroundColor = JXDebugColor;
    [closeButton addTarget:self action:@selector(close2) forControlEvents:UIControlEventTouchUpInside];
    [contentView addSubview:closeButton];
    
    UITableView * tableView = [[UITableView alloc ] initWithFrame:CGRectZero style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.contentInset = UIEdgeInsetsMake(110*kPercent, 0, 0, 0);
    tableView.rowHeight = 44;
    tableView.tag = 1001;
    tableView.backgroundColor = JXDebugColor;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [tableView registerClass:[DeviceCell class] forCellReuseIdentifier:@"cellId"];
    [contentView addSubview:tableView];
    
    NSString * infoStr = [NSString stringWithFormat:@"本商品已进行%lu次正品认证扫码（参考下方）",(unsigned long)_deviceArray.count];
    UILabel * infoLabel = [UILabel new];
    infoLabel.text = infoStr;
    infoLabel.textColor = JX333333Color;
    infoLabel.textAlignment = NSTextAlignmentCenter;
    infoLabel.font = JXFontForNormal(13);
    infoLabel.backgroundColor = JXDebugColor;
    infoLabel.numberOfLines = 0;
    [tableView addSubview:infoLabel];
    
    
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 6;
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    
    NSMutableAttributedString * attributeString = [[NSMutableAttributedString alloc ]initWithString:infoStr attributes:@{NSParagraphStyleAttributeName:paragraphStyle}];
    infoLabel.attributedText = attributeString;
    
    NSStringDrawingOptions option = NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading | NSStringDrawingTruncatesLastVisibleLine;
    CGRect rect = [infoStr boundingRectWithSize:CGSizeMake(contentView.size.width - 40, CGFLOAT_MAX) options:option attributes:@{NSParagraphStyleAttributeName:paragraphStyle,NSFontAttributeName:infoLabel.font} context:nil];
    
    
    
    [blueBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(contentView).offset(5*kPercent);
        make.right.equalTo(contentView).offset(-5*kPercent);
        make.height.mas_equalTo(105*kPercent);
    }];
    [logoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(blueBgView);
        make.height.mas_equalTo(77*kPercent);
        make.width.mas_equalTo(77*kPercent);
    }];
    [closeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(contentView.mas_top).offset(10*kPercent);
        make.right.equalTo(contentView.mas_right).offset(-10*kPercent);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
    
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(blueBgView.mas_bottom);
        make.left.right.equalTo(contentView);
        make.bottom.equalTo(contentView.mas_bottom);
    }];
    [infoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(tableView.mas_top).offset(-rect.size.height -12);
        make.left.equalTo(tableView.mas_left).offset(20);
        make.size.mas_equalTo(CGSizeMake(contentView.size.width - 40, rect.size.height +12));
    }];
    
    
    contentView.frame = CGRectMake(0, 20, kScreenWidth - 40,110*kPercent + rect.size.height +12 + 44 *3);
    tableView.contentOffset = CGPointMake(0, - (rect.size.height + 12));
    tableView.contentInset = UIEdgeInsetsMake(rect.size.height + 12, 0, 0, 0);
    
    return contentView;
}
- (void)comparePrice{
    self.priceView.VC = self.navigationController;
    self.priceView.show  = YES;
}
- (void)close1{
    [self.companySelectView dismiss];
}
- (void)close2{
    [self.deviceSelectView dismiss];
}
- (void)showDeviceView{
    [self.deviceSelectView show];
}
- (void)tapClick:(UITapGestureRecognizer * )tap{
    
    switch (tap.view.tag) {
        case 0:
        case 10:
        {
            [self.companySelectView show];
        }
            break;
            
        default:
            if ([_titleArray[tap.view.tag - 10] isEqualToString:@"检测报告"]) {
                NSArray * imageArray = [self.scanFinishModel.proDetailModel.reportFile componentsSeparatedByString:@","];
                JZAlbumViewController *imgVC = [[JZAlbumViewController alloc] init];
                imgVC.currentIndex = 0;
                imgVC.imgArr = imageArray;
                imgVC.title = @"检测报告";
                [self.navigationController pushViewController:imgVC animated:YES];
            }else if ([_titleArray[tap.view.tag - 10] isEqualToString:@"认证信息"]){
                NSArray * imageArray = [self.scanFinishModel.proDetailModel.certificateFile componentsSeparatedByString:@","];
                JZAlbumViewController *imgVC = [[JZAlbumViewController alloc] init];
                imgVC.currentIndex = 0;
                imgVC.imgArr = imageArray;
                imgVC.title = @"认证信息";
                [self.navigationController pushViewController:imgVC animated:YES];
            }else if ([_titleArray[tap.view.tag - 10] isEqualToString:@"商标权证书"]){
                NSArray * imageArray = [self.scanFinishModel.proDetailModel.ownershipFile componentsSeparatedByString:@","];
                JZAlbumViewController *imgVC = [[JZAlbumViewController alloc] init];
                imgVC.currentIndex = 0;
                imgVC.imgArr = imageArray;
                imgVC.title = @"商标权证书";
                [self.navigationController pushViewController:imgVC animated:YES];
            }else{
                NSArray * imageArray = [self.scanFinishModel.qualificate componentsSeparatedByString:@","];
                JZAlbumViewController *imgVC = [[JZAlbumViewController alloc] init];
                imgVC.currentIndex = 0;
                imgVC.imgArr = imageArray;
                imgVC.title = @"资质证书";
                [self.navigationController pushViewController:imgVC animated:YES];
            }
            break;
    }
}
#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _deviceArray.count + 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DeviceCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cellId" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.row == 0) {
        cell.timeLabel.text = @"扫码时间";
        cell.deviceLabel.text = @"机型";
        cell.addressLabel.text = @"扫码地点";
    } else {
        cell.deviceModel = (ScanrecordForSuspectProductModel *)_deviceArray[indexPath.row - 1];
    }
    
    
    return cell;
}

#pragma mark - Item height
- (CGFloat)waterFlow:(GuiderViewFlowLayout *)waterFlow headerIndexPath:(NSIndexPath *)indexPath{
    if (self.scanFinishModel.goodsFlowArr.count > 0) {
        return 40;
    }else{
        return 0.1;
    }
}
- (CGFloat)waterFlow:(GuiderViewFlowLayout *)waterFlow itemWidth:(CGFloat)itemW cellIndexPath:(NSIndexPath *)indexPath{
    
    if (self.scanFinishModel.goodsLotBatchArr.count > 0) {
        GoodsLotBatchModel * model = self.scanFinishModel.goodsLotBatchArr[indexPath.item];
        
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
        paragraphStyle.lineSpacing = 5;
        //paragraphStyle.paragraphSpacing = 6;
        
        NSStringDrawingOptions option = NSStringDrawingTruncatesLastVisibleLine |  NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
        NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:10],NSParagraphStyleAttributeName:paragraphStyle};
        CGRect rect = [model.event boundingRectWithSize:CGSizeMake(kScreenWidth -(105 + 20+ 0.5), CGFLOAT_MAX) options:option attributes:attributes context:nil];
        
        return rect.size.height + 10;
    }else{
        GoodsFlowModel * model = self.scanFinishModel.goodsFlowArr[indexPath.section];
        GoodsFlowSubModel * subModel = [GoodsFlowSubModel mj_objectWithKeyValues:model.list_batchField[indexPath.item]];
        
        NSString * contentStr = subModel.contents;
        
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
        //paragraphStyle.lineSpacing = 5;
        //paragraphStyle.paragraphSpacing = 6;
        
        NSStringDrawingOptions option =  NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
        NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:12],NSParagraphStyleAttributeName:paragraphStyle};
        CGRect rect = [contentStr boundingRectWithSize:CGSizeMake(kScreenWidth -(25 + 20*2), CGFLOAT_MAX) options:option attributes:attributes context:nil];
        
        //        if (rect.size.height < 20){
        //            CGRect frame = rect;
        //            frame.size.height = 14;
        //            rect = frame;
        //        }
        CGFloat pictureWidth = (kScreenWidth - 20 -15 -5 -25 *3)/3;
        CGFloat height =  10 *2 +10 + 13 + rect.size.height;
        NSArray * fileArr = @[];
        if ([subModel.file hasPrefix:@"http"]) {
            fileArr = [subModel.file componentsSeparatedByString:@","];
        }
        if (fileArr.count >0) {
            height += (10 + pictureWidth);
        }else{
            height += 10;
        }
        return height;
    }
    
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    if (_myProductType == Forge) {
        return 1;
    }
    if (_isCollectionViewOpen) {
        NSInteger count = self.scanFinishModel.goodsLotBatchArr.count >0 ? 1 : (self.scanFinishModel.goodsFlowArr.count >0 ? self.scanFinishModel.goodsFlowArr.count : 1);
        return count;
    }else{
        NSInteger count = self.scanFinishModel.goodsLotBatchArr.count >0 ? 1 : (self.scanFinishModel.goodsFlowShortArr.count >0 ? self.scanFinishModel.goodsFlowShortArr.count : 1);
        return count;
    }
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (_myProductType == Forge) {
        return 0;
    }
    if (_isCollectionViewOpen) {
        
        if (self.scanFinishModel.goodsLotBatchArr.count > 0) {
            return  self.scanFinishModel.goodsLotBatchArr.count;
        }else{
            if (self.scanFinishModel.goodsFlowArr.count > 0) {
                return ((GoodsFlowModel *)self.scanFinishModel.goodsFlowArr[section]).list_batchField.count;
            }else{
                return 0;
            }
            
        }
    }else{
        if (self.scanFinishModel.goodsLotBatchArr.count > 0) {
            if (self.scanFinishModel.goodsLotBatchArr.count >= 3 ) {
                return 3;
            }else{
                return  self.scanFinishModel.goodsLotBatchArr.count;
            }
        }else{
            if (self.scanFinishModel.goodsFlowShortArr.count > 0) {
                return ((GoodsFlowModel *)self.scanFinishModel.goodsFlowShortArr[section]).list_batchField.count;
            }else{
                return 0;
            }
            
        }
    }
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if (self.scanFinishModel.goodsLotBatchArr.count >0) {
        ScanFlowOldCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifierOldCell forIndexPath:indexPath];
        GoodsLotBatchModel * model = self.scanFinishModel.goodsLotBatchArr[indexPath.item];
        cell.model = model;
        return cell;
    }else{
        ScanFlowCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifierCell forIndexPath:indexPath];
        GoodsFlowModel * model = self.scanFinishModel.goodsFlowArr[indexPath.section] ;
        //GoodsFlowSubModel * subModel = [GoodsFlowSubModel mj_objectWithKeyValues: model.list_batchField[indexPath.item]];
        GoodsFlowSubModel * subModel = model.list_batchField[indexPath.item];
        cell.model = subModel;
        
        cell.block = ^(NSInteger index) {
            NSArray * imageArray = [subModel.file componentsSeparatedByString:@","];
            JZAlbumViewController *imgVC = [[JZAlbumViewController alloc] init];
            imgVC.currentIndex = index;
            imgVC.imgArr = imageArray;
            //imgVC.title = @"检测报告";
            [self.navigationController presentViewController:imgVC animated:YES completion:nil];
            //[self.navigationController pushViewController:imgVC animated:YES];
        };
        return cell;
    }
    // Configure the cell
    
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    if ((self.scanFinishModel.goodsLotBatchArr.count >0)) {
        UICollectionReusableView *headView =  [collectionView dequeueReusableSupplementaryViewOfKind :UICollectionElementKindSectionHeader withReuseIdentifier:reuseIdentifierHeader forIndexPath:indexPath];
        return headView;
    }else if (self.scanFinishModel.goodsFlowArr.count >0){
        
        ScanFlowCollectionReusableView *headView =  [collectionView dequeueReusableSupplementaryViewOfKind :UICollectionElementKindSectionHeader withReuseIdentifier:reuseIdentifierHeader forIndexPath:indexPath];
        if ([kind isEqualToString:UICollectionElementKindSectionHeader]){
            GoodsFlowModel * model = [GoodsFlowModel mj_objectWithKeyValues: self.scanFinishModel.goodsFlowArr[indexPath.section]];
            headView.titleLabel.text = model.process;
        }
        else if ([kind isEqualToString:UICollectionElementKindSectionFooter]){
            
        }
        
        //        if (_isCollectionViewOpen) {
        //            headView.hidden = NO;
        //            headView.frame = CGRectMake(headView.origin.x, headView.origin.y, kScreenWidth, 40);
        //        }else{
        //            headView.hidden = YES;
        //            headView.frame = CGRectMake(headView.origin.x, headView.origin.y, kScreenWidth, 0.1);
        //        }
        return headView;
    }else{
        UICollectionReusableView *headView =  [collectionView dequeueReusableSupplementaryViewOfKind :UICollectionElementKindSectionHeader withReuseIdentifier:reuseIdentifierHeader forIndexPath:indexPath];
        
        headView.backgroundColor = JXDebugColor;
        headView.hidden = YES;
        headView.frame = CGRectMake(headView.frame.origin.x, headView.frame.origin.y, kScreenWidth, 0.1);
        return headView;
    }
    
}
#pragma mark <UICollectionViewDelegate>
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView == _collectionView) {
        _contentOffset = scrollView.contentOffset;
    }
}

#pragma data
-(void)setScanFinishModel:(scanFinishModel *)scanFinishModel{
    
    _scanFinishModel = scanFinishModel;
    
    [self.view addSubview:self.collectionView];
    _isCollectionViewOpen = NO;
    _myProductType = Quality;
    
    [self headViewConfig];
    
    //查询结果信息
    [self setResultInfo:scanFinishModel];
    //首次查询信息
    //[self setFirstInfo];
    //商品认证信息
    [self setAuthInfo:scanFinishModel];
    //附加信息
    if (_myProductType != Doubt) {
        [self setExtraInfo:scanFinishModel];
    }
    
    JXWeakSelf(self)
    if ((self.scanFinishModel.goodsLotBatchArr.count >0 || self.scanFinishModel.goodsFlowArr.count > 0) && _myProductType != Forge){
        
        _flowTitleView.block = ^(BOOL isOpen, NSInteger index) {
            if (isOpen) {
                _isCollectionViewOpen = NO;
            }else{
                _isCollectionViewOpen = YES;
            }
            //isCollectionViewOpen = !isOpen;
            
            [weakSelf.collectionView reloadData];
        };
        if (_myProductType == Doubt) {
            _headViewHeight = 10*2 + _resultViewHeight +40 *2 + _firstViewHeight + _infoViewHeight + _extraViewHeight;
        }else{
            _headViewHeight = 10*3 + _resultViewHeight +40 *2 + _firstViewHeight + _infoViewHeight + _extraViewHeight;
        }
    }else{
        if (_myProductType == Doubt) {
            _headViewHeight = 10 + _resultViewHeight +40 + _firstViewHeight + _infoViewHeight + _extraViewHeight;
        }else{
            _headViewHeight = 10*2 + _resultViewHeight +40 + _firstViewHeight + _infoViewHeight + _extraViewHeight;
        }
        
        [_flowTitleView removeFromSuperview];
    }
    
    self.collectionView.contentInset = UIEdgeInsetsMake(_headViewHeight, 0, 0, 0);
    self.collectionView.contentOffset = CGPointMake(0, -_headViewHeight);
    _headView.frame = CGRectMake(0, -_headViewHeight, kScreenWidth, _headViewHeight);
    [self.collectionView reloadData];
    
    _deviceArray = [NSMutableArray arrayWithArray:scanFinishModel.scanrecordForSuspectProductArr];
}

- (void)setResultInfo:(scanFinishModel *)scanFinishModel{
    //扫描状态
    NSString * statusImgStr= @"quality";
    NSString * infoTitle = @"该商品经过CECC和正品溯源公司鉴定为正品";
    
    [_resultView.resultButton setTitle:[NSString stringWithFormat:@"正品溯源码：%@",scanFinishModel.proDetailModel.code] forState:UIControlStateNormal];
    //(25+132+15+25+8+16)+15+27+15 正品
    //(25+132+15+25+8+16)+10+13+15+44 可疑
    //(25+132+15+25+8+16)+10+13+15+44 伪品
    
    
    //scanFinishModel.quality = @"0";
    
    if ([scanFinishModel.quality isEqual: @"0"]) {
        _myProductType = Quality;
        _resultView.type = Quality;
        _resultViewHeight = ((25+132+15+25+8+16)+15+27+15)*kPercent;
        _resultView.bgImage.backgroundColor = JXColorFromRGB(0xb1d165);
        
        _resultView.detailLabel.hidden = YES;
        _resultView.detailButton.hidden = YES;
        
        _resultView.reportButton.layer.cornerRadius = 3.0f;
    }else if ([scanFinishModel.quality isEqual: @"1"]){
        _myProductType = Doubt;
        _resultView.type = Doubt;
        _resultViewHeight = ((25+132+15+25+8+16)+10+13+15+44)*kPercent;
        _resultView.bgImage.backgroundColor = JXColorFromRGB(0xf0de4f);
        statusImgStr = @"doubt";
        infoTitle = [NSString stringWithFormat:@"此正品溯源码已经被验证过%lu次",(long)scanFinishModel.scanrecordForSuspectProductArr.count];
        
        _resultView.detailLabel.text = @"请核对经销商资质并仔细检查商品，谨防假冒";
        [_resultView.detailButton addTarget:self action:@selector(showDeviceView) forControlEvents:UIControlEventTouchUpInside];
        
    }else{
        _myProductType = Forge;
        _resultView.type = Forge;
        _resultViewHeight = ((25+132+15+25+8+16)+10+13+15+44)*kPercent;
        _resultView.bgImage.backgroundColor = JXColorFromRGB(0xf57955);
        statusImgStr = @"forge";
        infoTitle = [NSString stringWithFormat:@"此正品溯源码已经被验证过%lu次",(long)scanFinishModel.scanrecordForSuspectProductArr.count];
        
        _resultView.detailLabel.text = @"请联系经销商或举报此商品";
        [_resultView.detailButton addTarget:self action:@selector(showDeviceView) forControlEvents:UIControlEventTouchUpInside];
    }
    [_resultView setNeedsUpdateConstraints];
    _resultView.infoLabel.text = infoTitle;
    _resultView.resultImageView.image = JXImageNamed(statusImgStr);
    [_resultView.resultButton setImage:JXImageNamed(@"ceccIcon") forState:UIControlStateNormal];
    
    [[_resultView.reportButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        ReportViewController * report = [[ReportViewController alloc ]initWithStyle:UITableViewStyleGrouped];
        report.PruductId = scanFinishModel.proDetailModel.ID;
        report.SNString = scanFinishModel.codeId;
        report.countryType = scanFinishModel.proDetailModel.countryType;
        report.porductModel = scanFinishModel.proDetailModel;
        [self.navigationController pushViewController:report animated:YES];
    }];
    
    [_resultView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_headView);
        make.left.right.equalTo(_headView);
        make.height.mas_equalTo(_resultViewHeight);
    }];
}
- (void)setFirstInfo{
    //首次查询信息
    CGFloat firstHeight = 15;
    NSArray * titleArray = @[@"首次查询时间",@"首次查询位置",@"首次查询机型"];
    
    for (int i = 0; i < titleArray.count; i ++) {
        UILabel * nameLabel = ({
            UILabel * lab = [UILabel new];
            lab.numberOfLines = 0;
            lab.font = JXFontForNormal(11);
            lab.textColor = JX999999Color;
            lab.backgroundColor = JXDebugColor;
            lab.lineBreakMode = NSLineBreakByTruncatingMiddle;
            lab.text = titleArray[i];
            lab;
        });
        UILabel * detailLabel = ({
            UILabel * lab = [UILabel new];
            lab.numberOfLines = 0;
            lab.font = JXFontForNormal(11);
            lab.textColor = JX333333Color;
            lab.backgroundColor = JXDebugColor;
            lab.numberOfLines = 0;
            lab;
        });
        [_firstView addSubview:nameLabel];
        
        [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_firstView.mas_top).offset(firstHeight);
            make.left.equalTo(_firstView).offset(15);
            make.width.mas_equalTo(13 *6);
            make.height.mas_equalTo(13);
        }];
        
        [_firstView addSubview:detailLabel];
        
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
        NSStringDrawingOptions option =  NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
        NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:11],NSParagraphStyleAttributeName:paragraphStyle};
        
        CGRect rect = CGRectZero;
        if (i == 0) {
            detailLabel.text = self.scanFinishModel.firstScanEntity.scanTime;
        }else if (i == 1){
            rect = [self.scanFinishModel.firstScanEntity.city boundingRectWithSize:CGSizeMake(kScreenWidth -(78 + 15 * 2), CGFLOAT_MAX) options:option attributes:attributes context:nil];
            detailLabel.text = self.scanFinishModel.firstScanEntity.city;
        }else{
            rect = [self.scanFinishModel.firstScanEntity.model boundingRectWithSize:CGSizeMake(kScreenWidth -(78 + 15 * 2), CGFLOAT_MAX) options:option attributes:attributes context:nil];
            detailLabel.text = self.scanFinishModel.firstScanEntity.model;
        }
        [detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(nameLabel.mas_top);
            make.left.equalTo(nameLabel.mas_right).offset(10);
            make.right.equalTo(_firstView.mas_right).offset(-15);
            if (rect.size.height < 20) {
                make.height.mas_equalTo(13);
            }else{
                make.height.mas_equalTo(rect.size.height);
            }
        }];
        if (rect.size.height < 20) {
            firstHeight += (15 +13);
        }else{
            firstHeight += (15 +rect.size.height);
        }
    }
    _firstViewHeight = firstHeight;
    [_firstView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_firstTitleView.mas_bottom);
        make.left.right.equalTo(_headView);
        make.height.mas_equalTo(_firstViewHeight);
    }];
}
- (void)setAuthInfo:(scanFinishModel *)scanFinishModel{
    NSArray * imageArray = [scanFinishModel.proDetailModel.goodsImg componentsSeparatedByString:@","];
    [_infoView setImageArray:imageArray];
    JXWeakSelf(self)
    _infoView.block = ^(BOOL isOpen, NSInteger index) {
        JZAlbumViewController *imgVC = [[JZAlbumViewController alloc] init];
        imgVC.currentIndex = index;
        imgVC.imgArr = imageArray;
        [weakSelf.navigationController presentViewController:imgVC animated:YES completion:nil];
    };
    //    BOOL isHaveBigImage = NO;
    //    if (imageArray.count && scanFinishModel.proDetailModel.goodsImg.length) {
    //        isHaveBigImage = YES;
    //
    //        [_infoView addSubview:_infoView.scrollView];
    //        [_infoView.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
    //            make.top.and.left.and.right.equalTo(_infoView).offset(0);
    //            make.height.mas_equalTo(200*kPercent);
    //        }];
    //
    //        _infoView.scrollView.imageNameArray = nil;
    //        _infoView.scrollView.imageNameArray = imageArray;
    //        _infoView.scrollView.pageStyle = UIPageControlPointStyle;
    //        _infoView.scrollView.pageControl.pageIndicatorTintColor = [UIColor whiteColor];
    //        _infoView.scrollView.pageControl.currentPageIndicatorTintColor = JXff5252Color;
    //    }
    
    //[_infoView.productImage sd_setImageWithURL:[NSURL URLWithString:scanFinishModel.proDetailModel.getfirstGoodImg] placeholderImage:nil];
    
    CGFloat infoHeight = 15;
    for (int i = 0; i < scanFinishModel.proDetailModel.list_ceccGoodsField.count; i ++) {
        UILabel * nameLabel = ({
            UILabel * lab = [UILabel new];
            lab.numberOfLines = 0;
            lab.font = JXFontForNormal(11);
            lab.textColor = JX333333Color;
            lab.backgroundColor = JXDebugColor;
            lab.lineBreakMode = NSLineBreakByTruncatingMiddle;
            lab.text = @"规格等级：";
            lab;
        });
        UILabel * detailLabel = ({
            UILabel * lab = [UILabel new];
            lab.numberOfLines = 0;
            //lab.lineBreakMode = NSLineBreakByWordWrapping;
            lab.font = JXFontForNormal(11);
            lab.textColor = JX333333Color;
            lab.backgroundColor = JXDebugColor;
            lab.text = @"优";
            lab.numberOfLines = 0;
            lab;
        });
        UIImageView * detailImageView = ({
            UIImageView * imageView = [UIImageView new];
            imageView.backgroundColor = JXDebugColor;
            imageView;
        });
        
        NSDictionary * dict = scanFinishModel.proDetailModel.list_ceccGoodsField[i];
        NSMutableString * name = [NSMutableString stringWithFormat:@"%@", dict[@"fieldName"]];
        if (name.length == 2) {
            [name insertString:@"   " atIndex:1];
        }
        nameLabel.text = [NSString stringWithFormat:@"%@:",name];
        NSInteger type = [dict[@"fieldType"] integerValue];
        [_infoView addSubview:nameLabel];
        
        [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_infoView.leftImage.mas_bottom).offset(infoHeight);
            make.left.equalTo(_infoView).offset(15);
            make.width.mas_equalTo(12 * 5);
            make.height.mas_equalTo(12);
        }];
        //字段类型：0文本 1号码 2数值 3金额 4下拉菜单 5日期时间 6图片文件
        if (type == 6) {
            [_infoView addSubview:detailImageView];
            if (dict[@"fieldValue"]) {
                [detailImageView sd_setImageWithURL:[NSURL URLWithString:dict[@"fieldValue"]] placeholderImage:nil];
            }
            
            [detailImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(nameLabel.mas_top);
                make.left.equalTo(nameLabel.mas_right).offset(15*kPercent);
                make.width.and.height.mas_equalTo(50*kPercent);
            }];
            
            infoHeight += (15 +50*kPercent);
            
        }else{
            [_infoView addSubview:detailLabel];
            
            //NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
            //paragraphStyle.lineSpacing = 5;
            //paragraphStyle.paragraphSpacing = 6;
            //NSParagraphStyleAttributeName:paragraphStyle
            
            NSMutableString * detail = [NSMutableString stringWithFormat:@" %@", dict[@"fieldValue"]];
            
            NSStringDrawingOptions option =  NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
            NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:11]};
            CGRect rect = [detail boundingRectWithSize:CGSizeMake(kScreenWidth -(60 + 15*2 + 15*kPercent), CGFLOAT_MAX) options:option attributes:attributes context:nil];
            detailLabel.text = detail;
            [detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(nameLabel.mas_top);
                make.left.equalTo(nameLabel.mas_right).offset(15*kPercent);
                make.right.equalTo(_infoView.mas_right).offset(-15);
                //                if (rect.size.height < 20) {
                //                    make.height.mas_equalTo(12);
                //                }else{
                //                    make.height.mas_equalTo(rect.size.height);
                //                }
            }];
            CGSize size = [detailLabel sizeThatFits:CGSizeMake(kScreenWidth -(60 + 15*2 + 15*kPercent), CGFLOAT_MAX)];
            if (size.height < 20) {
                infoHeight += (15 +12);
            }else{
                infoHeight += (15 +size.height);
            }
        }
        
    }
    _varHeight = infoHeight;
    _infoViewHeight = _infoView.imageHeight + _varHeight;
    //NSLog(@"_infoViewHeight = %ld",_infoViewHeight);
    
    [_infoView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_authTitleView.mas_bottom);
        make.left.right.equalTo(_headView);
        make.height.mas_equalTo(_infoViewHeight);
    }];
    //功能暂停
    _authTitleView.arrow.hidden = YES;
    //    _authTitleView.block = ^(BOOL isOpen,NSInteger index) {
    //
    //        if (isOpen) {
    //            headViewHeight -= infoViewHeight;
    //            infoViewHeight = 0;
    //            [infoView setHidden:YES];
    //        }else{
    //            infoViewHeight = 200 *kPercent + _varHeight;
    //            headViewHeight += infoViewHeight;
    //            [infoView setHidden:NO];
    //        }
    //        weakSelf.collectionView.contentInset = UIEdgeInsetsMake(headViewHeight, 0, 0, 0);
    //        headView.frame = CGRectMake(0, -headViewHeight, kScreenWidth, headViewHeight);
    //
    //        [infoView mas_remakeConstraints:^(MASConstraintMaker *make) {
    //            make.top.equalTo(authTitleView.mas_bottom);
    //            make.left.right.equalTo(headView);
    //            make.height.mas_equalTo(infoViewHeight);
    //        }];
    //    };
}
- (void)setExtraInfo:(scanFinishModel *)scanFinishModel{
    CGFloat imageViewWidth = 60;
    CGFloat space = (kScreenWidth - imageViewWidth* 3) /4;
    _titleArray = [NSMutableArray arrayWithObject:@"企业介绍"];
    _imageNameArray = [NSMutableArray arrayWithObject:@"companyProfile"];
    
    if (![scanFinishModel.proDetailModel.reportFile isEqualToString:@"<null>"] && scanFinishModel.proDetailModel.reportFile.length > 0) {
        [_titleArray addObject:@"检测报告"];
        [_imageNameArray addObject:@"examiningReport"];
    }
    if (![scanFinishModel.proDetailModel.certificateFile isEqualToString:@"<null>"] && scanFinishModel.proDetailModel.certificateFile.length > 0) {
        [_titleArray addObject:@"认证信息"];
        [_imageNameArray addObject:@"authentication"];
    }
    if (![scanFinishModel.qualificate isEqualToString:@"<null>"] && scanFinishModel.qualificate.length > 0) {
        [_titleArray addObject:@"资质证书"];
        [_imageNameArray addObject:@"qualificationCertificate"];
    }
    if (![scanFinishModel.proDetailModel.ownershipFile isEqualToString:@"<null>"] && scanFinishModel.proDetailModel.ownershipFile.length > 0) {
        [_titleArray addObject:@"商标权证书"];
        [_imageNameArray addObject:@"brandCertificate"];
    }
    for (int i = 0; i < _titleArray.count; i ++) {
        UIImageView * imageView = [[UIImageView alloc ]init ];
        imageView.image = JXImageNamed(_imageNameArray[i]);
        imageView.backgroundColor = JXDebugColor;
        imageView.tag = 10 +i;
        imageView.userInteractionEnabled = YES;
        
        UILabel * label = [[UILabel alloc ] init];
        label.backgroundColor = JXDebugColor;
        label.textAlignment = NSTextAlignmentCenter;
        label.font = JXFontForNormal(13.3);
        label.text = _titleArray[i];
        label.tag = 10 +i;
        label.textColor = JX333333Color;
        label.userInteractionEnabled = YES;
        
        [_extraView addSubview:imageView];
        [_extraView addSubview:label];
        
        
        UITapGestureRecognizer * tap1 = [[UITapGestureRecognizer alloc ]initWithTarget:self action:@selector(tapClick:)];
        UITapGestureRecognizer * tap2 = [[UITapGestureRecognizer alloc ]initWithTarget:self action:@selector(tapClick:)];
        [imageView addGestureRecognizer:tap1];
        [label addGestureRecognizer:tap2];
        
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_extraView).offset(10 + (imageViewWidth + 24 + 20)*(i/3));
            make.left.mas_equalTo(_extraView.mas_left).offset(space + (space +imageViewWidth) *(i%3));
            make.size.mas_equalTo(CGSizeMake(imageViewWidth, imageViewWidth));
        }];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(imageView.mas_bottom).offset(10);
            make.centerX.mas_equalTo(imageView);
            make.height.mas_equalTo(14);
            make.width.mas_equalTo(80);
        }];
    }
    if (_titleArray.count % 3 == 0) {
        _extraViewHeight = (10 + (60 +10 +14) + 10) * (_titleArray.count /3);
    }else{
        _extraViewHeight = (10 + (60 +10 +14) + 10) * (_titleArray.count /3 + 1);
    }
    [_extraView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_infoView.mas_bottom).offset(10);
        make.left.right.equalTo(_headView);
        make.height.mas_equalTo(_extraViewHeight);
    }];
    JXWeakSelf(self)
    _extraView.block = ^(BOOL isOpen, NSInteger index) {
        switch (index) {
            case 0:
            {
                [weakSelf.companySelectView show];
            }
                break;
            case 1:
            {
                NSArray * imageArray = [scanFinishModel.proDetailModel.reportFile componentsSeparatedByString:@","];
                JZAlbumViewController *imgVC = [[JZAlbumViewController alloc] init];
                imgVC.currentIndex = 0;
                imgVC.imgArr = imageArray;
                imgVC.title = @"检测报告";
                [weakSelf.navigationController pushViewController:imgVC animated:YES];
            }
                break;
            case 2:
            {
                NSArray * imageArray = [scanFinishModel.proDetailModel.certificateFile componentsSeparatedByString:@","];
                JZAlbumViewController *imgVC = [[JZAlbumViewController alloc] init];
                imgVC.currentIndex = 0;
                imgVC.imgArr = imageArray;
                imgVC.title = @"认证信息";
                [weakSelf.navigationController pushViewController:imgVC animated:YES];
            }
                break;
                
            default:
                break;
        }
    };
}
@end
