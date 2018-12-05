//
//  ChoosePromptView.m
//  JYPriceList
//
//  Created by jiangkuiquan on 2018/9/28.
//  Copyright © 2018年 jiangkuiquan. All rights reserved.
//

#import "ChoosePromptView.h"
#import "PromptTableViewCell.h"

#import "LoginCompanyModel.h"

static NSString *const PromptTableViewCellID = @"PromptTableViewCellIdentifier";
@interface ChoosePromptView()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;


@end

@implementation ChoosePromptView
//初始化
-(instancetype)init{
    
    if (self) {
        self = [[NSBundle mainBundle] loadNibNamed:@"ChoosePromptView" owner:self options:nil].lastObject;
        [self setUpUI];
    }
    
    return self;
}

#pragma mark - 私有方法
-(void)setUpUI{
    //注册cell
    [self.tableView registerNib:[UINib nibWithNibName:@"PromptTableViewCell" bundle:nil] forCellReuseIdentifier:PromptTableViewCellID];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
}

//隐藏界面
-(void)hideControl{
    
    [UIView animateWithDuration:2.0 animations:^{
        
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
    
}

#pragma mark - 点击事件
- (IBAction)buttonClickAction:(UIButton *)sender {
    
    [self hideControl];
}

#pragma mark - UITableViewDelegate && UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataSourceArr.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 50;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    PromptTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:PromptTableViewCellID forIndexPath:indexPath];
    [cell buildWithModel:self.dataSourceArr[indexPath.row]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    LoginCompanyModel *model = self.dataSourceArr[indexPath.row];
    self.choosePromptViewBlock(model.cid);
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
