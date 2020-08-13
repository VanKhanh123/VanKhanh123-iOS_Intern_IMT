//
//  ViewController.h
//  RealmDB
//
//  Created by Cong Thanh on 8/6/20.
//  Copyright © 2020 IMT Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Staff/Staff.h"
#import <Realm/Realm.h>
#import "CustomCell/CustomCell.h"
@interface ViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, DeleteCellDelegate, EditCellDelegate,UITextFieldDelegate, UISearchBarDelegate>
@property (weak, nonatomic) IBOutlet UITextField *tfName;
@property (weak, nonatomic) IBOutlet UITextField *tfEmail;
@property (weak, nonatomic) IBOutlet UIButton *btnReset;
@property (weak, nonatomic) IBOutlet UIButton *btnSave;
@property (weak, nonatomic) IBOutlet UITableView *tvbStaff;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (nonatomic,assign) NSString *idTotal;

@property (nonatomic,strong) NSString *tempName;
@property (nonatomic,strong) NSString *tempEmail;
// Cái hàm này là Delegate từ View Cell qua.
-(void)didTapDeleteCell:(NSString* )idd;
-(void)didTapEditCell:(NSString* )idd;

@end

