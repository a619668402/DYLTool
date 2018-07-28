//
//  NineCollectionViewCell.m
//  DYLTool
//
//  Created by sky on 2018/7/27.
//  Copyright © 2018年 DYL. All rights reserved.
//

#import "YLNineCollectionViewCell.h"

#define YLNINEDELETEBTNWIDTH 24

@interface YLNineCollectionViewCell ()

@property (nonatomic, strong) NSIndexPath *selectedIndexPath;

@end

@implementation YLNineCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self _initViews];
    }
    return self;
}

- (void)_initViews {
    [self addSubview:self.imgView];
    [self.imgView addSubview:self.deleteBtn];
}

#pragma mark ************* Public Method Start *************
- (void)setData:(NSArray *)dataSource indexPath:(NSIndexPath *)indexPath {
    self.selectedIndexPath = indexPath;
    self.deleteBtn.hidden = NO;
    if (indexPath.row == dataSource.count) {
        self.imgView.image = [UIImage imageNamed:@"nine_image_add_32x32"];
        self.deleteBtn.hidden = YES;
    } else {
        self.imgView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:dataSource[indexPath.item]]];
    }
}
#pragma mark ************* Public Method End   *************

#pragma mark ************* Private Method Start *************
- (void)_deleteBtnClick:(UIButton *)btn {
    KLogFunc;
    if (self.delegate && [self.delegate respondsToSelector:@selector(yl_deleteBtnClick:)]) {
        [self.delegate yl_deleteBtnClick:self.selectedIndexPath.row];
    }
}
#pragma mark ************* Private Method End   *************

#pragma mark ************* Lazyload Start *************
- (UIImageView *)imgView {
    if (!_imgView) {
        _imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.yl_width, self.yl_height)];
        _imgView.contentMode = UIViewContentModeScaleToFill;
        _imgView.userInteractionEnabled = YES;
    }
    return _imgView;
}

- (UIButton *)deleteBtn {
    if (!_deleteBtn) {
        _deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_deleteBtn setBackgroundImage:[UIImage imageNamed:@"nine_image_delete_8x8"] forState:UIControlStateNormal];
        _deleteBtn.frame = CGRectMake(self.yl_width - YLNINEDELETEBTNWIDTH - 4, 4, YLNINEDELETEBTNWIDTH, YLNINEDELETEBTNWIDTH);
        [_deleteBtn addTarget:self action:@selector(_deleteBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _deleteBtn;
}
#pragma mark ************* Lazyload End   *************


@end
