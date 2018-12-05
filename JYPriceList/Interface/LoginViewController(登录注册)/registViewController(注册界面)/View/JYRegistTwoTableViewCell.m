
//
//  JYRegistTwoTableViewCell.m
//  JYPriceList
//
//  Created by jiangkuiquan on 2018/9/20.
//  Copyright © 2018年 jiangkuiquan. All rights reserved.
//

#import "JYRegistTwoTableViewCell.h"

#import "JYLoginRegionListModel.h"
#import "ProvinceTableViewCell.h"

static NSString *const ProvinceTableViewCellID = @"ProvinceTableViewCellIdentifier";
@interface JYRegistTwoTableViewCell()<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITextField *provinceTextField;
@property (weak, nonatomic) IBOutlet UITextField *cityTextField;
@property (weak, nonatomic) IBOutlet UITextField *areaTextField;

@property (weak, nonatomic) IBOutlet UITextField *shopNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *companyAddressTextField;
@property (weak, nonatomic) IBOutlet UITextField *lineCodeTextField;
@property (weak, nonatomic) IBOutlet UITextField *personCodeTextField;
@property (weak, nonatomic) IBOutlet UIView *provinceBackView;
@property (weak, nonatomic) IBOutlet UITableView *provinceTableView;
@property (weak, nonatomic) IBOutlet UIView *cityBackView;
@property (weak, nonatomic) IBOutlet UITableView *cityTableView;
@property (weak, nonatomic) IBOutlet UIView *areaBackView;
@property (weak, nonatomic) IBOutlet UITableView *areaTableView;

@property (nonatomic, strong) NSMutableDictionary *mDic;

@property (nonatomic, strong) NSString *regionID;
@property (nonatomic, strong) NSString *region;
@property (nonatomic, strong) NSString *provinceID;
@property (nonatomic, strong) NSString *cityID;
@property (nonatomic, strong) NSString *areaID;

@property (nonatomic, strong) NSMutableArray *provinceDataSourceArr;
@property (nonatomic, strong) NSMutableArray *cityDataSoureceArr;
@property (nonatomic, strong) NSMutableArray *areaDataSoureceArr;

@end


@implementation JYRegistTwoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.provinceDataSourceArr = [NSMutableArray array];
    self.cityDataSoureceArr = [NSMutableArray array];
    self.areaDataSoureceArr = [NSMutableArray array];
    self.mDic = [NSMutableDictionary dictionary];
    
    //注册cell
    
    
}

#pragma mark - 点击事件
- (IBAction)buttonClickAction:(UIButton *)sender {
    

    switch (sender.tag) {
        case 1:{
            NSLog(@"省份按钮");
            self.provinceBackView.hidden = !self.provinceBackView.hidden;
            if (self.provinceDataSourceArr.count <= 0) {
                
                self.regionID = @"1";
                self.region = @"省";
                [self requestLoginRegionlist];
            }
////            sender.selected = !sender.selected;
//            self.provinceBackView.hidden = !self.provinceBackView.hidden;
//
//            if (sender.selected == YES) {
//                self.provinceBackView.hidden = NO;
//                self.regionID = @"1";
//                self.region = @"省";
//                [self requestLoginRegionlist];
//            }else{
//                self.provinceBackView.hidden = YES;
//            }
            
            
        }
            break;
        case 2:{
            NSLog(@"市按钮");
            self.cityBackView.hidden = !self.cityBackView.hidden;
//            sender.selected = !sender.selected;
//            if (sender.selected == YES) {
//                self.cityBackView.hidden = NO;
//            }else{
//                self.cityBackView.hidden = YES;
//            }
        }
            break;
        case 3:{
            NSLog(@"县按钮");
            self.areaBackView.hidden = !self.areaBackView.hidden;
//            sender.selected = !sender.selected;
//            if (sender.selected == YES) {
//                self.areaBackView.hidden = NO;
//            }else{
//                self.areaBackView.hidden = YES;
//            }
        }
            break;
        case 4:{
            NSLog(@"上传营业照");
            self.registTwoTableViewCellBlock(sender.tag,nil);
        }
            break;
        case 6:{
            NSLog(@"同意注册");
            
            if (self.provinceTextField.text.length>0) {
                [self.mDic setObject:self.provinceID forKey:@"province"];
            }
            if (self.cityTextField.text.length>0) {
                [self.mDic setObject:self.cityID forKey:@"city"];
            }
            if (self.areaTextField.text.length>0) {
                [self.mDic setObject:self.areaID forKey:@"district"];
            }
            
            self.registTwoTableViewCellBlock(sender.tag,self.mDic);
        }
            break;
            
        default:
            break;
    }
    
    
}


