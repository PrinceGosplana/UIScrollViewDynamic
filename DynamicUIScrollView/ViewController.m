//
//  ViewController.m
//  DynamicUIScrollView
//
//  Created by Administrator on 20.04.14.
//  Copyright (c) 2014 MyiPod. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"

#define SCREEN_HEIGHT   ((([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortrait) || ([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortraitUpsideDown)) ? [[UIScreen mainScreen] bounds].size.width : [[UIScreen mainScreen] bounds].size.height)
#define  SCREEN_WIDTH ((([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortrait) || ([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortraitUpsideDown)) ? [[UIScreen mainScreen] bounds].size.height : [[UIScreen mainScreen] bounds].size.width)

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor clearColor];
    [self checkOriented];

}


- (void) checkOriented {
    UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
    [self setContent:SCREEN_HEIGHT  height:SCREEN_WIDTH orientation:orientation];
}

-(void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    
    if (contentView != nil) {
        // если есть изображение - делаю его невидимым и удаляю
        [contentView removeFromSuperview];
        if (scrollView != nil) {
            [scrollView removeFromSuperview];
        }
    }
    [self setContent:SCREEN_WIDTH height:SCREEN_HEIGHT orientation:toInterfaceOrientation];
    
}

- (void) setContent:(float)width height: (float) height orientation: (UIInterfaceOrientation)toInterfaceOrientation{
    NSLog(@"width %f height %f", width, height);
    NSArray * array;
    if (toInterfaceOrientation == UIInterfaceOrientationPortrait) {
        // получаю данные из делегата
        array = [NSArray arrayWithArray:((AppDelegate *)[[UIApplication sharedApplication] delegate]).arrayP];
        self.title = @"Fantasy animal";
    }
    if (toInterfaceOrientation == UIInterfaceOrientationPortraitUpsideDown) {
        array = [NSArray arrayWithArray:((AppDelegate *)[[UIApplication sharedApplication] delegate]).arrayPD];
        self.title = @"Fantasy girl";
    }
    if (toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft) {
        array = [NSArray arrayWithArray:((AppDelegate *)[[UIApplication sharedApplication] delegate]).arrayLL];
        self.title = @"Nature";
    }
    if (toInterfaceOrientation == UIInterfaceOrientationLandscapeRight) {
        array = [NSArray arrayWithArray:((AppDelegate *)[[UIApplication sharedApplication] delegate]).arrayLR];
        self.title = @"Map";
    }
    
    contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, width * [array count], height-64)];
    
    for (int i = 0; i < [array count]; ++i) {
        UIImageView * img = [[UIImageView alloc] initWithFrame:CGRectMake(width * i, 0, width, height)];
        img.image = [UIImage imageNamed:[array objectAtIndex:i]];
        [contentView addSubview:img];
    }
    
    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
    scrollView.showsHorizontalScrollIndicator = YES;
    scrollView.pagingEnabled = YES;
    scrollView.scrollEnabled = YES;
    scrollView.userInteractionEnabled = YES;
    scrollView.delegate = self;
    [scrollView setContentSize:contentView.frame.size];
    
    [scrollView addSubview:contentView];
    [self.view addSubview:scrollView];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
