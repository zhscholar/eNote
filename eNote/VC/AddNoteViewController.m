//
//  AddNoteViewController.m
//  eNote
//
//  Created by Heng on 2019/4/18.
//  Copyright © 2019 Heng. All rights reserved.
//  创建/添加笔记页面

#import "AddNoteViewController.h"

#define BottomToolViewHeight 60.f
@interface AddNoteViewController ()<UITextViewDelegate>
@property (strong, nonatomic) UITextView *inputTextView;
@property (assign, nonatomic) BOOL isEditing;
@end

@implementation AddNoteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 设定文本视图
    self.inputTextView = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)) textContainer:nil];
    self.inputTextView.font = [UIFont systemFontOfSize:16];
    self.inputTextView.textAlignment = NSTextAlignmentNatural;
    self.inputTextView.delegate = self;
    [self.view addSubview:self.inputTextView];
    // 设定底部的编辑工具
    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    // 进入编辑状态
    [self.inputTextView becomeFirstResponder];
}

#pragma mark - 顶部导航栏的操作
- (void)setRightNavBarItem {
    // 编辑模式
    if (self.isEditing) {
        self.navigationItem.rightBarButtonItem = nil;
        // 1.分享按钮
        UIBarButtonItem *shareItem = [[UIBarButtonItem alloc] initWithTitle:@"分享" style:UIBarButtonItemStylePlain target:self action:@selector(shareNote)];
        // 2.“完成”按钮
        UIButton *doneButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, 40)];
        [doneButton setTitle:NSLocalizedString(@"完成", nil) forState:UIControlStateNormal];
        [doneButton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        doneButton.titleLabel.font = [UIFont systemFontOfSize:17 weight:UIFontWeightBold];
        [doneButton addTarget:self action:@selector(doneAndExitEdit) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *doneItem = [[UIBarButtonItem alloc] initWithCustomView:doneButton];
        
        self.navigationItem.rightBarButtonItems = @[doneItem,shareItem];
    }
    // 正常模式
    else {
        self.navigationItem.rightBarButtonItems = nil;
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"分享" style:UIBarButtonItemStylePlain target:self action:@selector(shareNote)];
//        [[UIBarButtonItem alloc] initWithImage:nil style:UIBarButtonItemStylePlain target:self action:@selector(shareNote)];
    }
    
}

#pragma mark - textView delegate
- (void)textViewDidBeginEditing:(UITextView *)textView {
    self.isEditing = YES;
    [self setRightNavBarItem];
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    NSLog(@"textViewDidEndEditing");
    [self doneAndExitEdit];
}

#pragma mark - 导航栏按钮手势实现
// 分享笔记
- (void)shareNote {
    // 先退出编辑模式
    [self doneAndExitEdit];
    // 弹出分享界面
}

// 完成并退出编辑模式
- (void)doneAndExitEdit {
    [self.view endEditing:YES];
    self.isEditing = NO;
    // 调整导航栏按钮样式
    [self setRightNavBarItem];
}
@end
