//
//  MallViewController.m
//  JYPriceList
//
//  Created by jiangkuiquan on 2018/10/25.
//  Copyright © 2018年 jiangkuiquan. All rights reserved.
//

#import "MallViewController.h"

#import "TopHorisenBrandView.h"
#import "MallCollectionViewCell.h"
#import "LeftTableViewCell.h"

#import "MallBrandListModel.h"
#import "MallFirstFilterListModel.h"
#import "MallSecondFilterListModel.h"
#import "MallGoodsListModel.h"

#import "ShowQrcodeView.h"
#import "MallDetailViewController.h"

static NSString *const LeftTableViewCellID = @"LeftTableViewCellIdentifer";
static NSString *const MallCollectionViewCellID = @"MallCollectionViewCellIdentifier";
@interface MallViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,MallDetailDelegate>
@property (weak, nonatomic) IBOutlet UITextField *inputPageTextField;

@property (weak, nonatomic) IBOutlet UIView *topBackView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentBackViewTopLayout;

@property (weak, nonatomic) IBOutlet UIScrollView *topHorizonScrollView;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (weak, nonatomic) IBOutlet UITableView *leftTableView;
@property (weak, nonatomic) IBOutlet UILabel *totalCountLab;
@property (weak, nonatomic) IBOutlet UILabel *aimLeftLab;
@property (weak, nonatomic) IBOutlet UILabel *aimRightLab;
@property (weak, nonatomic) IBOutlet UIView *onlyOnePageBackView;


@property (nonatomic, strong) TopHorisenBrandView *topTagView;
@property (nonatomic, strong) TopHorisenBrandView *topSelectTagView;
@property (nonatomic, strong) ShowQrcodeView *showQrcodeView;

@property (nonatomic, strong) NSMutableArray *dataSourceArr;
@property (nonatomic, strong) NSMutableArray *topDataSourceArr;
@property (nonatomic, strong) NSMutableArray *leftDataSourceArr;

@property (nonatomic, strong) NSString *mallBrand_id;
@property (nonatomic, strong) NSString *mallFilter;
@property (nonatomic, assign) NSInteger currentPage;
@property (nonatomic, assign) NSUInteger inputPage;
@property (nonatomic, assign) NSInteger totalNum;
@property (nonatomic, assign) NSInteger topSelectNum;
@property (nonatomic, assign) BOOL isDefaultTopSelect;

@end

@implementation MallViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.topDataSourceArr = [NSMutableArray array];
    self.dataSourceArr = [NSMutableArray array];
    self.leftDataSourceArr = [NSMutableArray array];
    
    self.topSelectNum = [@"" integerValue];
    
    [self setUpUI];
    [self buildNavRightBtn];
    
    //9.分类品牌列表
    [self requestMallBrandList];
//    //10.分类规格列表
//    [self requestMallFilterList];
//    //11.分类商品信息
//    [self requestMallGoodsList:NO];
    
    weakSelf(weakSelf);
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [weakSelf requestMallGoodsList:NO];
        
        self.aimLeftLab.backgroundColor = [UIColor colorWithRed:63/255.0f green:105/255.0f blue:165/255.0f alpha:1];
        if (self.currentPage>1) {
            self.aimLeftLab.text = [NSString stringWithFormat:@"%ld",self.currentPage-1];
        }else{
            self.aimLeftLab.text = @"1";
        }
        
        self.aimLeftLab.textColor = [UIColor whiteColor];
        
        self.aimRightLab.backgroundColor = [UIColor whiteColor];
        if (self.currentPage<2) {
            self.aimRightLab.text = @"2";
        }else{
            self.aimRightLab.text = [NSString stringWithFormat:@"%ld",self.currentPage];
        }
        
        self.aimRightLab.textColor = [UIColor darkGrayColor];
        
    }];
    
    self.collectionView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        
        [weakSelf requestMallGoodsList:YES];
        
        if (self.currentPage * 12 <= self.totalNum) {
            self.aimRightLab.backgroundColor = [UIColor colorWithRed:63/255.0f green:105/255.0f blue:165/255.0f alpha:1];
            self.aimRightLab.text = [NSString stringWithFormat:@"%ld",self.currentPage+1];
            self.aimRightLab.textColor = [UIColor whiteColor];
            
            self.aimLeftLab.backgroundColor = [UIColor whiteColor];
            self.aimLeftLab.text = [NSString stringWithFormat:@"%ld",self.currentPage];
            self.aimLeftLab.textColor = [UIColor darkGrayColor];
        }
        
    }];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [MobClick beginLogPageView:@"隐形护理液列表页"];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:@"隐形护理液列表页"];
}

