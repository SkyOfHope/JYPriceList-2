//
//  MallDetailViewController.m
//  JYPriceList
//
//  Created by jiangkuiquan on 2018/10/26.
//  Copyright © 2018年 jiangkuiquan. All rights reserved.
//

#import "MallDetailViewController.h"

#import "TopHorisenBrandView.h"

#import "MallDetailLeftTableViewCell.h"
#import "MallDetailGoodsTableViewCell.h"

#import "ShowQrcodeView.h"
#import "GlobalVariable.h"

#import "MallDetailInfoModel.h"
#import "MallDetailGalleryModel.h"
#import "MallDetailProModel.h"
#import "MallDetailProductsModel.h"

#import "MallDetailContentView.h"
#import "MallGoodsInfoModel.h"

#import "MallGoodsListModel.h"


static NSString *const MallDetailLeftTableViewCellID = @"MallDetailLeftTableViewCellIdentifier";

@interface MallDetailViewController ()<UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *topHorisenScrollView;
@property (weak, nonatomic) IBOutlet UIView *topBackView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentBackViewTopLayout;
@property (weak, nonatomic) IBOutlet UITableView *leftTableView;

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) TopHorisenBrandView *topTagView;
@property (nonatomic, strong) TopHorisenBrandView *topSelectTagView;
@property (nonatomic, strong) ShowQrcodeView *showQrcodeView;
@property (nonatomic, strong) MallDetailContentView *contentView;
@property (nonatomic, strong) MallDetailInfoModel *infoModel;

@property (nonatomic, strong) MallGoodsInfoModel *goodsInfoModel;

@property (nonatomic, strong) NSMutableArray *mallDetailAttrNameArr;

@property (nonatomic, assign) NSInteger backScrollViewHeight;

//@property (nonatomic, assign) CGFloat goodsProViewHeight;

@end

@implementation MallDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.mallDetailAttrNameArr = [NSMutableArray array];
    
    [self requestMallGoodsInfo];
    [self setUpUI];
    [self buildNavRightBtn];
    [self setTopView];
    
    weakSelf(weakSelf);
    self.leftTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf requestMallGoodsList:NO];
    }];
    
    self.leftTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [weakSelf requestMallGoodsList:YES];
    }];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self requestMallGoodsInfo];
    [self setTopView];
    [MobClick beginLogPageView:@"隐形护理液商品详情页"];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:@"隐形护理液商品详情页"];
}


-(void)setUpUI{
    self.backScrollViewHeight = ScreenHeight - MallDetailContentTopHeight- NavHeight - Margin;
    self.leftTableView.showsVerticalScrollIndicator = NO;
    self.leftTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self buildNavRightBtn];
    
    //注册cell
    [self.leftTableView registerNib:[UINib nibWithNibName:@"MallDetailLeftTableViewCell" bundle:nil] forCellReuseIdentifier:MallDetailLeftTableViewCellID];
//    [self buildWithScrollView];
    [self buildBackScrollView];
}

-(void)buildBackScrollView{
    
    self.scrollView.frame = CGRectMake(MallDetailLeftTabeViewWidth + Margin, self.contentBackViewTopLayout.constant, ScreenWidth - MallDetailLeftTabeViewWidth - Margin * 2, self.backScrollViewHeight);
    self.scrollView.delegate = self;
    //隐藏垂直滚动条
    self.scrollView.showsVerticalScrollIndicator = NO;
    //取消弹簧效果
    self.scrollView.bounces = NO;
//    self.scrollView.backgroundColor = [UIColor yellowColor];
    //[self.view insertSubview:scroll atIndex:0];
    
    [self.view addSubview:self.scrollView];
}

