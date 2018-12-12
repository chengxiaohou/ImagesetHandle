//
//  ImageRenameVC.m
//  ImagesetHandle
//
//  Created by fengyi on 2018/12/10.
//  Copyright © 2018 fengyi. All rights reserved.
//

#import "ImageRenameVC.h"
#import "Worker.h"
@interface ImageRenameVC ()

@end

@implementation ImageRenameVC

- (void)viewDidLoad {
    [super viewDidLoad];
    /**
     * 文件批量改名程序开发
     * macOS系统自带的批量改名方法不够灵活，且无法保留目录结构，因此写个用得顺手的程序：
     * 改名后可保留原目录结构
     * 可自定义哪些格式或名字的文件要改名
     * 可自定义改名格式
     * 通过Mac上的iOS模拟器使用，方便访问模拟器的文件目录
     */
    [self renameImages];
}

#pragma mark 图片批量改名
- (void)renameImages
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documePath = [paths objectAtIndex:0];
    NSString *xxxPath = [NSString stringWithFormat:@"%@/xxx",documePath];
    NSArray *allFiles = [Worker getAllFilesByPath:xxxPath handle:^(NSString * _Nonnull name, NSString * _Nonnull path) {
        
        {
            if ([name hasSuffix:@"png"] || [name hasSuffix:@"jpg"] || [name hasSuffix:@"gif"]) {
                
                NSString *newName = [name stringByReplacingOccurrencesOfString:@"rrss" withString:@"yyww"];
//                NSString *newName = [NSString stringWithFormat:@"rrss_%@",name];
                [Worker renameFileName:name toNewName:newName floderPath:path];
            }
        }
    }];
    if (allFiles.count == 0) {
        NSLog(@"CXHLog:请确保存此路径存在%@，且其中包含本次需要改名的图片", xxxPath);
        return;
    }
    else
    {
        NSLog(@"CXHLog:成功！请查看：%@", xxxPath);
    }
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end