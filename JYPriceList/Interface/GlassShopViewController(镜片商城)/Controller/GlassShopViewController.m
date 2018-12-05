//
//  GlassShopViewController.m
//  JYPriceList
//
//  Created by jiangkuiquan on 2018/8/28.
//  Copyright © 2018年 jiangkuiquan. All rights reserved.
//

#import "GlassShopViewController.h"

//顶部横画子view
#import "TopHorisenBrandView.h"

#import "LeftOneTableViewCell.h"
#import "GlassTypeTableViewCell.h"
#import "InfoTableViewCell.h"

#import "LeftTopView.h"
#import "HeadInfoView.h"

#import "SeriesListModel.h"
#import "GoodsListModel.h"

#import "ShowQrcodeView.h"

static NSString *const LeftOneTableViewCellID = @"LeftOneTableViewCellIdentifier";
static NSString *const GlassTypeTableViewCellID = @"GlassTypeTableViewCellIdengtifier";
static NSString *const InfoTableViewCellID = @"InfoTableViewCellIdentifier";
@interface GlassShopViewController ()<UITableViewDelegate, UITableViewDataSource,UIScrollViewDelegate>{
//    CGFloat _constX;
}

//列表背景view距顶部约束
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *listBackViewTopLayout;
//顶部横滑按钮背景view
@property (weak, nonatomic) IBOutlet UIView *topBackView;
//中间列表背景view
@property (weak, nonatomic) IBOutlet UIView *listBackView;
//顶部横画ScrollView
@property (weak, nonatomic) IBOutlet UIScrollView *horisonScrollView;

@property (nonatomic, strong) TopHorisenBrandView *topTagView;
@property (nonatomic, strong) TopHorisenBrandView *topSelectTagView;

////左侧属性TableView
@property (nonatomic, strong) UITableView *leftTableView;
//内容TableView
@property (nonatomic, strong) UITableView *infoTableView;

//内容容器
@property (nonatomic, strong) UIScrollView *contentView;

@property (nonatomic, strong) LeftTopView *leftTopView;
@property (nonatomic, strong) HeadInfoView *headInfoView;

//展示二维码界面
@property (nonatomic, strong) ShowQrcodeView *showQrcodeView;

//@property (nonatomic, strong) NSArray *shopArr;
//@property (nonatomic, strong) NSArray *goodsArr;

//@property (nonatomic, assign) CGFloat leftViewWidth;
//@property (nonatomic, assign) CGFloat leftViewHeight;
@property (nonatomic, assign) CGFloat leftTableViewHeight;

@property (nonatomic, assign) CGFloat totleWidth;
@property (nonatomic, assign) CGFloat shopWidth;
@property (nonatomic, assign) CGFloat shopX;

//@property (nonatomic, assign) CGFloat zheSheHeight;
//@property (nonatomic, assign) CGFloat guangDuHeight;
//@property (nonatomic, assign) CGFloat infoWidth;
//@property (nonatomic, assign) CGFloat tagViweHeiht;
//@property (nonatomic, assign) CGFloat juDingBuHeight;

@property (nonatomic, assign) CGFloat contentViewHeight;

//数据源
@property (nonatomic, strong) NSMutableArray *topDataSourceArr;
@property (nonatomic, strong) NSArray *topArr;
//现片
@property (nonatomic, strong) NSArray *nowArr;
//定制片
@property (nonatomic, strong) NSArray *specificArr;

@property (nonatomic, assign) NSArray *currentArr;
@property (nonatomic, assign) NSString *currentArrType;
@property (nonatomic, assign) NSInteger currentTypeID;

@property (nonatomic, strong) NSString *goodsId;

@property (nonatomic, strong) NSMutableArray *goodsListDataArr;


@end

@implementation GlassShopViewController

#pragma mark ------  生命周期  --------
- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.leftViewWidth = 260;
//    self.leftViewHeight = 90;
//    self.zheSheHeight = 72;
//    self.guangDuHeight = 130;
//    self.infoWidth = 200;
////    self.tagViweHeiht = 50;
//    self.juDingBuHeight = 140;
    
    self.contentViewHeight = ScreenHeight - JYGlassShopVCTopHeight - JYGlassShopVCNavHeight - JYGlassShopVCMargin;
    self.leftTableViewHeight = ScreenHeight - JYGlassShopVCLeftViewHeight - JYGlassShopVCTopHeight - JYGlassShopVCNavHeight - JYGlassShopVCMargin;

