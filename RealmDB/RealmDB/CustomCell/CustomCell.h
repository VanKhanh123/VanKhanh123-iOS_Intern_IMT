//
//  CustomCell.h
//  RealmDB
//
//  Created by Van Khanh Vuong on 8/10/20.
//  Copyright © 2020 IMT Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Staff.h"
@class CustomCell;

@protocol DeleteCellDelegate <NSObject>
@required
-(void)didTapDeleteCell:(NSString *)idd;
@end

@protocol EditCellDelegate <NSObject>
@required
-(void)didTapEditCell:(NSString *)idd;
@end

@interface CustomCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UITextField *tfUserName;
@property (weak, nonatomic) IBOutlet UITextField *tfEmail;
@property (weak, nonatomic) IBOutlet UIButton *btnEdit;
@property (weak, nonatomic) IBOutlet UIButton *btnDelete;

@property (nonatomic,strong) NSString *iddCustomCell;
// Delegete
@property (nonatomic,strong) id<DeleteCellDelegate> delegateDelete;
@property (nonatomic,strong) id<EditCellDelegate> delegateEdit;

@end
