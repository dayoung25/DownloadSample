//
//  SongDownloadManager.h
//  DownloaderSample
//
//  Created by Dayoung on 2014. 6. 3..
//  Copyright (c) 2014년 Dayoung Jung. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol SongDownloadManagerTaskDelegate;

@interface SongDownloadManager : NSObject <NSURLSessionTaskDelegate, NSURLSessionDataDelegate>

@property(nonatomic, strong) id<SongDownloadManagerTaskDelegate> taskDelegate;

@property(nonatomic, strong) NSURLSession *session;
@property(nonatomic, strong) NSURL *cacheDirURL;

+ (instancetype)sharedClient;

- (void)request;

@end

@protocol SongDownloadManagerTaskDelegate <NSObject>

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask
    didReceiveData:(NSData *)data;
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task
didCompleteWithError:(NSError *)error;

@end