-(void)setUpUI{
    
    self.aimLeftLab.backgroundColor = [UIColor colorWithRed:63/255.0f green:105/255.0f blue:165/255.0f alpha:1];
    self.aimLeftLab.textColor = [UIColor whiteColor];
    
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.alwaysBounceVertical = YES;
    self.leftTableView.showsVerticalScrollIndicator = NO;
    self.leftTableView.alwaysBounceVertical = NO;
    self.leftTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    //注册cell
    [self.collectionView registerNib:[UINib nibWithNibName:@"MallCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:MallCollectionViewCellID];
    [self.leftTableView registerNib:[UINib nibWithNibName:@"LeftTableViewCell" bundle:nil] forCellReuseIdentifier:LeftTableViewCellID];
    
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
//-(void)buildTopViewWithArr:(NSArray *)topArr{
-(void)buildTopView{
//    if (@available(iOS 11.0, *)) {
//        self.topHorizonScrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
//        NSLog(@"11.0f");
//    } else {
//        self.automaticallyAdjustsScrollViewInsets = NO;
//        NSLog(@"10f");
//    }
    self.topHorizonScrollView.showsHorizontalScrollIndicator = NO;
    self.topHorizonScrollView.contentSize = CGSizeMake(90*self.topDataSourceArr.count, 0);
    for (int i=0; i<self.topDataSourceArr.count; i++) {
        self.topTagView = [[TopHorisenBrandView alloc] init];
        self.topTagView.tag = i+1;
        self.topTagView.frame = CGRectMake(i*90, 5, 90, 100);
        MallBrandListModel *model = self.topDataSourceArr[i];
        
        [self.topTagView buildWithMallBrandListModel:model];
        
        self.topTagView.tagCateID = model.brand_id;
        if (i == 0) {
            self.topTagView.nameLab.textColor = [UIColor colorWithRed:63/255.0f green:105/255.0f blue:165/255.0f alpha:1];
            self.topTagView.iconBackView.layer.borderColor = [UIColor colorWithRed:63/255.0f green:105/255.0f blue:165/255.0f alpha:1].CGColor;
            self.topSelectTagView = self.topTagView;
            
            //获取商品信息
            self.mallBrand_id = model.brand_id;
            self.mallFilter = nil;
            [self requestMallFilterList];
            [self requestMallGoodsList:NO];
            
        }
        if (self.isDefaultTopSelect == YES) {
            if (i == self.topSelectNum-1) {
                self.topTagView.nameLab.textColor = [UIColor colorWithRed:63/255.0f green:105/255.0f blue:165/255.0f alpha:1];
                self.topTagView.iconBackView.layer.borderColor = [UIColor colorWithRed:63/255.0f green:105/255.0f blue:165/255.0f alpha:1].CGColor;
                self.topSelectTagView = self.topTagView;
                //获取商品信息
                self.mallBrand_id = model.brand_id;
//                [self requestMallFilterList];
                self.mallFilter = nil;
                [self requestMallFilterList];
                [self requestMallGoodsList:NO];
//                [self.collectionView.mj_header beginRefreshing];
            }
        }
        
        weakSelf(weakSelf);
        [self.topTagView chooseAction:^(TopHorisenBrandView *view,NSString *goodsId) {
            if (view != self.topSelectTagView) {
                view.nameLab.textColor = [UIColor colorWithRed:63/255.0f green:105/255.0f blue:165/255.0f alpha:1];
                view.iconBackView.layer.borderColor = [UIColor colorWithRed:63/255.0f green:105/255.0f blue:165/255.0f alpha:1].CGColor;
                self.topSelectNum = view.tag;
                
                weakSelf.topSelectTagView.nameLab.textColor = [UIColor lightGrayColor];
                weakSelf.topSelectTagView.iconBackView.layer.borderColor = [UIColor lightGrayColor].CGColor;
                weakSelf.topSelectTagView = view;
            }
            self.aimLeftLab.backgroundColor = [UIColor colorWithRed:63/255.0f green:105/255.0f blue:165/255.0f alpha:1];
            self.aimLeftLab.text = @"1";
            self.aimLeftLab.textColor = [UIColor whiteColor];
            
            self.aimRightLab.backgroundColor = [UIColor whiteColor];
            self.aimRightLab.text = @"2";
            self.aimRightLab.textColor = [UIColor darkGrayColor];
            
            self.mallBrand_id = goodsId;
            self.mallFilter = nil;
            [self requestMallFilterList];
            [self requestMallGoodsList:NO];
            
        }];
        [self.topHorizonScrollView addSubview:self.topTagView];
    }
}

#pragma mark - private delegate
-(void)TopSelectNum:(NSInteger)num{
    NSLog(@"123123");
    self.topSelectNum = num;
    self.isDefaultTopSelect = YES;
    [self buildTopView];
}


#pragma mark - UITextFieldDelegate

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    return YES;
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    
    if (textField == self.inputPageTextField) {
        self.inputPage = [self.inputPageTextField.text integerValue];
    }
    if (self.inputPage > self.currentPage) {
        self.currentPage = self.inputPage - 1;
        [self.collectionView.mj_footer beginRefreshing];
    }else{
        self.currentPage = self.inputPage+1;
        [self.collectionView.mj_header beginRefreshing];
    }
    
}

#pragma mark - 点击事件
-(void)rightNavButton:(UIButton *)sender{
    NSLog(@"点击导航栏右侧按钮");
    sender.selected = !sender.selected;
    if (sender.selected) {
        self.topBackView.hidden = YES;
        self.contentBackViewTopLayout.constant = 20;
        
    }else{
        self.topBackView.hidden = NO;
        self.contentBackViewTopLayout.constant = 120;
        
    }
    
}

-(void)rightTwoNavButton:(UIButton *)sender{
    NSLog(@"点击按钮");
    sender.selected = !sender.selected;
    
}

- (void)tapGR:(UITapGestureRecognizer *)tapGR {
    
    //获取section
    NSInteger section = tapGR.view.tag - 2016;
    
    MallFirstFilterListModel *model = self.leftDataSourceArr[section];
    
    //判断改变bool值
    if (model.isOpen == YES) {
        model.isOpen = NO;
        [self.leftDataSourceArr replaceObjectAtIndex:section withObject:model];
    }else{
        model.isOpen = YES;
        [self.leftDataSourceArr replaceObjectAtIndex:section withObject:model];
    }
    
    //刷新某个section
    [self.leftTableView reloadSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:UITableViewRowAnimationFade];
}

- (IBAction)PageButtonClickAction:(UIButton *)sender {
    
    if (sender.tag == 1) {
        [self.collectionView.mj_header beginRefreshing];
        self.aimLeftLab.backgroundColor = [UIColor colorWithRed:63/255.0f green:105/255.0f blue:165/255.0f alpha:1];
//        if (self.currentPage>1) {
//            self.aimLeftLab.text = [NSString stringWithFormat:@"%ld",self.currentPage-1];
//        }else{
//            self.aimLeftLab.text = @"1";
//        }
//
//        self.aimLeftLab.textColor = [UIColor whiteColor];
//
//        self.aimRightLab.backgroundColor = [UIColor whiteColor];
//        if (self.currentPage<2) {
//            self.aimRightLab.text = @"2";
//        }else{
//            self.aimRightLab.text = [NSString stringWithFormat:@"%ld",self.currentPage];
//        }
//
//        self.aimRightLab.textColor = [UIColor darkGrayColor];
//
    }else if (sender.tag == 2){
        [self.collectionView.mj_footer beginRefreshing];
//        self.aimRightLab.backgroundColor = [UIColor colorWithRed:63/255.0f green:105/255.0f blue:165/255.0f alpha:1];
//        self.aimRightLab.text = [NSString stringWithFormat:@"%ld",self.currentPage+1];
//        self.aimRightLab.textColor = [UIColor whiteColor];
//        
//        self.aimLeftLab.backgroundColor = [UIColor whiteColor];
//        self.aimLeftLab.text = [NSString stringWithFormat:@"%ld",self.currentPage];
//        self.aimLeftLab.textColor = [UIColor darkGrayColor];
//        
    }
    
}



#pragma mark - UITableViewDelegate && UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return self.leftDataSourceArr.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    MallFirstFilterListModel *model = self.leftDataSourceArr[section];
    if (model.isOpen == NO) {
        
        return 0;
    }else {
        
        return model.values.count;
    }
    
    return 0;
}


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    MallFirstFilterListModel *model = self.leftDataSourceArr[section];
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 137, 50)];
    headerView.tag = 2016 + section;
