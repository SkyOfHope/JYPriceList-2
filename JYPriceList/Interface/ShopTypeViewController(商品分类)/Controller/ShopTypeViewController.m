//
//  ShopTypeViewController.m
//  JYPriceList
//
//  Created by jiangkuiquan on 2018/10/24.
//  Copyright © 2018年 jiangkuiquan. All rights reserved.
//

#import "ShopTypeViewController.h"

#import "MallViewController.h"
#import "GlassHomeViewController.h"
#import "ConcealShowView.h"
#import "ShopCatListModel.h"
#import "OrderViewController.h"

#import "ShopTypeCollectionViewCell.h"

static NSString *const ShopTypeCollectionViewCellID = @"ShopTypeCollectionViewCellIdentifierw";

@interface ShopTypeViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (nonatomic , strong) NSMutableArray *dataSourceArr;
@property (nonatomic, strong) ConcealShowView *concealShowView;

@end

@implementation ShopTypeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.dataSourceArr = [NSMutableArray array];
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"firstLaunch"]) {
        NSLog(@"first time to launch");
        
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"firstLaunch"];
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"everLaunch"];
        
        
        self.concealShowView.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
        self.concealShowView.backgroundColor = [UIColor colorWithRed:0/255 green:0/255 blue:0/255 alpha:.5];
        [[[UIApplication sharedApplication] delegate].window addSubview:self.concealShowView];
        
    }else{
        NSLog(@"ever launched ");
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"everLaunch"];
        
    }
    
    
    [self requestShopCatlist];
    [self setUpUI];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    //避免的出现返回时导航栏的黑块
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [MobClick beginLogPageView:@"商品分类页面"];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    //避免的出现返回时导航栏的黑块
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [MobClick endLogPageView:@"商品分类页面"];
}

-(void)setUpUI{
    
    self.collectionView.showsVerticalScrollIndicator = NO;
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"ShopTypeCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:ShopTypeCollectionViewCellID];
    
}

#pragma mark - 点击事件
- (IBAction)buttonClickAction:(UIButton *)sender {
    
    OrderViewController *orderVC = [[OrderViewController alloc] initWithNibName:@"OrderViewController" bundle:nil];
    UIBarButtonItem *bar = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:0 target:nil action:nil];
    [self.navigationItem setBackBarButtonItem:bar];
    [self.navigationController pushViewController:orderVC animated:YES];
}


#pragma mark - UICollectionViewDelegate && UICollectionViewDataSource
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.dataSourceArr.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath{
    
    ShopTypeCollectionViewCell *item = [self.collectionView dequeueReusableCellWithReuseIdentifier:ShopTypeCollectionViewCellID forIndexPath:indexPath];
    
    [item buildWithModel:self.dataSourceArr[indexPath.row]];
    
    return item;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake(200, 200);
}

//定义每个UICollectionViewItem 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    ShopCatListModel *model = self.dataSourceArr[indexPath.row];
    
    if ([model.cat_id integerValue] == 6) {
        GlassHomeViewController *glassHomeVC = [[GlassHomeViewController alloc] initWithNibName:@"GlassHomeViewController" bundle:nil];
        UIBarButtonItem *bar = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:0 target:nil action:nil];
        [self.navigationItem setBackBarButtonItem:bar];
        [self.navigationController pushViewController:glassHomeVC animated:YES];
    }else {
        MallViewController *mallVC = [[MallViewController alloc]  initWithNibName:@"MallViewController" bundle:nil];
        mallVC.cat_id = model.cat_id;
        UIBarButtonItem *bar = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:0 target:nil action:nil];
        [self.navigationItem setBackBarButtonItem:bar];
        [self.navigationController pushViewController:mallVC animated:YES];
    }
    
}


#pragma mark - 数据请求
-(void)requestShopCatlist{
    
    NSUserDefaults *defaut = [NSUserDefaults standardUserDefaults];
    NSString *token = [defaut objectForKey:@"token"];
    
    [self.dataSourceArr removeAllObjects];
    [[HRRequestManager manager] POST_PATH:Post_ShopCatlist WithToken:token para:nil success:^(id responseObject) {
        if ([responseObject[@"status"] integerValue] == 1) {
            NSLog(@"数据请求成功");
            
            for (NSDictionary *dic in responseObject[@"data"]) {
                
                ShopCatListModel *model = [[ShopCatListModel alloc] initWithDictionary:dic];
                
                [self.dataSourceArr addObject:model];
            }
            
            [self.collectionView reloadData];
        }else{
            NSLog(@"数据请求失败");
            
        }
        
        
    } failure:^(NSError *error) {
        NSLog(@"网络请求失败");
        
        
        
    }];
    
    
    
}

#pragma mark - 懒加载
-(ConcealShowView *)concealShowView{
    if (!_concealShowView) {
        _concealShowView = [[ConcealShowView alloc] init];
    }
    
    return _concealShowView;
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
