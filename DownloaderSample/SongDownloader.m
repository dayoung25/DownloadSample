//
//  SongDownloader.m
//  DownloaderSample
//
//  Created by Dayoung on 2014. 6. 3..
//  Copyright (c) 2014년 Dayoung Jung. All rights reserved.
//

#import "SongDownloader.h"
#import "SongDownloadManager.h"

@interface SongDownloader ()

@property(nonatomic, strong) NSURLSessionDataTask *dataTask;
@property(nonatomic, strong) NSURL *downloadFileURL;

@end

@implementation SongDownloader

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.downloadFileURL =  [self createFileURL:[SongDownloadManager sharedClient].cacheDirURL songId:@"songId"];
    }
    return self;
}

- (void)start {
    
    NSURL *url = [NSURL URLWithString:@"https://developer.apple.com/library/ios/documentation/UserExperience/Conceptual/MobileHIG/MobileHIG.pdf"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    [SongDownloadManager sharedClient].taskDelegate = self;
    
    self.dataTask = [[SongDownloadManager sharedClient].session dataTaskWithRequest:request];
    [self.dataTask resume];
}

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask
    didReceiveData:(NSData *)data {

    NSError *error;
    NSFileHandle *fileHandle = [NSFileHandle fileHandleForWritingToURL:self.downloadFileURL error:&error];
    
    if (!error) {
        [fileHandle seekToEndOfFile];
        [fileHandle writeData:data];
        
        
        NSFileManager *fileManager = [[NSFileManager alloc] init];
        NSLog(@"directory: %d", [[fileManager contentsAtPath:[self.downloadFileURL path]] length]);
    } else {
        NSLog(@"error: %@", error);
    }

}

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task
didCompleteWithError:(NSError *)error {
    NSLog(@"sessionTask delegate didcomplete");
    

}

#pragma mark - "create file"

- (NSURL *)createFileURL:(NSURL *)cacheDirURL songId:(NSString *)songId {
    return [cacheDirURL URLByAppendingPathComponent:[NSString stringWithFormat:@"%@_%ld.mp3", songId, (long)[[NSDate date] timeIntervalSince1970]]];
}

@end
