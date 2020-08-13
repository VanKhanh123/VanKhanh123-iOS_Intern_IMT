//
//  ViewController.m
//  RealmDB
//
//  Created by Van Khanh Vuong  on 8/6/20.
//  Copyright © 2020 IMT Solutions. All rights reserved.
//
//  Đặt khóa chính https://academy.realm.io/posts/realm-primary-keys-tutorial/
//  Xóa            https://stackoverflow.com/questions/42153334/realm-how-to-delete-object-from-rlmarray
//  Thêm           https://realm.io/docs/objc/latest/#creating-objects
//  regex          https://techfuzionwithsam.wordpress.com/2014/01/09/email-address-validation-in-ios/

#import "ViewController.h"
#import <Realm.h>
#import "Utility/Utility.h"

@interface ViewController ()
@property (nonatomic,strong) RLMResults<Staff *> *arr;
@end

@implementation ViewController{
    BOOL isFiltered;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tvbStaff.delegate =  self;
    self.tvbStaff.dataSource = self;
    self.searchBar.delegate = self;
    self.tfName.delegate = self;
    self.tfEmail.delegate = self;
    
    isFiltered = false;
    
    [self.tvbStaff registerNib:[UINib nibWithNibName:@"CustomCell" bundle:nil] forCellReuseIdentifier:@"customCell"];
    // Lấy thông tin DB
    RLMRealmConfiguration *config = [RLMRealmConfiguration defaultConfiguration];
    NSURL *url = [config fileURL];
    NSLog(@"%@",url);
    
    self.arr = [[Staff allObjects]sortedResultsUsingKeyPath:@"name" ascending:YES];
    
    [self.tfName becomeFirstResponder];
}
-(void)GetData:(NSString*)check{
    if([self.searchBar.text isEqualToString:@""]){
        self.arr = [[Staff allObjects]sortedResultsUsingKeyPath:@"name" ascending:YES];
    }else{
        NSString *string1 = @"name = '";
        NSString *string2 =check;
        
        NSString *string3 = [string1 stringByAppendingString:string2];
        
        NSString *string4 = @"' OR email BEGINSWITH '";
        NSString *string5 = [string4 stringByAppendingString:string2];
        
        //self.searchBar.text
        NSString *string6 = [string3 stringByAppendingString:string5];
        NSString *string7 = @"'";
        NSString *string8 = [string6 stringByAppendingString:string7];
        
        NSLog(@"%@",string8);
        
        self.arr = [[Staff objectsWhere:string8]
                    sortedResultsUsingKeyPath:@"email" ascending:YES];
    }
    [self.tvbStaff reloadData];
}

-(void)funcClear{
    self.tfName.text = @"";
    self.tfEmail.text = @"";
    self.idTotal = @"";
    self.tempEmail = nil;
    self.tempName = nil;
}

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    [self GetData:searchText.lowercaseString];
}

-(void)viewDidAppear:(BOOL)animated{
    [self.tfName becomeFirstResponder];
}

-(BOOL)textFieldShouldReturn:(UITextField*)textField
{
    NSInteger nextTag = textField.tag + 1;
    // Thử đi tìm thằng textField OR textView với tag=2.
    UIResponder* nextResponder = [textField.superview viewWithTag:nextTag];
    if (nextResponder) {
        // Tìm được rồi thì trỏ vào textField OR textView với tag=2
        [nextResponder becomeFirstResponder];
    } else {
        // Ngược lại thì không trỏ vào ai hết và dismiss keyboard
        [textField resignFirstResponder];
    }
    return NO; // cái này để tránh textField tự ngắt dòng. (Do return là xuống hàng)
}

// Hàm để khi click return thì tắt keyboard
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if([string isEqualToString:@"\n"]){
        [textField resignFirstResponder];
        return NO; // cái này để tránh textView tự ngắt dòng. (Do return là xuống hàng)
    }
    return YES;
}

