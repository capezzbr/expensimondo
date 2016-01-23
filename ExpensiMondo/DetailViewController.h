//
//  DetailViewController.h
//  ExpensiMondo
//
//  Created by Gilbert Jolly on 23/01/2016.
//  Copyright © 2016 Gilbert Jolly. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@end