//    self.contentViewHeight = ScreenHeight - JYGlassShopVCTopHeight - JYGlassShopVCNavHeight - JYGlassShopVCMargin;
//    self.leftTableViewHeight = ScreenHeight - JYGlassShopVCLeftViewHeight - JYGlassShopVCTopHeight - JYGlassShopVCNavHeight - JYGlassShopVCMargin;
    
    // Do any additional setup after loading the view from its nib.
    self.topDataSourceArr = [NSMutableArray array];
    self.goodsListDataArr = [NSMutableArray array];
    
//    [self configData];
    [self setUpUI];
    
    //获取顶部列表数据
    [self requestSeriesList];
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //在viewWillAppear或viewDidLoad方法中添加以下代码
//    self.navigationController.navigationBar.translucent = YES;
    
    //self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
//    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    //UIImage *img = [self createImageWithColor:[UIColor whiteColor]];
    
    [self.navigationController.navigationBar setBackgroundImage:[self createImageWithColor:[UIColor whiteColor]] forBarMetrics:UIBarMetricsDefault];
    
    [MobClick beginLogPageView:@"镜片价格列表页"];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:@"镜片价格列表页"];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark --------- 私有方法
-(void)setUpUI{
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"镜片商城";
    
    //注册cell
    [self.leftTableView registerNib:[UINib nibWithNibName:@"LeftOneTableViewCell" bundle:nil] forCellReuseIdentifier:LeftOneTableViewCellID];
    [self.leftTableView registerNib:[UINib nibWithNibName:@"GlassTypeTableViewCell" bundle:nil] forCellReuseIdentifier:GlassTypeTableViewCellID];
    [self.infoTableView registerNib:[UINib nibWithNibName:@"InfoTableViewCell" bundle:nil] forCellReuseIdentifier:InfoTableViewCellID];
    
//    [self setTopView];
    [self configScrollView];
}

