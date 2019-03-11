//
//  TestAVFoundationController.m
//  DYLTool
//
//  Created by sky on 2019/3/5.
//  Copyright © 2019年 DYL. All rights reserved.
//

#import "TestAVFoundationController.h"
#import <AVFoundation/AVFoundation.h>

@interface TestAVFoundationController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) AVPlayer *player;

@property (nonatomic, strong) AVAssetImageGenerator *imageGenerator;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *images;

@end

static const NSString *PlayerItemStatusContext;

@implementation TestAVFoundationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.player pause];
    [self.player.currentItem removeObserver:self forKeyPath:@"status"];
    self.player = nil;
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)yl_initViews {
    [super yl_initViews];
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"login_video" withExtension:@"mp4"];
    AVAsset *asset = [AVAsset assetWithURL:url];
    AVPlayerItem *item = [AVPlayerItem playerItemWithAsset:asset];
    [item addObserver:self forKeyPath:@"status" options:0 context:&PlayerItemStatusContext];
    self.player = [AVPlayer playerWithPlayerItem:item];
    AVPlayerLayer *playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.player];
    playerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    [self.view.layer addSublayer:playerLayer];
    playerLayer.backgroundColor = black_color.CGColor;
    playerLayer.frame = CGRectMake(0, KNavAndStatusHeight, KScreenWidth, 300);
    [self.player addBoundaryTimeObserverForTimes:@[[NSValue valueWithCMTime:CMTimeMake(1, 1)], [NSValue valueWithCMTime:CMTimeMake(3, 1)], [NSValue valueWithCMTime:CMTimeMake(5, 1)]] queue:dispatch_get_main_queue() usingBlock:^{
        KLog(@"addBoundaryTimeObserverForTimes---%@", [NSDate date]);
    }];
    
    [self.player addPeriodicTimeObserverForInterval:CMTimeMake(2, 1) queue:dispatch_get_main_queue() usingBlock:^(CMTime time) {
        KLog(@"addPeriodicTimeObserverForInterval----%lld", time.value);
    }];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(endPlay:) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, KNavAndStatusHeight + 300, KScreenWidth, KScreenHeight - KNavAndStatusHeight - KSafeBottomMargin - 300) style:UITableViewStylePlain];
    self.tableView.estimatedRowHeight = 0;
    self.tableView.estimatedSectionFooterHeight = 0;
    self.tableView.estimatedSectionHeaderHeight = 0;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 200;
    [self.view addSubview:self.tableView];
}

- (void)endPlay:(NSNotification *)notification {
    [self.player seekToTime:kCMTimeZero];
    [self.player play];
}

- (void)yl_initValues {
    [super yl_initValues];
    self.images = [NSMutableArray array];
}

- (void)generateImage {
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"login_video" withExtension:@"mp4"];
    AVAsset *asset = [AVAsset assetWithURL:url];
    self.imageGenerator = [AVAssetImageGenerator assetImageGeneratorWithAsset:asset];
    self.imageGenerator.maximumSize = CGSizeMake(200.f, 0);
    CMTime duration = asset.duration;
    NSMutableArray *times = [NSMutableArray array];
    CMTimeValue increment = duration.value / 20;
    CMTimeValue currentValue = 0;
    while (currentValue <= duration.value) {
        CMTime time = CMTimeMake(currentValue, duration.timescale);
        [times addObject:[NSValue valueWithCMTime:time]];
        currentValue += increment;
    }
    
    __block NSUInteger imagesCount = times.count;
    AVAssetImageGeneratorCompletionHandler handler = ^(CMTime requestTime, CGImageRef imageRef, CMTime acturalTime, AVAssetImageGeneratorResult result, NSError *error) {
        if (result == AVAssetImageGeneratorSucceeded) {
            UIImage *image = [UIImage imageWithCGImage:imageRef];
            [self.images addObject:image];
        }
        if (--imagesCount == 0) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
            });
        }
    };
    
    [self.imageGenerator generateCGImagesAsynchronouslyForTimes:times completionHandler:handler];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.images.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class])];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([UITableViewCell class])];
        UIImageView *iv = [[UIImageView alloc] initWithFrame:cell.frame];
        iv.tag = 1;
        [cell addSubview:iv];
    }
    
    UIImageView *iv = [cell viewWithTag:1];
    iv.image = self.images[indexPath.row];
    return cell;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if (context == &PlayerItemStatusContext) {
        AVPlayerItem *playerItem = (AVPlayerItem *)object;
        if (playerItem.status == AVPlayerItemStatusReadyToPlay) {
            [self.player play];
            [self generateImage];
        }
    }
}

@end