-(void)buildWithScrollView{
    
    self.scrollView.contentSize = CGSizeMake(0, self.goodsInfoModel.goodsProViewHeight+425 + 500);
    
//    self.contentView = [[MallDetailContentView alloc] init];
    self.contentView = [[MallDetailContentView alloc] initWithModel:self.goodsInfoModel];
    self.contentView.backgroundColor = [UIColor orangeColor];
    self.contentView.height = 425 + self.goodsInfoModel.goodsProViewHeight + 500;
    self.contentView.goodsProViewHeight = self.goodsInfoModel.goodsProViewHeight;
    
//    self.contentView.detailGoodsInfoModel = self.goodsInfoModel;
    
    self.contentView.attrNameArr = self.mallDetailAttrNameArr;
    self.contentView.topLayout = self.contentBackViewTopLayout.constant;
    [self.contentView setUpUI];
    [self.scrollView addSubview:self.contentView];
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
    self.navigationItem.rightBarButtonItem = rightItem;
    
    /*
    UIButton *rightTwoNavButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightTwoNavButton.frame = CGRectMake(88, 0, 100, 30);
    rightTwoNavButton.hidden = NO;
    [rightTwoNavButton setBackgroundImage:[UIImage imageNamed:@"navBtnBack"] forState:UIControlStateNormal];
    [rightTwoNavButton setBackgroundImage:[UIImage imageNamed:@"navBtnBack"] forState:UIControlStateSelected];
    [rightTwoNavButton setAdjustsImageWhenHighlighted:NO];
    [rightTwoNavButton setTitle:@"显示定制片" forState:UIControlStateNormal];
    [rightTwoNavButton setTitle:@"显示现片" forState:UIControlStateSelected];
    [rightTwoNavButton addTarget:self action:@selector(rightTwoNavButton:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightTwoItem = [[UIBarButtonItem alloc]initWithCustomView:rightTwoNavButton];
//    self.navigationItem.rightBarButtonItems = @[rightItem,rightTwoItem];
    */
}

//创建顶部横画按钮
-(void)setTopView{
    if (@available(iOS 11.0, *)) {
        self.topHorisenScrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        NSLog(@"11.0f");
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
        NSLog(@"10f");
    }
    self.topHorisenScrollView.showsHorizontalScrollIndicator = NO;
    self.topHorisenScrollView.contentSize = CGSizeMake(90*self.topDataArr.count, 0);
    for (int i=0; i<self.topDataArr.count; i++) {
        self.topTagView = [[TopHorisenBrandView alloc] init];
        self.topTagView.frame = CGRectMake(i*90, 0, 90, 100);
        self.topTagView.tag = i+1;
        
        MallBrandListModel *model = self.topDataArr[i];
        [self.topTagView buildWithMallBrandListModel:model];
        
        if (i == self.topSelectNum-1) {
            self.topTagView.nameLab.textColor = [UIColor colorWithRed:63/255.0f green:105/255.0f blue:165/255.0f alpha:1];
            self.topTagView.iconBackView.layer.borderColor = [UIColor colorWithRed:63/255.0f green:105/255.0f blue:165/255.0f alpha:1].CGColor;
            
            self.topSelectTagView = self.topTagView;
            //获取商品信息
            //self.goodsId = model.ID;
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
            if (self.delegate && [self.delegate respondsToSelector:@selector(TopSelectNum:)]) {
                [self.delegate TopSelectNum:view.tag];
                [self.navigationController popViewControllerAnimated:YES];
            }
        }];
        [self.topHorisenScrollView addSubview:self.topTagView];
    }
}

#pragma mark - 点击事件
-(void)rightNavButton:(UIButton *)sender{
    NSLog(@"点击导航栏右侧按钮");
    sender.selected = !sender.selected;
    if (sender.selected) {
        self.topBackView.hidden = YES;
        self.contentBackViewTopLayout.constant = 20;
        self.backScrollViewHeight = ScreenHeight - self.contentBackViewTopLayout.constant - NavHeight - Margin;
        [self buildBackScrollView];
    }else{
        self.topBackView.hidden = NO;
        self.contentBackViewTopLayout.constant = MallDetailContentTopHeight;
        self.backScrollViewHeight = ScreenHeight - MallDetailContentTopHeight - NavHeight - Margin;
        [self buildBackScrollView];
    }
    
}

-(void)rightTwoNavButton:(UIButton *)sender{
    NSLog(@"点击按钮");
    sender.selected = !sender.selected;
    NSString * strTest=[GlobalVariable sharedGlobalVariable].strTest;
    NSLog(@"%@",strTest);
    [GlobalVariable sharedGlobalVariable].strTest=@"第二次修改";
}

- (IBAction)qrcodeButtonClickAction:(UIButton *)sender {
    _showQrcodeView = [[ShowQrcodeView alloc] init];
    _showQrcodeView.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
    _showQrcodeView.backgroundColor = [UIColor colorWithRed:0/255 green:0/255 blue:0/255 alpha:.5];
    [[[UIApplication sharedApplication].windows lastObject] addSubview:self.showQrcodeView];
}

