//
//  ViewController.m
//  ExpandingCollectionView2
//
//  Created by Quang Tran on 5/24/17.
//  Copyright © 2017 Quang Tran. All rights reserved.
//

#import "ViewController.h"

#import "CardCell.h"
#import "BgCell.h"
#import "NumberCell.h"

#import "CardCollectionViewLayout.h"
#import "NumberCollectionViewLayout.h"
#import "BgCollectionViewLayout.h"

#import "UIColor+Ext.h"
#import "Course.h"
#import "DetailViewController.h"

#import "CardPresentAnimationController.h"
#import "CardDismissAnimationController.h"

@interface ViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UIViewControllerTransitioningDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *bgCollectionView;
@property (weak, nonatomic) IBOutlet UICollectionView *cardCollectionView;
@property (weak, nonatomic) IBOutlet UICollectionView *numberCollectionView;
@property (weak, nonatomic) IBOutlet UILabel *totalCoursesLabel;
@property (weak, nonatomic) IBOutlet UIButton *searchButton;

@property(strong) NSArray<Course*>* courses;
@property(strong) CardPresentAnimationController *cardPresentAnimationController;
@property(strong) CardDismissAnimationController *cardDismissAnimationController;
@property(strong) DetailViewController *detailViewController;
@end

@implementation ViewController

const CGFloat kBgOffsetWidth = 100;

- (void)viewDidLoad {
  [super viewDidLoad];
  
  self.courses = [self coursesData];
  self.totalCoursesLabel.text = [NSString stringWithFormat:@"%ld", (unsigned long)self.courses.count];
  
  [self configCardCollectionView];
  [self configNumberCollectionView];
  [self configBgCollectionView];
  
  self.cardPresentAnimationController = [CardPresentAnimationController new];
  self.cardDismissAnimationController = [CardDismissAnimationController new];
}

- (IBAction)searchButtonDidTap:(UIButton *)sender {
  [self.detailViewController dismissViewControllerAnimated:YES completion:nil];
  [self changeBackIconToSearchIcon];
}

-(BOOL)prefersStatusBarHidden {
  return YES;
}

-(NSArray<Course*>*)coursesData {
  NSString *path = [[NSBundle mainBundle] pathForResource:@"data" ofType:@"json"];
  NSData *data = [NSData dataWithContentsOfFile:path];
  NSError *err;
  NSArray *arr = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&err];
  if (err == nil) {
    return [Course coursesWithDictArray:arr];
  }
  else {
    [NSException raise:@"Can not get courses data!" format:@"%@", err.localizedDescription];
    return nil;
  }
}

-(void)configBgCollectionView {
  self.bgCollectionView.prefetchingEnabled = NO;
  self.bgCollectionView.delegate = self;
  self.bgCollectionView.dataSource = self;
  self.bgCollectionView.showsHorizontalScrollIndicator = NO;
  [self.bgCollectionView setUserInteractionEnabled:NO];
  BgCollectionViewLayout *layout = (BgCollectionViewLayout*)self.bgCollectionView.collectionViewLayout;
  layout.offsetWidth = kBgOffsetWidth;
}

-(void)configNumberCollectionView {
  self.numberCollectionView.delegate = self;
  self.numberCollectionView.dataSource = self;
  self.numberCollectionView.showsVerticalScrollIndicator = NO;
  self.numberCollectionView.backgroundColor = [UIColor clearColor];
  self.numberCollectionView.userInteractionEnabled = NO;
}

-(void)configCardCollectionView {
  self.cardCollectionView.prefetchingEnabled = NO;
  self.cardCollectionView.delegate = self;
  self.cardCollectionView.dataSource = self;
  self.cardCollectionView.showsHorizontalScrollIndicator = NO;
  self.cardCollectionView.backgroundColor = [UIColor clearColor];
  self.cardCollectionView.layer.masksToBounds = NO;
}

-(void)changeSearchIconToBackIcon {
  UIImage *backIcon = [UIImage imageNamed:@"back"];
  [UIView transitionWithView:self.searchButton
                    duration:0.5
                     options:UIViewAnimationOptionTransitionFlipFromLeft
                  animations:^{
                    [self.searchButton setImage:backIcon forState:UIControlStateNormal];
                  } completion:nil];
}

-(void)changeBackIconToSearchIcon {
  UIImage *searchIcon = [UIImage imageNamed:@"search"];
  [UIView transitionWithView:self.searchButton
                    duration:0.5
                     options:UIViewAnimationOptionTransitionFlipFromRight
                  animations:^{
                    [self.searchButton setImage:searchIcon forState:UIControlStateNormal];
                  } completion:nil];
}


-(void)showDetailViewControllerWithCourse:(Course *)c {
  self.detailViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"DetailViewController"];
  self.detailViewController.course = c;
  self.detailViewController.transitioningDelegate = self;
  [self presentViewController:self.detailViewController animated:YES completion:nil];
  
  [self.cardCollectionView setUserInteractionEnabled:NO];
  [self animateHideSiblingCells:YES];
  [self changeSearchIconToBackIcon];
}

