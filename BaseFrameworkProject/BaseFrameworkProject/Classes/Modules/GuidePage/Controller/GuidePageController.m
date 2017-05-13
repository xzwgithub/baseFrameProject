//
//  GuidePageController.m
//  BaseFrameworkProject
//
//  Created by xzw on 17/5/12.
//  Copyright © 2017年 xzw. All rights reserved.
//

#import "GuidePageController.h"

@interface GuidePageController ()
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@end

@implementation GuidePageController

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
     self.scrollView.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width * 3, 0);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (IBAction)clickBtn:(id)sender {
    
    
    
}

@end