//设置导航栏
-(void)buildNavRightBtn{
    UIButton *rightNavButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightNavButton.frame = CGRectMake(0, 0, 34, 30);
    [rightNavButton setImage:[UIImage imageNamed:@"fold"] forState:UIControlStateNormal];
    [rightNavButton setImage:[UIImage imageNamed:@"folddown"] forState:UIControlStateSelected];
    [rightNavButton setAdjustsImageWhenHighlighted:NO];
    [rightNavButton addTarget:self action:@selector(rightNavButton:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightNavButton];
    
    UIButton *rightTwoNavButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightTwoNavButton.frame = CGRectMake(88, 0, 100, 30);
    if (self.topArr.count == 2) {
        rightTwoNavButton.hidden = NO;
        [rightTwoNavButton setBackgroundImage:[UIImage imageNamed:@"navBtnBack"] forState:UIControlStateNormal];
        [rightTwoNavButton setBackgroundImage:[UIImage imageNamed:@"navBtnBack"] forState:UIControlStateSelected];
        [rightTwoNavButton setAdjustsImageWhenHighlighted:NO];
        [rightTwoNavButton setTitle:@"显示定制片" forState:UIControlStateNormal];
        [rightTwoNavButton setTitle:@"显示现片" forState:UIControlStateSelected];
    }else if(self.topArr.count == 1){
        rightTwoNavButton.hidden = YES;
//        if (self.nowArr.count>0) {
//            rightTwoNavButton.hidden = NO;
//            [rightTwoNavButton setBackgroundImage:[UIImage imageNamed:@"navBtnBack"] forState:UIControlStateNormal];
//            [rightTwoNavButton setBackgroundImage:[UIImage imageNamed:@"navBtnBack"] forState:UIControlStateSelected];
//            [rightTwoNavButton setTitle:@"现片" forState:UIControlStateNormal];
//            [rightTwoNavButton setTitle:@"现片" forState:UIControlStateSelected];
//        }else if (self.specificArr.count > 0){
//            rightTwoNavButton.hidden = NO;
//            [rightTwoNavButton setBackgroundImage:[UIImage imageNamed:@"navBtnBack"] forState:UIControlStateNormal];
//            [rightTwoNavButton setBackgroundImage:[UIImage imageNamed:@"navBtnBack"] forState:UIControlStateSelected];
//            [rightTwoNavButton setTitle:@"定制片" forState:UIControlStateNormal];
//            [rightTwoNavButton setTitle:@"定制片" forState:UIControlStateSelected];
//        }else{
//
//        }
    }
    
    [rightTwoNavButton addTarget:self action:@selector(rightTwoNavButton:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightTwoItem = [[UIBarButtonItem alloc]initWithCustomView:rightTwoNavButton];
    self.navigationItem.rightBarButtonItems = @[rightItem,rightTwoItem];
    
    /*
    if ([GlobalVariable sharedGlobalVariable].isCheck == YES) {
        UIButton *rightThreeNavButton = [UIButton buttonWithType:UIButtonTypeCustom];
        rightThreeNavButton.frame = CGRectMake(130, 5, 40, 40);
        [rightThreeNavButton setBackgroundImage:[UIImage imageNamed:@"geren"] forState:UIControlStateNormal];
        
        [rightThreeNavButton setAdjustsImageWhenHighlighted:NO];
        [rightThreeNavButton addTarget:self action:@selector(rightThreeNavButton:) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *rightThreeItem = [[UIBarButtonItem alloc]initWithCustomView:rightThreeNavButton];
        self.navigationItem.rightBarButtonItems = @[rightItem,rightTwoItem,rightThreeItem];
    }else{
        self.navigationItem.rightBarButtonItems = @[rightItem,rightTwoItem];
    }
    
    */
    
}

//创建顶部横画按钮
-(void)setTopView{
    if (@available(iOS 11.0, *)) {
        self.horisonScrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        NSLog(@"11.0f");
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
        NSLog(@"10f");
    }
    self.horisonScrollView.showsHorizontalScrollIndicator = NO;
    self.horisonScrollView.contentSize = CGSizeMake(90*self.topDataSourceArr.count, 0);
    for (int i=0; i<self.topDataSourceArr.count; i++) {
        self.topTagView = [[TopHorisenBrandView alloc] init];
        self.topTagView.frame = CGRectMake(i*90, 0, 90, 100);
        
        SeriesListModel *model = self.topDataSourceArr[i];
        [self.topTagView buildWithModel:model];
        
        self.topTagView.tagCateID = model.ID;
        
        if (i == 0) {
            self.topTagView.nameLab.textColor = [UIColor colorWithRed:63/255.0f green:105/255.0f blue:165/255.0f alpha:1];
            self.topTagView.iconBackView.layer.borderColor = [UIColor colorWithRed:63/255.0f green:105/255.0f blue:165/255.0f alpha:1].CGColor;
            self.topSelectTagView = self.topTagView;
            //获取商品信息
            self.goodsId = model.ID;
            [self requestGoodsinfos];
        }
        weakSelf(weakSelf);
        [self.topTagView chooseAction:^(TopHorisenBrandView *view,NSString *goodsId) {
            if (view != self.topSelectTagView) {
                view.nameLab.textColor = [UIColor colorWithRed:63/255.0f green:105/255.0f blue:165/255.0f alpha:1];
                
                view.iconBackView.layer.borderColor = [UIColor colorWithRed:63/255.0f green:105/255.0f blue:165/255.0f alpha:1].CGColor;
                weakSelf.topSelectTagView.nameLab.textColor = [UIColor lightGrayColor];
                weakSelf.topSelectTagView.iconBackView.layer.borderColor = [UIColor lightGrayColor].CGColor;
                
                weakSelf.topSelectTagView = view;
            }
            
            self.goodsId = goodsId;
            //获取商品信息
            [self requestGoodsinfos];
        }];
        [self.horisonScrollView addSubview:self.topTagView];
    }
}

//配置
-(void)configScrollView{
    [self.listBackView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    if (@available(iOS 11.0, *)) {
        self.contentView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        NSLog(@"11.0f");
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
        NSLog(@"10f");
    }
    _contentView = [[UIScrollView alloc] initWithFrame:CGRectMake(JYGlassShopVCLeftViewWidth, 0, ScreenWidth - JYGlassShopVCLeftViewWidth - 40, self.contentViewHeight)];
    _contentView.delegate = self;
    _contentView.showsVerticalScrollIndicator = NO;
    _contentView.showsHorizontalScrollIndicator = NO;
    _contentView.bounces = NO;
    
    _contentView.bounces = NO;
//    _contentView.backgroundColor = [UIColor yellowColor];
    [self.listBackView addSubview:_contentView];
    
    //配置左侧list
    self.leftTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, JYGlassShopVCLeftViewHeight, JYGlassShopVCLeftViewWidth, self.leftTableViewHeight) style:UITableViewStylePlain];
//    self.leftTableView.backgroundColor = [UIColor yellowColor];
    self.leftTableView.delegate = self;
    self.leftTableView.dataSource = self;
    self.leftTableView.showsVerticalScrollIndicator = NO;
    self.leftTableView.showsHorizontalScrollIndicator = NO;
    self.leftTableView.bounces = NO;
    self.leftTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.listBackView addSubview:self.leftTableView];
    
    [self configTableHeader];
}


-(void)configTableHeader{
    
    [self.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    self.leftTopView = [[LeftTopView alloc] init];
    self.leftTopView.frame = CGRectMake(0, 0, JYGlassShopVCLeftViewWidth, JYGlassShopVCLeftViewHeight);
    [self.listBackView addSubview:self.leftTopView];
    
    _totleWidth = 0;
    _shopX = 0;
    _shopWidth = 0;
    
    for (int i = 0; i < self.goodsListDataArr.count; i++) {

        GoodsListModel *model = self.goodsListDataArr[i];
        
        _shopWidth = model.list.count * JYGlassShopVCInfoWidth + (model.list.count - 1)*1.5;
//        NSLog(@"====== _shopWidth ====== %f",_shopWidth);
        _totleWidth = _totleWidth + _shopWidth+1.5;
//        NSLog(@"====== totleWidth ====== %f",_totleWidth);
        _shopX = _totleWidth - _shopWidth;
//        NSLog(@"====== _shopX ====== %f",_shopX);
        
        _contentView.contentSize = CGSizeMake(_totleWidth, self.contentViewHeight);
        self.headInfoView = [[HeadInfoView alloc] init];
        [self.headInfoView buildWithGoodsListModel:model];
        self.headInfoView.frame = CGRectMake(_shopX, 0, _shopWidth, JYGlassShopVCInfoWidth);
        [_contentView addSubview:self.headInfoView];
    }
    
    //配置infoList
    self.infoTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, JYGlassShopVCLeftViewHeight, _totleWidth, self.leftTableViewHeight) style:UITableViewStylePlain];
    self.infoTableView.delegate = self;
    self.infoTableView.dataSource = self;
    self.infoTableView.showsVerticalScrollIndicator = NO;
    self.infoTableView.showsHorizontalScrollIndicator = NO;
    self.infoTableView.bounces = NO;
    self.infoTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.contentView addSubview:self.infoTableView];
}

