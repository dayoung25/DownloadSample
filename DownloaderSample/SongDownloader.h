//
//  SongDownloader.h
//  DownloaderSample
//
//  Created by Dayoung on 2014. 6. 3..
//  Copyright (c) 2014년 Dayoung Jung. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SongDownloadManager.h"
@interface SongDownloader : NSObject <SongDownloadManagerTaskDelegate>
- (void)start;
@end
