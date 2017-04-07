//
//  LeftMenuViewController.m
//  DrawerDemo
//
//  Created by Eugene on 2017/4/6.
//  Copyright © 2017年 Eugene. All rights reserved.
//

#import "LeftMenuViewController.h"
#import "DrawerViewController.h"
#import "AppDelegate.h"
#import "OtherViewController.h"
@interface LeftMenuViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *dataArray;

@end

static CGFloat HeaderViewH = 200;

@implementation LeftMenuViewController

-(NSMutableArray *)dataArray
{
    if (!_dataArray) {
        NSMutableArray *dataArray = [NSMutableArray arrayWithObjects:@"了解会员特权",@"QQ钱包",@"个性装扮",@"我的收藏",@"我的相册",@"我的文件", nil];
        self.dataArray = dataArray;
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configView];
}

-(void)configView
{
    self.view.backgroundColor = [UIColor whiteColor];
    [self addHeaderView];
    [self addTableView];
}

-(void)addHeaderView
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, HeaderViewH)];
    UIImageView *bgImageView = [[UIImageView alloc] initWithFrame:headerView.frame];
    bgImageView.image = [UIImage imageNamed:@"sidebar_bg"];
    bgImageView.contentMode = UIViewContentModeScaleAspectFill;
    bgImageView.clipsToBounds = YES;
    [headerView addSubview:bgImageView];
    [self.view addSubview:headerView];
}

-(void)addTableView
{
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, HeaderViewH, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - HeaderViewH)];
    tableView.backgroundColor = [UIColor colorWithRed:13.0 / 255.0 green:184.0 / 255.0 blue:246.0 / 255.0 alpha:1.0];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.contentInset = UIEdgeInsetsMake(20, 0, 0, 0);
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"leftCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellId];
    }
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.text = self.dataArray[indexPath.row];
    cell.textLabel.textColor = [UIColor whiteColor];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate ];
    OtherViewController *other = [[OtherViewController alloc] init];
    other.titleString = [tableView cellForRowAtIndexPath:indexPath].textLabel.text;
    other.hidesBottomBarWhenPushed = YES;
    [delegate.drawer closeLeftView];
    [delegate.main.selectedViewController pushViewController:other animated:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