#pragma mark - 点击事件
-(void)rightNavButton:(UIButton *)sender{
    NSLog(@"点击导航栏右侧按钮");
    sender.selected = !sender.selected;
    if (sender.selected) {
        self.topBackView.hidden = YES;
        self.listBackViewTopLayout.constant = 20;
        self.contentViewHeight = ScreenHeight - 20 - 64 - 20;
        self.leftTableViewHeight = ScreenHeight - JYGlassShopVCLeftViewHeight - 20 - JYGlassShopVCNavHeight - 20;
        
    }else{
        self.topBackView.hidden = NO;
        self.listBackViewTopLayout.constant = JYGlassShopVCTopHeight;
        self.contentViewHeight = ScreenHeight - JYGlassShopVCTopHeight - 64 - 20;
        self.leftTableViewHeight = ScreenHeight - JYGlassShopVCLeftViewHeight - JYGlassShopVCTopHeight - 64 - 20;
    }
    
    [self configScrollView];
}

-(void)rightTwoNavButton:(UIButton *)sender{
    NSLog(@"点击按钮");
    sender.selected = !sender.selected;
    
    if (self.topArr.count == 2) {
        if (sender.selected == YES) {
            self.currentArr = self.specificArr;
            self.currentArrType = @"定制片";
            self.currentTypeID = 1;
        }else{
            self.currentArr = self.nowArr;
            self.currentArrType = @"现片";
            self.currentTypeID = 0;
        }
            
    }else if(self.topArr.count == 1){
        if (self.nowArr.count>0) {
            self.currentArr = self.nowArr;
            self.currentArrType = @"现片";
            self.currentTypeID = 0;
        }else if (self.specificArr.count > 0){
            self.currentArr = self.specificArr;
            self.currentArrType = @"定制片";
            self.currentTypeID = 1;
        }else{
            self.currentArr = nil;
            self.currentArrType = @"";
            
        }
    }
    
    [self.leftTableView reloadData];
    [self.infoTableView reloadData];
    
}

