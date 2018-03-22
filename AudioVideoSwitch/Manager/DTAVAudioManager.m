//
//  WOAVAudioManager.m
//  AudioVideoSwitch
//
//  Created by dubhe on 2018/3/22.
//  Copyright © 2018年 Dubhe. All rights reserved.
//

#import "DTAVAudioManager.h"

@implementation DTAVAudioManager

+ (instancetype)shareManager {
    static dispatch_once_t onceToken;
    static DTAVAudioManager *manager = nil;
    dispatch_once(&onceToken, ^{
        manager = [[[self class] alloc] init];
    });
    return manager;
}

- (void)setAudioAssetURL:(NSURL *)audioAssetURL {
    _audioAssetURL = audioAssetURL;
    self.audioPlayerState = DTAudioPlayerStateTypeLoading;
    if (self.audioPlayer) {
        [self.audioPlayer replaceCurrentAssetWithURL:audioAssetURL];
    } else {
        self.audioPlayer = [[DTPlayer alloc] initWithAssetURL:audioAssetURL];
    }
}

- (void)setVideoAssetURL:(NSURL *)videoAssetURL {
    _videoAssetURL = videoAssetURL;
    self.videoPlayerState = DTVideoPlayerStateTypeLoading;
    if (self.videoPlayer) {
        [self.videoPlayer replaceCurrentAssetWithURL:videoAssetURL];
    } else {
        self.videoPlayer = [[DTPlayer alloc] initWithAssetURL:videoAssetURL];
    }
}

- (void)audioPlay {
    switch (self.videoPlayerState) {
        case DTVideoPlayerStateTypeNone:
        case DTVideoPlayerStateTypeCompletion:
            [self.audioPlayer play];
            break;
        case DTVideoPlayerStateTypeLoading:
            //取消播放视频播放,然后开始播放音乐
            break;
        case DTVideoPlayerStateTypePlaying:
            if (self.videoPlayBackType == DTVideoPlayBackTypeMute) {
                [self.audioPlayer play];
            } else if (self.videoPlayBackType == DTVideoPlayBackTypeSuspension) {
                //视频悬窗消失,然后开始播放音乐
            } else {
                
            }
            break;
        case DTVideoPlayerStateTypePause:
            if (self.videoPlayBackType == DTVideoPlayBackTypeMute) {
                //不存在
            } else if (self.videoPlayBackType == DTVideoPlayBackTypeSuspension) {
                //视频悬窗消失,然后开始播放音乐
            } else {
                //不存在
            }
            break;
    }
    self.audioPlayerState = DTAudioPlayerStateTypePlaying;
    
}

- (void)videoPlay {
    switch (self.audioPlayerState) {
        case DTAudioPlayerStateTypeNone:
        case DTAudioPlayerStateTypeCompletion:
            [self.videoPlayer play];
            if (self.videoPlayBackType == DTVideoPlayBackTypeMute) {
                [self.videoPlayer.player setMuted:YES];
            } else {
                [self.videoPlayer.player setMuted:NO];
            }
            break;
        case DTAudioPlayerStateTypeLoading:
            if (self.videoPlayBackType == DTVideoPlayBackTypeMute) {
                [self.videoPlayer play];
                [self.videoPlayer.player setMuted:YES];
            } else if (self.videoPlayBackType == DTVideoPlayBackTypeSuspension) {
                //取消音乐播放,开始播
                [self.videoPlayer play];
                [self.videoPlayer.player setMuted:NO];
            }
            break;
        case DTAudioPlayerStateTypePlaying:
            [self.audioPlayer pause];
            if (self.videoPlayBackType == DTVideoPlayBackTypeMute) {
                [self.videoPlayer play];
                [self.videoPlayer.player setMuted:YES];
            } else if (self.videoPlayBackType == DTVideoPlayBackTypeSuspension) {
                //取消音乐播放,开始播
                [self.videoPlayer play];
                [self.videoPlayer.player setMuted:NO];
            }
            break;
        case DTAudioPlayerStateTypePause:
            if (self.videoPlayBackType == DTVideoPlayBackTypeMute) {
                [self.videoPlayer play];
                [self.videoPlayer.player setMuted:YES];
            } else if (self.videoPlayBackType == DTVideoPlayBackTypeSuspension) {
                //取消音乐播放,开始播
                [self.videoPlayer play];
                [self.videoPlayer.player setMuted:NO];
            }
            break;
    }
    self.videoPlayerState = DTVideoPlayerStateTypePlaying;
}

- (void)audioPause {
    [self.audioPlayer pause];
    self.audioPlayerState = DTAudioPlayerStateTypePause;
}

- (void)videoPause {
    [self.videoPlayer pause];
    self.videoPlayerState = DTVideoPlayerStateTypePause;
}

- (void)audioPlayCompletion {
    self.audioPlayerState = DTAudioPlayerStateTypeCompletion;
}

- (void)videoPlayCompletion {
    self.videoPlayerState = DTVideoPlayerStateTypeCompletion;
}

@end
