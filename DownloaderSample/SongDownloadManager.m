//
//  SongDownloadManager.m
//  DownloaderSample
//
//  Created by Dayoung on 2014. 6. 3..
//  Copyright (c) 2014년 Dayoung Jung. All rights reserved.
//

#import "SongDownloadManager.h"
#import "SongDownloader.h"
#import "OrderedDictionary.h"

@interface SongDownloadManager ()

@property(nonatomic, weak) NSOperationQueue *opertaionQueue;

@property(nonatomic, strong)OrderedDictionary *requestQueue;
@property(nonatomic, strong)OrderedDictionary *downloadQueue;

@end

@implementation SongDownloadManager

+ (instancetype)sharedClient {
    static SongDownloadManager *_sharedClient = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[SongDownloadManager alloc] init];
    });
    
    return _sharedClient;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        configuration.URLCache = nil;
        configuration.requestCachePolicy = NSURLRequestReloadIgnoringCacheData;
        
        self.session = [NSURLSession sessionWithConfiguration:configuration delegate:self delegateQueue:self.opertaionQueue ];
        
        self.downloadQueue = [[OrderedDictionary alloc] init];
        self.requestQueue = [[OrderedDictionary alloc] init];
        self.cacheDirURL = [self getCacheDirURL];
    }
    return self;
}

- (void)request {
    SongDownloader *songDownloader = [[SongDownloader alloc] init];
    [songDownloader start];
    
}

#pragma mark - "sessionTask delegate"

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task
didCompleteWithError:(NSError *)error {
    
    [self.taskDelegate URLSession:session task:task didCompleteWithError:error];
}

#pragma mark - "sessionData delegate"

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask
    didReceiveData:(NSData *)data {
    
    [self.taskDelegate URLSession:session dataTask:dataTask didReceiveData:data];
    
}

#pragma mark - "create file"

- (NSURL *)getCacheDirURL {
    NSString *documentsDirectoryPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSString *cacheDir = [documentsDirectoryPath stringByAppendingString:@"/cache/"];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if (![fileManager fileExistsAtPath:cacheDir isDirectory:nil]) {
        NSError *error;
        
        if (![fileManager createDirectoryAtPath:cacheDir withIntermediateDirectories:YES attributes:nil error:&error]) {
            NSLog(@"Fail to Create CacheDir : %@", error);
        }
    }
    
    return [NSURL fileURLWithPath:cacheDir];
}

@end