#pragma mark - UITextFieldDelegate

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    if (textField == self.shopNameTextField) {
        
    }else if (textField == self.companyAddressTextField){
        
    }else if (textField == self.lineCodeTextField){
        
    }else if (textField == self.personCodeTextField){
        
    }
    
    return YES;
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    
    if (textField == self.shopNameTextField) {
        [self.mDic setObject:textField.text forKey:@"company"];
    }else if (textField == self.companyAddressTextField){
        [self.mDic setObject:textField.text forKey:@"address"];
    }else if (textField == self.lineCodeTextField){
        [self.mDic setObject:textField.text forKey:@"zhizhao"];
    }else if (textField == self.personCodeTextField){
        [self.mDic setObject:textField.text forKey:@"parent_id"];
    }
    
}

#pragma mark - UITableViewDelegate && UITableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == self.provinceTableView) {
        return self.provinceDataSourceArr.count;
    }else if (tableView == self.cityTableView){
        return self.cityDataSoureceArr.count;
    }else if (tableView == self.areaTableView){
        return self.areaDataSoureceArr.count;
    }
    return 0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 45;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ProvinceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ProvinceTableViewCellID];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"ProvinceTableViewCell" owner:self options:nil].lastObject;
    }
    
    if (tableView == self.provinceTableView) {
        [cell buildWithModel:self.provinceDataSourceArr[indexPath.row]];
    }else if (tableView == self.cityTableView){
        [cell buildWithModel:self.cityDataSoureceArr[indexPath.row]];
    }else if (tableView == self.areaTableView){
       [cell buildWithModel:self.areaDataSoureceArr[indexPath.row]];
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.provinceTableView) {
        self.provinceBackView.hidden = YES;
        self.cityBackView.hidden = NO;
        self.areaBackView.hidden = YES;
        JYLoginRegionListModel *model = self.provinceDataSourceArr[indexPath.row];
        self.region = @"市";
        self.cityTextField.text = @"";
        self.areaTextField.text = @"";
        [self.cityDataSoureceArr removeAllObjects];
        [self.areaDataSoureceArr removeAllObjects];
        self.provinceTextField.text = model.region_name;
        self.regionID = model.region_id;
        self.provinceID = self.regionID;
        [self requestLoginRegionlist];
    }else if (tableView == self.cityTableView){
        self.provinceBackView.hidden = YES;
        self.cityBackView.hidden = YES;
        self.areaBackView.hidden = NO;
        JYLoginRegionListModel *model = self.cityDataSoureceArr[indexPath.row];
        self.region = @"区";
        self.areaTextField.text = @"";
        [self.areaDataSoureceArr removeAllObjects];
        self.cityTextField.text = model.region_name;
        self.regionID = model.region_id;
        self.cityID = self.regionID;
        [self requestLoginRegionlist];
    }else if (tableView == self.areaTableView){
        self.provinceBackView.hidden = YES;
        self.cityBackView.hidden = YES;
        self.areaBackView.hidden = YES;
        JYLoginRegionListModel *model = self.areaDataSoureceArr[indexPath.row];
        self.region = @"区";
        self.areaTextField.text = model.region_name;
        self.regionID = model.region_id;
        self.areaID = self.regionID;
        
    }
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
    
}


#pragma mark - 数据请求
-(void)requestLoginRegionlist{
    
    NSMutableDictionary *para = [NSMutableDictionary dictionary];
    
    [para setObject:self.regionID forKey:@"id"];

    [[HRRequestManager manager]  POST_PATH:Post_LoginRegionlist para:para success:^(id responseObject) {
        if ([responseObject[@"status"] integerValue] == 1) {
            NSLog(@"数据请求成");
            if ([self.region isEqualToString:@"省"]) {
                for (NSDictionary *dic in responseObject[@"data"]) {
                    JYLoginRegionListModel *model = [[JYLoginRegionListModel alloc] initWithDictionary:dic];
                    [self.provinceDataSourceArr addObject:model];
                }
                
                [self.provinceTableView reloadData];
//                [self.cityTableView reloadData];
//                [self.areaTableView reloadData];
            }
            if ([self.region isEqualToString:@"市"]) {
                for (NSDictionary *dic in responseObject[@"data"]) {
                    JYLoginRegionListModel *model = [[JYLoginRegionListModel alloc] initWithDictionary:dic];
                    [self.cityDataSoureceArr addObject:model];
                }
                
                [self.cityTableView reloadData];
//                [self.areaTableView reloadData];
            }
            if ([self.region isEqualToString:@"区"]) {
                for (NSDictionary *dic in responseObject[@"data"]) {
                    JYLoginRegionListModel *model = [[JYLoginRegionListModel alloc] initWithDictionary:dic];
                    [self.areaDataSoureceArr addObject:model];
                }
                [self.areaTableView reloadData];
            }
            
            
        }else{
            [MBProgressHUD showInfoMessage:responseObject[@"data"][@"error_info"]];
        }
        
        
    } failure:^(NSError *error) {
        
        
    }];
    
}



@end