// // DELEGATE BUTTON XÓA
- (void)didTapDeleteCell:(NSString *)idd{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Thông báo" message:@"Có muốn xóa dữ liệu?" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *actionOK = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //-----
        RLMRealm *realm = [RLMRealm defaultRealm];
        //Lay mang Staff để show Log
        self.arr = [Staff allObjects];
        NSLog(@"Đã vào hàm xóa");
        NSLog(@"%@",self.arr);
        // Khởi tạo đối tượng myStaff với ID là idd
        Staff *myStaff = [Staff objectForPrimaryKey:idd];
        [realm transactionWithBlock:^{
            [realm deleteObject:myStaff];
        }];
        [self.tvbStaff reloadData];
        [self funcClear];
        [self.tfName becomeFirstResponder];
        //-----
    }];
    UIAlertAction *actionCancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"Cancel!");
    }];
    
    [alert addAction:actionOK];
    [alert addAction:actionCancel];
    [self presentViewController:alert animated:YES completion:nil];
    
}

// DELEGATE BUTTON SỬA
- (void)didTapEditCell:(NSString *)idd{
    // Tìm đối tượng trên tableCell
    Staff *myStaffFind = [Staff objectForPrimaryKey:idd];
    // Hiện thông tin đối tượng đó trên hai textField
    self.tfName.text = myStaffFind.name;
    self.tempName = self.tfName.text;
    self.tfEmail.text = myStaffFind.email;
    self.tempEmail = self.tfEmail.text;
    self.idTotal = idd;
    NSLog(@"idd :%@",idd);
    NSLog(@"idTotal :%@",self.idTotal);
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.arr count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *simpleTableIdentifier = @"customCell";
    CustomCell *cell = (CustomCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if(cell == nil) {
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"CustomCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }else{
        cell.tfUserName.text = self.arr[indexPath.row].name;
        cell.tfEmail.text = self.arr[indexPath.row].email;
        
        cell.iddCustomCell = [NSString stringWithFormat:@"%@",self.arr[indexPath.row].staffID];
        cell.delegateDelete = (id<DeleteCellDelegate>)self;
        cell.delegateEdit = (id<EditCellDelegate>)self;
    }
    return cell;
}

// BUTTON SAVE 
-(IBAction)btnSave:(id)sender{
    if ([self.tfName.text isEqual:@""] || [self.tfEmail.text isEqual:@""]){
        NSLog(@"TF không có chứ thì arlert ra");
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Thông báo" message:@"Thông tin không được trống!" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *actionOK = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            //-----
            
            //-----
        }];
        [alert addAction:actionOK];
        [self presentViewController:alert animated:YES completion:nil];
    }else if (![self.tfName.text isEqual:@""] && ![self.tfEmail.text isEqual:@""]){
        if([Utility validateEmail:self.tfEmail.text]==NO){
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Thông báo" message:@"Email không đúng định dạng!" preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *actionOK = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            }];
            [alert addAction:actionOK];
            [self presentViewController:alert animated:YES completion:nil];
        }else{
            
            if(self.tempName == nil && self.tempEmail == nil){
                NSLog(@"Hàm này dùng để thêm");
                Staff *myStaff = [[Staff alloc]initStaff:self.tfName.text email:self.tfEmail.text];
                // Thêm đối tượng đó vào DB
                RLMRealm *realm = [RLMRealm defaultRealm];
                self.arr = [Staff allObjects];
                [realm transactionWithBlock:^{
                    //Thêm đối tượng vào DB
                    [realm addObject:myStaff];
                }];
                [self.tvbStaff reloadData];
                [self funcClear];
                [self.tfName becomeFirstResponder];
            }else if(self.tempName != nil && self.tempEmail != nil){
                NSLog(@"Hàm này dùng để  sửa");
                Staff *staff = [[Staff alloc] init];
                staff.name = self.tfName.text;
                staff.email = self.tfEmail.text;
                staff.staffID = self. idTotal;
                RLMRealm *realm = [RLMRealm defaultRealm];
                self.arr = [Staff allObjects];
                [realm transactionWithBlock:^{
                    //Có chức năng thêm ngoài ra sẽ tự động thấy sự thay đổi thông tin mà ID của đối tượng vẫn giữ nguyên thì tự động cập nhật lại thông tin vào DB.
                    [realm addOrUpdateObject:staff];
                }];
                [self.tvbStaff reloadData];
                [self funcClear];
                [self.tfName becomeFirstResponder];
            }
        }
    }
}
// BUTTON LÀM MỚI.
-(IBAction)btnReset:(id)sender{
    [self funcClear];
    [self.tvbStaff reloadData];
    [self.tfName becomeFirstResponder];
}
@end
