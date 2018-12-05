//
//  OrderViewController.m
//  JYPriceList
//
//  Created by jiangkuiquan on 2018/11/21.
//  Copyright © 2018年 jiangkuiquan. All rights reserved.
//

#import "OrderViewController.h"

#import "OrderCollectionViewCell.h"
#import "OrderTableViewCell.h"

static NSString *const OrderTableViewCellID = @"OrderTableViewCellIdentifier";
static NSString *const OrderCollectionViewCellID = @"OrderCollectionViewCellIdentifeir";
@interface OrderViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation OrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setUpUI];
    
}

-(void)setUpUI{
    
    self.title = @"提交订单";
    
    //注册cell
    [self.collectionView registerNib:[UINib nibWithNibName:@"OrderCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:OrderCollectionViewCellID];
    [self.tableView registerNib:[UINib nibWithNibName:@"OrderTableViewCell" bundle:nil] forCellReuseIdentifier:OrderTableViewCellID];
    
    //去除分割线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.alwaysBounceVertical = NO;
    
    //
    self.collectionView.showsVerticalScrollIndicator = NO;
    
}

#pragma mark - 点击事件
- (IBAction)buttonClickAction:(UIButton *)sender {
    NSLog(@"点击事件");
    
    
}

#pragma mark - UITableViewDelegate && UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    OrderTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:OrderTableViewCellID forIndexPath:indexPath];
//    if (!cell) {
//        cell = [[NSBundle mainBundle] loadNibNamed:@"OrderTableViewCell" owner:self options:nil].lastObject;
//    }
    
    return cell;
}

#pragma mark - UICollectionViewDelegate && UICollectionViewDataSource
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return 59;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath{
    
    OrderCollectionViewCell *cell  = [self.collectionView dequeueReusableCellWithReuseIdentifier:OrderCollectionViewCellID forIndexPath:indexPath];
    
    return cell;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat itemWidth = (ScreenWidth - 528 - 25)/3;
    return CGSizeMake(itemWidth, 80);
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    return UIEdgeInsetsMake(0, 0, 5, 5);
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
