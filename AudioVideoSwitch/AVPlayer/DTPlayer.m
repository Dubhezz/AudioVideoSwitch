//
//  DTPlayer.m
//  AudioVideoSwitch
//
//  Created by dubhe on 2018/3/22.
//  Copyright © 2018年 Dubhe. All rights reserved.
//

#import "DTPlayer.h"

@interface DTPlayer ()

//@property (nonatomic, strong) AVPlayer *player;
@property (nonatomic, strong) AVPlayerItem *playerItem;
@property (nonatomic, strong) AVAsset *asset;

@end

@implementation DTPlayer

- (instancetype)initWithAssetURL:(NSURL *)assetURL {
    if (self = [super init]) {
        _asset = [AVAsset assetWithURL:assetURL];
        [self prepareToPlay];
    }
    return self;
}

- (void)prepareToPlay {
    AVPlayerItem *playerItem = [AVPlayerItem playerItemWithAsset:self.asset];
    self.playerItem = playerItem;
    AVPlayer *player = [AVPlayer playerWithPlayerItem:playerItem];
    self.player = player;
    AVPlayerLayer *playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.player];
    playerLayer.videoGravity = AVLayerVideoGravityResize;
    self.playerLayer = playerLayer;
}

- (void)replaceCurrentAssetWithURL:(NSURL *)assetURL {
    self.asset = [AVAsset assetWithURL:assetURL];
    AVPlayerItem *playerItem = [AVPlayerItem playerItemWithAsset:self.asset];
    self.playerItem = playerItem;
    [self.player replaceCurrentItemWithPlayerItem:playerItem];
}




@end


@implementation DTPlayer (Operate)

- (void)play {
    [self.player play];
}

- (void)pause {
    [self.player pause];
}

- (void)stop {
    
}

@end
