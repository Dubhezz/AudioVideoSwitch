//
//  DTPlayer.h
//  AudioVideoSwitch
//
//  Created by dubhe on 2018/3/22.
//  Copyright © 2018年 Dubhe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@interface DTPlayer : NSObject

- (instancetype)initWithAssetURL:(NSURL *)assetURL;
- (void)replaceCurrentAssetWithURL:(NSURL *)assetURL;
@property (nonatomic, strong) AVPlayer *player;
@property (nonatomic, strong) AVPlayerLayer *playerLayer;

@end

@interface DTPlayer (Operate)

- (void)play;
- (void)pause;
- (void)stop;

@end
