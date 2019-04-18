//
//  MainViewController.m
//  eNote
//
//  Created by Heng on 2019/4/18.
//  Copyright © 2019 Heng. All rights reserved.
//

#import "MainViewController.h"
#import "AddNoteViewController.h"

@interface MainViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *noteListTableView;
@property (assign, nonatomic) BOOL isEditState;
@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 调整导航栏内容
    self.navigationController.navigationBar.translucent = NO;
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    // 定义导航栏右侧按钮
    UIButton *rightItem = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, 40)];
    [rightItem setTitle:NSLocalizedString(@"编辑", nil) forState:UIControlStateNormal];
    [rightItem setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    rightItem.titleLabel.font = [UIFont systemFontOfSize:17 weight:UIFontWeightBold];
    [rightItem addTarget:self action:@selector(showEditOrCancelState) forControlEvents:UIControlEventTouchUpInside];


    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightItem];
    
    // 设定背景色
    
    // 设定表视图
    self.noteListTableView.backgroundColor = [UIColor clearColor];
    self.noteListTableView.delegate = self;
    self.noteListTableView.dataSource = self;
    self.noteListTableView.tableFooterView = [UIView new];
//    self.navigationItem.rightBarButtonItem = [UIBarButtonItem alloc] ini;
    
    // Do any additional setup after loading the view.
}


#pragma mark - 顶部右侧编辑按钮的手势
- (void)showEditOrCancelState {
    if (self.isEditState) {
        // 当前是编辑模式，则执行“取消”操作，恢复正常
        self.isEditState = NO;
    }
    else {
        // 当前是正常模式，进入“编辑”状态
        self.isEditState = YES;
    }
    NSLog(@"笔记本编辑");
}

#pragma mark - tableview delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

static NSString *noteItemCellID = @"noteItemCell";
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:noteItemCellID forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

#pragma mark - tableview dataSource
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60.f;
}



#pragma mark - 底部的左右两个标签的手势实现
// 添加一个新的日记
- (IBAction)addNoteTap:(UITapGestureRecognizer *)sender {
    NSLog(@"添加一个新日记");
    AddNoteViewController *addNote = [[AddNoteViewController alloc] init];
    [self.navigationController pushViewController:addNote animated:YES];
}

// 显示目前所有的附件文件
- (IBAction)showAllAttachmentFile:(UITapGestureRecognizer *)sender {
    NSLog(@"显示附件文件");
}

@end