//    headerView.backgroundColor = [UIColor colorWithRed:235/255.0 green:235/255.0 blue:235/255.0 alpha:1];
    headerView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    //添加底部下划线
//    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 49, 116, 1)];
//    lineView.backgroundColor = [UIColor darkGrayColor];
//    [headerView addSubview:lineView];
    //添加底部虚线
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    [shapeLayer setBounds:headerView.bounds];
    [shapeLayer setPosition:headerView.center];
    
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
    CGPathMoveToPoint(path,NULL, 0,48);
    
    //添加一条直线,从初始点到该函数指定的终点
    CGPathAddLineToPoint(path, NULL, headerView.width, 48);
    
    [shapeLayer setPath:path];
    
    CGPathRelease(path);
    
    //  把绘制好的虚线添加上来
    [headerView.layer addSublayer:shapeLayer];
    
    
    //添加标题label
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(30, 0, 87, 50)];
    label.numberOfLines = 0;
    label.textAlignment = NSTextAlignmentCenter;
    
    label.text = model.attr_name;
    [headerView addSubview:label];
    
    //添加imageView
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 15, 20, 20)];
    if (model.isOpen == NO) {
        imgView.image = [UIImage imageNamed:@"xiajiantou"];
    }else{
        imgView.image = [UIImage imageNamed:@"shangjiantou"];
    }
    [headerView addSubview:imgView];
    
    //添加轻扣手势
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGR:)];
    [headerView addGestureRecognizer:tap];
    
    return headerView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 40;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LeftTableViewCell *cell = [self.leftTableView dequeueReusableCellWithIdentifier:LeftTableViewCellID forIndexPath:indexPath];
    MallFirstFilterListModel *model = self.leftDataSourceArr[indexPath.section];
    
    [cell buildWithModel:model.values[indexPath.row]];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 50;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    MallFirstFilterListModel *model = self.leftDataSourceArr[indexPath.section];
    MallSecondFilterListModel *modelTwo = model.values[indexPath.row];
    
    self.mallFilter = modelTwo.filter;