-(void)rightThreeNavButton:(UIButton *)sender{
    NSLog(@"个人中心");
    //这里的话是通过遍历循环拿到之前在AppDelegate中声明的那个MMDrawerController属性，然后判断是否为打开状态，如果是就关闭，否就是打开(初略解释，里面还有一些条件)
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideRight animated:YES completion:nil];
    
}

#pragma mark UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == self.leftTableView) {
        
        return self.currentArr.count+1;
    }else if (tableView == self.infoTableView){
        return 1;
    }
    
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.leftTableView) {
        if (indexPath.row == 0) {
            LeftOneTableViewCell *leftOneCell = [self.leftTableView dequeueReusableCellWithIdentifier:LeftOneTableViewCellID];
            
            if (!leftOneCell) {
                leftOneCell = [[NSBundle mainBundle] loadNibNamed:@"LeftOneTableViewCell" owner:self options:nil].lastObject;
            }
            leftOneCell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            return leftOneCell;
        } else {
            GlassTypeTableViewCell *cell = [self.leftTableView dequeueReusableCellWithIdentifier:GlassTypeTableViewCellID];
            if (!cell) {
                cell = [[NSBundle mainBundle] loadNibNamed:@"GlassTypeTableViewCell" owner:self options:nil].lastObject;
            }
            cell.isTopShow = self.topBackView.hidden;
            cell.glassTypeNameLab.text = self.currentArrType;
            if ([self.currentArrType isEqualToString:@"现片"]) {
                [cell buildWithNowArr:self.currentArr];
            }else if ([self.currentArrType isEqualToString:@"定制片"]){
                [cell buildWithSpecificArr:self.currentArr];
            }
            
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            return cell;
        }
    }else if (tableView == self.infoTableView){
        InfoTableViewCell *cell = [self.infoTableView dequeueReusableCellWithIdentifier:InfoTableViewCellID];
        if (!cell) {
            cell = [[NSBundle mainBundle] loadNibNamed:@"InfoTableViewCell" owner:self options:nil].lastObject;
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.topDataArr = self.topArr;
        cell.nowDataArr = self.nowArr;
        cell.specificDataArr = self.specificArr;
        cell.currentDataType = self.currentTypeID;
        cell.isTopShow = self.topBackView.hidden;
        [cell configShopCountWithArr:self.goodsListDataArr];
        
        weakSelf(weakSelf);
        cell.infoTableViewCellBlock = ^(NSString *qrcodeImg) {
            [weakSelf.showQrcodeView.qrcodeImg sd_setImageWithURL:[NSURL URLWithString:qrcodeImg]];
//            weakSelf.showQrcodeView.y = -20;
//            weakSelf.showQrcodeView.height = ScreenWidth;
//            weakSelf.showQrcodeView.width = ScreenWidth;
//            weakSelf.showQrcodeView.backgroundColor = [UIColor clearColor];
            weakSelf.showQrcodeView.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
            weakSelf.showQrcodeView.backgroundColor = [UIColor colorWithRed:0/255 green:0/255 blue:0/255 alpha:.5];
            [[[UIApplication sharedApplication] delegate].window addSubview:weakSelf.showQrcodeView];
        };
        
        
        return cell;
    }
    
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.leftTableView) {
        if (indexPath.row == 0) {
            return JYGlassShopVCZheSheHeight;
        }else if (indexPath.row == 1){
            return self.leftTableViewHeight - JYGlassShopVCZheSheHeight;
        }
    }
    else if (tableView == self.infoTableView){
        return self.leftTableViewHeight;
    }
    
    return 0;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView == self.leftTableView) {
        [self.infoTableView setContentOffset:CGPointMake(_infoTableView.contentOffset.x, self.leftTableView.contentOffset.y)];
    }
    if (scrollView == _infoTableView) {
        [self.leftTableView setContentOffset:CGPointMake(0, _infoTableView.contentOffset.y)];
    }
}

