//
//  ViewController.m
//  Awzaw
//
//  Created by Darshit Vora on 11/10/17.
//  Copyright © 2017 MrpVision. All rights reserved.
//

#import "AWUserGuidanceVC.h"
#import "AWGuidanceCVCell.h"
#import "AWIntroVC.h"

@interface AWUserGuidanceVC ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property(strong,nonatomic) IBOutlet UICollectionView *guidanceCVObj;
@property(strong,nonatomic) NSMutableArray *arrGuidance;
@property(strong,nonatomic) IBOutlet UIButton *skipBtn;

@end


@implementation AWUserGuidanceVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES];
    if ([[NSUserDefaults standardUserDefaults] boolForKey:APPHasLaunchedOnce]){
        AWIntroVC *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"AWIntroVC"];
        [self.navigationController pushViewController:vc animated:YES];
    } else{
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:APPHasLaunchedOnce];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }

    self.arrGuidance = [[NSMutableArray alloc] initWithObjects:@"1.jpg", @"2.jpg", @"3.jpg", @"4.jpg", @"5.jpg", nil];
    // Do any additional setup after loading the view, typically from a nib.
//    [self showActivityIndicatorwithTitle:Title_Loading animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Custom Methods -



#pragma mark - Custom Actions -

- (IBAction)btnSkipClick:(id)sender {
    AWIntroVC *intro = [self.storyboard instantiateViewControllerWithIdentifier:@"AWIntroVC"];
    [self.navigationController pushViewController:intro animated:YES];
}


#pragma mark - Collection View Methods -

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    NSLog(@"should be seeing %lu collection view cells", (unsigned long)self.arrGuidance.count);
    return self.arrGuidance.count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    NSLog(@"QUERYING NUMBER OF SECTIONS IN COLLECTION VIEW");
    return 1;
}

- (UICollectionViewCell  *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"AWGuidanceCVCell";
    AWGuidanceCVCell *cell = (AWGuidanceCVCell *)[self.guidanceCVObj dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    cell.imgView.image = [UIImage imageNamed:[self.arrGuidance objectAtIndex:indexPath.row]];
    cell.pageControlObj.numberOfPages = self.arrGuidance.count;
    cell.pageControlObj.currentPage = indexPath.row;
    [self.skipBtn setTitle:@"SKIP" forState:UIControlStateNormal];
    if (cell.pageControlObj.currentPage == self.arrGuidance.count - 1)
        [self.skipBtn setTitle:@"NEXT" forState:UIControlStateNormal];

    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"calling didselctitem at path");
}
    
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return CGSizeMake(self.view.frame.size.width, self.view.frame.size.height);
}

@end
