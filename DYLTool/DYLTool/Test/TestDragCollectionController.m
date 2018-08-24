//
//  TestDragCollectionController.m
//  DYLTool
//
//  Created by sky on 2018/8/24.
//  Copyright © 2018年 DYL. All rights reserved.
//

#import "TestDragCollectionController.h"
#import "TestDragCell.h"

#define ColumnNumber 5
#define CellMarginX 20
#define CellMarginY 20

@interface TestDragCollectionController ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) TestDragCell *cell;

@property (nonatomic, strong) NSIndexPath *dragingIndexPath;

@property (nonatomic, strong) NSIndexPath *targetIndexPath;

@end

@implementation TestDragCollectionController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)yl_initViews {
    [super yl_initViews];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    CGFloat cellWidth = (self.view.bounds.size.width - (ColumnNumber + 1) * CellMarginX)/ColumnNumber;
    layout.itemSize = CGSizeMake(cellWidth,cellWidth);
    layout.sectionInset = UIEdgeInsetsMake(0, CellMarginX, CellMarginY, CellMarginX);
    layout.minimumLineSpacing = CellMarginY;
    layout.minimumInteritemSpacing = CellMarginX;
    layout.headerReferenceSize = CGSizeMake(self.view.bounds.size.width, 50);
    
    _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    _collectionView.showsHorizontalScrollIndicator = NO;
    _collectionView.backgroundColor = [UIColor clearColor];
    [_collectionView registerClass:[TestDragCell class] forCellWithReuseIdentifier:NSStringFromClass([TestDragCell class])];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [self.view addSubview:_collectionView];
    
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(_longPressClick:)];
    longPress.minimumPressDuration = .4f;
    [_collectionView addGestureRecognizer:longPress];
    
    self.cell = [[TestDragCell alloc] initWithFrame:CGRectMake(0, 0, cellWidth, cellWidth)];
    self.cell.hidden = true;
    [self.collectionView addSubview:_cell];
}

- (void)_longPressClick:(UILongPressGestureRecognizer *)gesture {
    switch (gesture.state) {
        case UIGestureRecognizerStateBegan:
            [self dragBegin:gesture];
            break;
        case UIGestureRecognizerStateChanged:
            [self dragChanged:gesture];
            break;
        case UIGestureRecognizerStateEnded:
            [self dragEnd:gesture];
            break;
        default:
            break;
    }
}


-(void)dragBegin:(UILongPressGestureRecognizer*)gesture{
    CGPoint point = [gesture locationInView:self.collectionView];
    _dragingIndexPath = [self getDragingIndexPathWithPoint:point];
    if (!_dragingIndexPath) {
        return;
    }
    /*
    [self.collectionView bringSubviewToFront:self.cell];
    self.cell.bounds = [_collectionView cellForItemAtIndexPath:_dragingIndexPath].bounds;
    self.cell.center = [_collectionView cellForItemAtIndexPath:_dragingIndexPath].center;
    self.cell.hidden = NO;
    [UIView animateWithDuration:.3f animations:^{
        [_cell setTransform:CGAffineTransformMakeScale(1.2, 1.2)];
    }];
     */
}

-(void)dragChanged:(UILongPressGestureRecognizer*)gesture{
    CGPoint point = [gesture locationInView:self.collectionView];
    self.cell.center = point;
    self.targetIndexPath = [self getTargetIndexPathWithPoint:point];
    if (_targetIndexPath && _dragingIndexPath) {
        [_collectionView moveItemAtIndexPath:_dragingIndexPath toIndexPath:_targetIndexPath];
        _dragingIndexPath = _targetIndexPath;
    }
}

-(void)dragEnd:(UILongPressGestureRecognizer*)gesture{
    if (!_dragingIndexPath) {
        return;
    }
    CGRect endFrame = [self.collectionView cellForItemAtIndexPath:_dragingIndexPath].frame;
    [UIView animateWithDuration:.3f animations:^{
        [self.cell setTransform:CGAffineTransformMakeScale(1.0f, 1.0f)];
        self.cell.frame = endFrame;
    } completion:^(BOOL finished) {
        self.cell.hidden = YES;
    }];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TestDragCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([TestDragCell class]) forIndexPath:indexPath];
    cell.data = KStringWithFormat(@"%ld", indexPath.row);
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 15;
}

- (NSIndexPath *)getDragingIndexPathWithPoint:(CGPoint)point {
    NSIndexPath *dragingIndexPath = nil;
    for (NSIndexPath *indexPath in [self.collectionView indexPathsForVisibleItems]) {
        if (CGRectContainsPoint([self.collectionView cellForItemAtIndexPath:indexPath].frame, point)) {
            dragingIndexPath = indexPath;
            break;
        }
    }
    return dragingIndexPath;
}

- (NSIndexPath *)getTargetIndexPathWithPoint:(CGPoint)point {
    NSIndexPath *targetIndexPath = nil;
    for (NSIndexPath *indexPath in self.collectionView.indexPathsForVisibleItems) {
        if ([indexPath isEqual:_dragingIndexPath]) {
            continue;
        }
        if (CGRectContainsPoint([self.collectionView cellForItemAtIndexPath:indexPath].frame, point)) {
            targetIndexPath = indexPath;
        }
    }
    return targetIndexPath;
}

@end
