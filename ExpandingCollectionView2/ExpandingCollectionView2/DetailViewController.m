//
//  DetailViewController.m
//  ExpandingCollectionView2
//
//  Created by Quang Tran on 5/25/17.
//  Copyright © 2017 Quang Tran. All rights reserved.
//

#import "DetailViewController.h"
#import "CommenterCell.h"

@interface DetailViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *featuredImageView;
@property (weak, nonatomic) IBOutlet UIImageView *faceImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;
@property (weak, nonatomic) IBOutlet UIImageView *eyeImageView;
@property (weak, nonatomic) IBOutlet UILabel *viewLabel;
@property (weak, nonatomic) IBOutlet UIImageView *commentImageView;
@property (weak, nonatomic) IBOutlet UILabel *commentLabel;
@property (weak, nonatomic) IBOutlet UIImageView *heartImageView;
@property (weak, nonatomic) IBOutlet UILabel *likeLabel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation DetailViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  self.tableView.delegate = self;
  self.tableView.dataSource = self;
  
  [self populateData];
}

-(BOOL)prefersStatusBarHidden {
  return YES;
}

-(void)populateData {
  Course *c = self.course;
  self.featuredImageView.image = [UIImage imageNamed:c.featuredImageName];
  self.titleLabel.text = c.title;
  self.faceImageView.image = [UIImage imageNamed:c.authorAvatarName];
  self.nameLabel.text = c.authorName;
  self.descLabel.text = c.desc;
  self.viewLabel.text = [NSString stringWithFormat:@"%ld", c.views];
  self.commentLabel.text = [NSString stringWithFormat:@"%ld", c.comments];
  self.likeLabel.text = [NSString stringWithFormat:@"%ld", c.likes];
}

-(void)viewDidLayoutSubviews {
  self.faceImageView.layer.cornerRadius = self.faceImageView.bounds.size.width/2;
  self.faceImageView.layer.masksToBounds = YES;
  
  UIColor *iconTintColor = [UIColor lightGrayColor];
  UIImage *eyeImg = [[UIImage imageNamed:@"eye"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
  self.eyeImageView.image = eyeImg;
  self.eyeImageView.tintColor = iconTintColor;
  
  UIImage *commentImg = [[UIImage imageNamed:@"comment"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
  self.commentImageView.image = commentImg;
  self.commentImageView.tintColor = iconTintColor;
  
  UIImage *heartImg = [[UIImage imageNamed:@"heart"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
  self.heartImageView.image = heartImg;
  self.heartImageView.tintColor = iconTintColor;
}

#pragma mark - Table View Delegate DataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return self.course.commenters.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  CommenterCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
  cell.commenter = self.course.commenters[indexPath.row];
  return cell;
}

@end