-(void)animateHideSiblingCells:(BOOL)isHide {
  NSIndexPath *selectedIndexPath = self.cardCollectionView.indexPathsForSelectedItems.firstObject;
  CardCell *previousCell;
  CardCell *nextCell;
  
  // Get previous cell if available
  if (selectedIndexPath.row - 1 >= 0) {
    NSIndexPath *previousIndexPath = [NSIndexPath indexPathForRow:(selectedIndexPath.row - 1) inSection:0];
    previousCell = (CardCell *)[self.cardCollectionView cellForItemAtIndexPath:previousIndexPath];
  }
  
  // Get next cell if available
  if (selectedIndexPath.row + 1 < self.courses.count) {
    NSIndexPath *nextIndexPath = [NSIndexPath indexPathForRow:(selectedIndexPath.row + 1) inSection:0];
    nextCell = (CardCell *)[self.cardCollectionView cellForItemAtIndexPath:nextIndexPath];
  }
  
  // Get scale of card cell
  CardCollectionViewLayout *cardCollectionViewLayout = (CardCollectionViewLayout*)self.cardCollectionView.collectionViewLayout;
  CGFloat alpha = cardCollectionViewLayout.nonFeaturedScale;
  NSTimeInterval duration = 0.5;
  
  // Translate sibling cells to 2 side to hide it
  if (isHide == YES) {
  CGFloat translate = (self.cardCollectionView.bounds.size.width - cardCollectionViewLayout.cellWidth) / 2;
  CGAffineTransform translateBackward = CGAffineTransformMakeTranslation(-translate, 0);
  CGAffineTransform transformBackward = CGAffineTransformScale(translateBackward, alpha, alpha);
  CGAffineTransform translateForward = CGAffineTransformMakeTranslation(translate, 0);
  CGAffineTransform transformForward = CGAffineTransformScale(translateForward, alpha, alpha);
  [UIView animateWithDuration:duration
                   animations:^{
                     if (previousCell != nil) {
                       previousCell.transform = transformBackward;
                     }
                     if (nextCell != nil) {
                       nextCell.transform = transformForward;
                     }
                   }];
  }
  // Translate sibling cells beside 2 side of featured cell to show it
  else {
    CGAffineTransform transform = CGAffineTransformMakeScale(alpha, alpha);
    [UIView animateWithDuration:duration
                     animations:^{
                       if (previousCell != nil) {
                         previousCell.transform = transform;
                       }
                       if (nextCell != nil) {
                         nextCell.transform = transform;
                       }
                     }];
  }
}

#pragma mark - Collection View Delegate DataSource
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
  return self.courses.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                 cellForItemAtIndexPath:(NSIndexPath *)indexPath {
  // Return card cell
  if ([collectionView isEqual:self.cardCollectionView]) {
    CardCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.course = self.courses[indexPath.row];
    return cell;
  }
  // Return number cell
  else if ([collectionView isEqual:self.numberCollectionView]) {
    NumberCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.number = indexPath.row + 1;
    return cell;
  }
  // Return background cell
  else {
    BgCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    Course *course = self.courses[indexPath.row];
    cell.img = [UIImage imageNamed:course.featuredImageName];
    return cell;
  }
}

// Animate numbers and background when user drag cards
-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
  if ([scrollView isEqual:self.cardCollectionView]) {
    CardCollectionViewLayout *cardCollectionViewLayout = (CardCollectionViewLayout*)self.cardCollectionView.collectionViewLayout;
    // Calculate percent that card moved
    CGFloat percent = scrollView.contentOffset.x / (cardCollectionViewLayout.cellWidth * (self.courses.count - 1));
    
    // Animate numbers based on percent
    NumberCollectionViewLayout *numberCollectionViewLayout = (NumberCollectionViewLayout*)self.numberCollectionView.collectionViewLayout;
    [self.numberCollectionView setContentOffset:CGPointMake(0, percent * numberCollectionViewLayout.cellHeight * (self.courses.count - 1))];
    
    // Animate background based on percent
    [self.bgCollectionView setContentOffset:CGPointMake(percent * kBgOffsetWidth * (self.courses.count - 1), 0)];
  }
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
  if ([collectionView isEqual:self.cardCollectionView]) {
    CardCollectionViewLayout *layout = (CardCollectionViewLayout*)self.cardCollectionView.collectionViewLayout;
    CGFloat cellWidth = layout.cellWidth;
    // Only move when user doesn't choose featured cell
    if (collectionView.contentOffset.x != indexPath.row * cellWidth) {
      [collectionView setContentOffset:CGPointMake(indexPath.row * cellWidth, 0) animated:YES];
    }
    else {
      [self showDetailViewControllerWithCourse:self.courses[indexPath.row]];
    }
  }
}

-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
  // Show detail view controller after sibling cell animated into featured cell
  NSIndexPath *selectedIndexPath = self.cardCollectionView.indexPathsForSelectedItems.firstObject;
  
  // Put in asyn block to make sure that the animation done correctly.
  dispatch_async(dispatch_get_main_queue(), ^{
    [self showDetailViewControllerWithCourse:self.courses[selectedIndexPath.row]];
  });
}

#pragma mark - UIViewControllerTransitioningDelegate
-(id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented
                                                                 presentingController:(UIViewController *)presenting
                                                                     sourceController:(UIViewController *)source {
  NSIndexPath *selectedIndexPath = self.cardCollectionView.indexPathsForSelectedItems.firstObject;
  CardCell *cell = (CardCell *)[self.cardCollectionView cellForItemAtIndexPath:selectedIndexPath];
  CGRect cellFrame = [cell convertRect:cell.contentView.frame toView:self.view];
  self.cardPresentAnimationController.originFrame = cellFrame;
  
  return self.cardPresentAnimationController;
}

-(id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
  NSIndexPath *selectedIndexPath = self.cardCollectionView.indexPathsForSelectedItems.firstObject;
  CardCell *cell = (CardCell *)[self.cardCollectionView cellForItemAtIndexPath:selectedIndexPath];
  CGRect cellFrame = [cell convertRect:cell.contentView.frame toView:self.view];
  self.cardDismissAnimationController.destinationFrame = cellFrame;
  
  [self.cardCollectionView setUserInteractionEnabled:YES];
  [self animateHideSiblingCells:NO];
  
  return self.cardDismissAnimationController;
}

@end