#pragma mark - UITableViewDelegate && UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return  self.leftDataArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MallDetailLeftTableViewCell *cell = [self.leftTableView dequeueReusableCellWithIdentifier:MallDetailLeftTableViewCellID forIndexPath:indexPath];
    if (indexPath.row == self.leftSelectCellRow) {//指定第一行为选中状态
        [self.leftTableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionMiddle];
    }
    [cell buildWithModel:self.leftDataArr[indexPath.row]];
    //去除点击变色
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 160;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    MallGoodsListModel *model = self.leftDataArr[indexPath.row];
    self.mallDetailId = model.ID;
    [self requestMallGoodsInfo];
}

#pragma mark - 数据请求
/**
 *  停止刷新
 */
-(void)endRefresh{
    [self.leftTableView.mj_header endRefreshing];
    [self.leftTableView.mj_footer endRefreshing];
}

//商品详情
-(void)requestMallGoodsInfo{
    
    NSUserDefaults *defaut = [NSUserDefaults standardUserDefaults];
    NSString *token = [defaut objectForKey:@"token"];
    
    NSMutableDictionary *para = [NSMutableDictionary dictionary];
    [para setObject:self.mallDetailId forKey:@"id"];
    [para setObject:@1 forKey:@"ceshi"];
    
    [self.mallDetailAttrNameArr removeAllObjects];
    
    [[HRRequestManager manager] POST_PATH:Post_MallGoodsInfo WithToken:token para:para success:^(id responseObject) {
        if ([responseObject[@"status"] integerValue] == 1) {
            NSLog(@"数据请求成功");
            
            self.goodsInfoModel = [[MallGoodsInfoModel alloc] initWithDictionary:responseObject[@"data"]];

            self.mallDetailAttrNameArr = responseObject[@"data"][@"attr_name"];
            
            [self buildWithScrollView];
        }else{
            NSLog(@"数据请求失败");
        }
        
    } failure:^(NSError *error) {
        NSLog(@"网络请求失败");
        
    }];
    
}

//11.分类商品信息(左侧列表)
-(void)requestMallGoodsList:(BOOL)isMore{
    
    NSUserDefaults *defaut = [NSUserDefaults standardUserDefaults];
    NSString *token = [defaut objectForKey:@"token"];
    
    NSMutableDictionary *para = [NSMutableDictionary dictionary];
    
    //分类id 不可以为空
    [para setObject:self.leftListCat_id forKey:@"id"];

    //品牌id 可以为空
    if (self.leftListBid != nil) {
        [para setObject:self.leftListBid forKey:@"bid"];
    }
    //规格  可以为空 0.0.0.0.162563
    if (self.leftListFilter != nil) {
        [para setObject:self.leftListFilter forKey:@"filter"];
    }
    
    [para setObject:@1 forKey:@"ceshi"];
    
    [self.leftDataArr removeAllObjects];
    weakSelf(weakSelf);
    [[HRRequestManager manager] POST_PATH:Post_MallGoodsList WithToken:token     para:para success:^(id responseObject) {
        if ([responseObject[@"status"] integerValue] == 1) {
            NSLog(@"数据请求成功");
            [weakSelf endRefresh];
            self.leftListCurrentPage = [responseObject[@"data"][@"current_page"] integerValue];
            
            for (NSDictionary *dic in responseObject[@"data"][@"data"]) {
                MallGoodsListModel *model = [[MallGoodsListModel alloc] initWithDictionary:dic];
                
                [weakSelf.leftDataArr addObject:model];
            }
            
        }else{
            NSLog(@"数据请求失败");
        }
       
        [weakSelf endRefresh];
        [weakSelf.leftTableView reloadData];
    } failure:^(NSError *error) {
        NSLog(@"网络请求失败");
        [weakSelf endRefresh];
    }];
    
}

#pragma mark - 懒加载
-(ShowQrcodeView *)showQrcodeView{
    if (!_showQrcodeView) {
        _showQrcodeView = [[ShowQrcodeView alloc] init];
    }
    
    return _showQrcodeView;
}

-(UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
    }
    
    return _scrollView;
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