#pragma mark - 数据请求
//3.获取顶部横向滑动
-(void)requestSeriesList{
    
    NSMutableDictionary *para = [NSMutableDictionary dictionary];
    [para setObject:[NSString stringWithFormat:@"%ld",(long)self.brand_id] forKey:@"id"];
    
    
    [self.topDataSourceArr removeAllObjects];
    [[HRRequestManager manager] POST_PATH:Post_SeriesList para:para success:^(id responseObject) {
        if ([responseObject[@"status"] integerValue] == 1) {
            NSLog(@"网络请求成功");
            for (NSDictionary *dic in responseObject[@"data"]) {
                SeriesListModel *model = [[SeriesListModel alloc] initWithDictionary:dic];
                [self.topDataSourceArr addObject:model];
            }
        }
        [self setTopView];
        
    } failure:^(NSError *error) {
        
    }];
    
}

//获取商品信息
-(void)requestGoodsinfos{
    NSMutableDictionary *para = [NSMutableDictionary dictionary];
    if (self.goodsId.length > 0) {
        [para setObject:self.goodsId forKey:@"id"];
    }else{
        [MBProgressHUD showInfoMessage:@"请选择系列"];
    }
    
    NSUserDefaults *defaut = [NSUserDefaults standardUserDefaults];
    NSString *token = [defaut objectForKey:@"token"];
    
    [self.goodsListDataArr removeAllObjects];
    self.topArr = [NSArray array];
    self.nowArr = [NSArray array];
    self.specificArr = [NSArray array];
    
    [[HRRequestManager manager] POST_PATH:Post_Goodsinfos WithToken:token para:para success:^(id responseObject) {
        
        if ([responseObject[@"status"] integerValue] == 1) {
            NSLog(@"数据请求成功");
            
            //现片--订制片数据
            self.topArr = responseObject[@"data"][@"top"];
            if (self.topArr.count == 2) {
                if ([responseObject[@"data"][@"top"] isKindOfClass:[NSDictionary class]]){
                    self.specificArr = responseObject[@"data"][@"top"][@"1"];
                    self.nowArr = responseObject[@"data"][@"top"][@"0"];
                }
                if ([responseObject[@"data"][@"top"] isKindOfClass:[NSArray class]]){
                    self.nowArr = responseObject[@"data"][@"top"][0];
                    self.specificArr = responseObject[@"data"][@"top"][1];
                }
                self.currentArrType = @"现片";
                self.currentArr = self.nowArr;
                self.currentTypeID = 0;
            }else if(self.topArr.count == 1){
                if ([responseObject[@"data"][@"top"] isKindOfClass:[NSArray class]]){
                    self.nowArr = responseObject[@"data"][@"top"][0];
                    self.currentArr = self.nowArr;
                    self.currentArrType = @"现片";
                    self.currentTypeID = 0;
                }
                if ([responseObject[@"data"][@"top"] isKindOfClass:[NSDictionary class]]){
                    self.specificArr = responseObject[@"data"][@"top"][@"1"];
                    self.currentArr = self.specificArr;
                            self.currentArrType = @"定制片";
                    self.currentTypeID = 1;
                }
                
            }else if(self.topArr.count <= 0){
                self.currentArr = nil;
            }
            
            //GoodsList
            for (NSDictionary *dic in responseObject[@"data"][@"GoodsList"]) {
                GoodsListModel *model = [[GoodsListModel alloc]  initWithDictionary:dic];
                
                [self.goodsListDataArr addObject:model];
            }
            
//            self.leftTableViewHeight = self.zheSheHeight + (self.guangDuHeight + 6)*2 + (self.nowArr.count + self.specificArr.count) * self.tagViweHeiht;
            
            [self buildNavRightBtn];
            [self configTableHeader];
            [self.leftTableView reloadData];
            [self.infoTableView reloadData];
            
        }else{
            NSLog(@"网络请求失败");
            
        }
        
    } failure:^(NSError *error) {
        
    }];
    
}

#pragma mark --------- 懒加载 ---------
-(ShowQrcodeView *)showQrcodeView{
    if (!_showQrcodeView) {
        _showQrcodeView = [[ShowQrcodeView alloc] init];
    }
    
    return _showQrcodeView;
}


//UIColor 转UIImage（UIImage+YYAdd.m也是这种实现）
- (UIImage*) createImageWithColor: (UIColor*) color
{
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