//    [self requestMallGoodsList:NO];
    [self.collectionView.mj_header beginRefreshing];
}


#pragma mark - UICollectionViewDelegate && UICollectionViewDataSource
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.dataSourceArr.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath{
    
    MallCollectionViewCell *item = [self.collectionView dequeueReusableCellWithReuseIdentifier:MallCollectionViewCellID forIndexPath:indexPath];
    MallGoodsListModel *model;
    if (self.dataSourceArr.count>0) {
        model = self.dataSourceArr[indexPath.row];
    }
    [item buildWithModel:model];
    
    weakSelf(weakSelf);
    item.mallCollectionViewCellBlock = ^(NSInteger tag) {
        NSLog(@"跳转详情页面");
    
        switch (tag) {
            case 1:{
                weakSelf.showQrcodeView.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
                weakSelf.showQrcodeView.backgroundColor = [UIColor colorWithRed:0/255 green:0/255 blue:0/255 alpha:.5];
                [weakSelf.showQrcodeView creatCIQRCodeImageWithStr:[NSString stringWithFormat:@"{type:'group',group:%@}",model.qrcode_id]];
                [[[UIApplication sharedApplication].windows lastObject] addSubview:weakSelf.showQrcodeView];
            }
                break;
            case 2:{
                MallDetailViewController *mallDetailVC = [[MallDetailViewController alloc] init];
                UIBarButtonItem *bar = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:0 target:nil action:nil];
                
                mallDetailVC.delegate = weakSelf;
                
                mallDetailVC.mallDetailId = model.ID;
                mallDetailVC.topDataArr = weakSelf.topDataSourceArr;
                mallDetailVC.leftDataArr = weakSelf.dataSourceArr;
                mallDetailVC.topSelectNum = weakSelf.topSelectNum;
                mallDetailVC.leftSelectCellRow = indexPath.row;
                mallDetailVC.leftListCurrentPage = self.currentPage;
                mallDetailVC.leftListCat_id = self.cat_id;
                mallDetailVC.leftListBid = self.mallBrand_id;
                mallDetailVC.leftListFilter = self.mallFilter;
                
                [weakSelf.navigationItem setBackBarButtonItem:bar];
                [weakSelf.navigationController pushViewController:mallDetailVC animated:YES];
            }
                break;
                
            default:
                break;
        }
        
        
    };
    
    return item;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(nonnull UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(nonnull NSIndexPath *)indexPath{
    
    return CGSizeMake((ScreenWidth-120-60-80)/4, (ScreenHeight - 120 - 90 - 20-64)/2);
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(nonnull UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    return UIEdgeInsetsMake(0, 0, 10, 0);
}

#pragma mark - 数据请求
/**
 *  停止刷新
 */
-(void)endRefresh{
    [self.collectionView.mj_header endRefreshing];
    [self.collectionView.mj_footer endRefreshing];
}

//9.分类品牌列表
-(void)requestMallBrandList{
    
    NSUserDefaults *defaut = [NSUserDefaults standardUserDefaults];
    NSString *token = [defaut objectForKey:@"token"];
    
    NSMutableDictionary *para = [NSMutableDictionary dictionary];
    [para setObject:self.cat_id forKey:@"id"];
    [para setObject:@1 forKey:@"ceshi"];
    
    [self.topDataSourceArr removeAllObjects];
    [[HRRequestManager manager] POST_PATH:Post_MallBrandList WithToken:token para:para success:^(id responseObject) {
        if ([responseObject[@"status"] integerValue] == 1) {
            NSLog(@"数据请求成功");
            for (NSDictionary *dic in responseObject[@"data"]) {
                MallBrandListModel *model = [[MallBrandListModel alloc] initWithDictionary:dic];
                
                [self.topDataSourceArr addObject:model];
            }
//            [self buildTopViewWithArr:self.topDataSourceArr];
            [self buildTopView];
        }else{
            NSLog(@"数据请求失败");
            
        }
        
        
    } failure:^(NSError *error) {
        NSLog(@"网络请求失败");
        
    }];
    
}

//10.分类规格列表
-(void)requestMallFilterList{
    
    NSUserDefaults *defaut = [NSUserDefaults standardUserDefaults];
    NSString *token = [defaut objectForKey:@"token"];
    
    NSMutableDictionary *para = [NSMutableDictionary dictionary];
    [para setObject:self.cat_id forKey:@"id"];
    if (self.mallBrand_id != nil) {
        [para setObject:self.mallBrand_id forKey:@"bid"];
    }
    
    [para setObject:@1 forKey:@"ceshi"];
//    [para setObject:@"" forKey:@"filter"]
    
    [self.leftDataSourceArr removeAllObjects];
    [[HRRequestManager manager] POST_PATH:Post_MallFilterList WithToken:token para:para success:^(id responseObject) {
        if ([responseObject[@"status"] integerValue] == 1) {
            NSLog(@"数据请求成功");
            
            for (NSDictionary *dic in responseObject[@"data"]) {
                MallFirstFilterListModel *model = [[MallFirstFilterListModel alloc] initWithDictionary:dic];
                [self.leftDataSourceArr addObject:model];
            }
            [self.leftTableView reloadData];
        }else{
            NSLog(@"数据请求失败");
        }
    } failure:^(NSError *error) {
        
    }];
}

//11.分类商品信息
-(void)requestMallGoodsList:(BOOL)isMore{
    
    NSUserDefaults *defaut = [NSUserDefaults standardUserDefaults];
    NSString *token = [defaut objectForKey:@"token"];
    
    NSMutableDictionary *para = [NSMutableDictionary dictionary];
    
    //分类id 不可以为空
    [para setObject:self.cat_id forKey:@"id"];
    
    //品牌id 可以为空
    if (self.mallBrand_id != nil) {
        [para setObject:self.mallBrand_id forKey:@"bid"];
    }
    //规格  可以为空 0.0.0.0.162563
    if (self.mallFilter != nil) {
        [para setObject:self.mallFilter forKey:@"filter"];
    }
    
    [para setObject:@1 forKey:@"ceshi"];

    //当前页数  可以为空
    if (isMore) {
        if (self.currentPage*12<self.totalNum) {
            [para setObject:[NSString stringWithFormat:@"%ld",self.currentPage+1] forKey:@"page"];
        }else{
            [para setObject:[NSString stringWithFormat:@"%ld",self.currentPage] forKey:@"page"];
        }
    }else{
        [para setObject:@"1" forKey:@"page"];
    }
    
    if (self.isDefaultTopSelect == YES) {
        [para setObject:@"1" forKey:@"page"];
    }
    
    /*
    NSInteger cPage;
    
    if (self.dataSourceArr.count % 12 == 0){
        if (self.currentPage > 1) {
            cPage = self.currentPage-1;
        }else{
            cPage = 1;
        }
        
        [para setObject:isMore ? [NSString stringWithFormat:@"%ld",self.currentPage+1] : [NSString stringWithFormat:@"%ld",cPage] forKey:@"page"] ;
//        [para setObject:isMore ? [NSString stringWithFormat:@"%lu",(long)self.dataSourceArr.count/12+1 ] : @"1" forKey:@"page"] ;
    }else{
//        [para setObject:isMore ? [NSString stringWithFormat:@"%lu",self.dataSourceArr.count/12+2] :@"1" forKey:@"page"];
         [para setObject:isMore ? [NSString stringWithFormat:@"%lu",self.currentPage+1] :@"1" forKey:@"page"];
    }
    */
    
    [self.dataSourceArr removeAllObjects];
    weakSelf(weakSelf);
    [[HRRequestManager manager] POST_PATH:Post_MallGoodsList WithToken:token     para:para success:^(id responseObject) {
        if ([responseObject[@"status"] integerValue] == 1) {
            NSLog(@"数据请求成功");
            [weakSelf endRefresh];
            self.currentPage = [responseObject[@"data"][@"current_page"] integerValue];
            self.totalNum = [responseObject[@"data"][@"total"] integerValue];
//            [self requestWithMallGoodsListModel:responseObject[@"data"][@"data"] isMore:isMore];
            
            NSString *totalStr = [NSString stringWithFormat:@"共 %@ 条",responseObject[@"data"][@"total"]];
            self.totalCountLab.text = totalStr;
            
            if (self.totalNum <= 12) {
                self.onlyOnePageBackView.hidden = NO;
            }else {
                self.onlyOnePageBackView.hidden = YES;
            }
            
            
            for (NSDictionary *dic in responseObject[@"data"][@"data"]) {
                MallGoodsListModel *model = [[MallGoodsListModel alloc] initWithDictionary:dic];
                
                [self.dataSourceArr addObject:model];
            }
            
            
            
        }else{
            NSLog(@"数据请求失败");
            
        }
        [self.collectionView reloadData];
        [weakSelf endRefresh];
    } failure:^(NSError *error) {
        NSLog(@"网络请求失败");
        [weakSelf endRefresh];
        
    }];
    
    
}


- (void)requestWithMallGoodsListModel:(NSArray *)Arr isMore:(BOOL)isMore
{
    if (!isMore) {
        //        self.selectCell.img.hidden = YES;
        [self.dataSourceArr removeAllObjects];
    }
    
    for (NSDictionary *dic in Arr) {
        MallGoodsListModel *model = [[MallGoodsListModel alloc] initWithDictionary:dic];
        
        [self.dataSourceArr addObject:model];
    }
    
    [self.collectionView reloadData];
    
}

#pragma  mark - 懒加载
-(ShowQrcodeView *)showQrcodeView{
    if (!_showQrcodeView) {
        _showQrcodeView = [[ShowQrcodeView alloc] init];
    }
    
    return _showQrcodeView;
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
