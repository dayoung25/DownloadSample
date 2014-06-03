//
//  ViewController.m
//  DownloaderSample
//
//  Created by Dayoung on 2014. 6. 3..
//  Copyright (c) 2014년 Dayoung Jung. All rights reserved.
//

#import "ViewController.h"
#import "SongDownloadManager.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];


}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onDownloadStart:(id)sender {


    [[SongDownloadManager sharedClient] request];
    
}

@end
