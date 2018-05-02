//
//  ScanViewController.m
//  FindAudioBooks
//
//  Created by Xiaohe Hu on 4/22/18.
//  Copyright © 2018 com.xiaohehu. All rights reserved.
//

#import "ScanViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "FetchParseBookInfo.h"

@interface ScanViewController () <AVCaptureMetadataOutputObjectsDelegate> {
    AVCaptureSession *_session;
    AVCaptureDevice *_device;
    AVCaptureDeviceInput *_input;
    AVCaptureMetadataOutput *_output;
    AVCaptureVideoPreviewLayer *_prevLayer;
    
    int viewBoundsWidth;
    int viewBoundsHeight;
    float videoSize;
}

@property (nonatomic, strong) UIView                *uiv_bookInfoContainer;
@property (nonatomic, strong) UIImageView           *uiiv_cover;
@property (nonatomic, strong) UILabel               *uil_bsn;
@property (nonatomic, strong) UILabel               *uil_title;
@property (nonatomic, strong) FetchParseBookInfo    *fetcher;
@property (nonatomic, strong) UIButton              *uib_fetchToggle;
@property (nonatomic, strong) UIButton              *uib_searchAudible;

@end

@implementation ScanViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    viewBoundsWidth = self.view.frame.size.width;
    viewBoundsHeight = self.view.frame.size.height;
    // Make view size 80% of view's width
    videoSize = viewBoundsWidth * 0.8;
    
    // Do any additional setup after loading the view.
    self.title = @"Scanner";
    
    [self initVideoSession];
    
    [self initBookInfoView];
    
    [self initFetchToggleButton];
}

- (void) initVideoSession {
    _session = [[AVCaptureSession alloc] init];
    _device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    NSError *error = nil;
    
    _input = [AVCaptureDeviceInput deviceInputWithDevice:_device error:&error];
    if (_input) {
        [_session addInput:_input];
    } else {
        NSLog(@"Error: %@", error);
    }
    
    _output = [[AVCaptureMetadataOutput alloc] init];
    [_output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    [_session addOutput:_output];
    _output.metadataObjectTypes = [_output availableMetadataObjectTypes];
    
    
    
    
    _prevLayer = [AVCaptureVideoPreviewLayer layerWithSession:_session];
    _prevLayer.frame = CGRectMake((viewBoundsWidth - videoSize) / 2.0, // Make camera window in middle of X direction
                                  (viewBoundsHeight - videoSize) / 2.0 * 0.2, // Make cameera window closer to top
                                  videoSize, videoSize);
    
    _prevLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    [self.view.layer addSublayer:_prevLayer];
    [_session startRunning];
}

- (void) initBookInfoView {
    int topPad = 10;
    int bottomPad = 80;
    float bookCoverPercentage = 0.5;
    float bookInfoPercentage = 0.2;
    float padding = 0.0;
    float bookInfoHeight = 0.0;
    self.uiv_bookInfoContainer = [[UIView alloc]
                                  initWithFrame:CGRectMake(0,
                                                        _prevLayer.frame.origin.y + _prevLayer.frame.size.height + topPad,
                                                        self.view.frame.size.width,
                                                           self.view.frame.size.height - _prevLayer.frame.origin.y - _prevLayer.frame.size.height - bottomPad)];
    [_uiv_bookInfoContainer setBackgroundColor:[UIColor redColor]];
    padding = _uiv_bookInfoContainer.frame.size.height * 0.1 / 2.0;
    bookInfoHeight = _uiv_bookInfoContainer.frame.size.height * bookInfoPercentage;
    [self.view addSubview:_uiv_bookInfoContainer];
    
    // Init book's cover UIImageView
    float coverSize = _uiv_bookInfoContainer.frame.size.height * bookCoverPercentage;
    float coverX = (_uiv_bookInfoContainer.frame.size.width - coverSize) / 2.0;
    
    _uiiv_cover = [[UIImageView alloc] initWithFrame:CGRectMake(coverX, 0.0, coverSize, coverSize)];
    [_uiiv_cover setBackgroundColor:[UIColor whiteColor]];
    [_uiv_bookInfoContainer addSubview: _uiiv_cover];
    
    // Init book's BSN label
    _uil_bsn = [[UILabel alloc] initWithFrame:CGRectMake(0.0,
                                                         _uiiv_cover.frame.size.height + padding,
                                                         _uiv_bookInfoContainer.frame.size.width,
                                                         bookInfoHeight)];
    [_uil_bsn setBackgroundColor:[UIColor yellowColor]];
    [_uil_bsn setTextAlignment:NSTextAlignmentCenter];
    [_uiv_bookInfoContainer addSubview: _uil_bsn];
    
    // Init book's title label
    _uil_title = [[UILabel alloc] initWithFrame:CGRectMake(0.0,
                                                           _uil_bsn.frame.origin.y + _uil_bsn.frame.size.height + padding,
                                                           _uiv_bookInfoContainer.frame.size.width,
                                                           bookInfoHeight)];
    [_uil_title setBackgroundColor:[UIColor greenColor]];
    [_uil_title setTextAlignment:NSTextAlignmentCenter];
    [_uiv_bookInfoContainer addSubview: _uil_title];
    
    float imageButtonPadding = 10;
    float searchButtonX = _uiiv_cover.frame.origin.x + _uiiv_cover.frame.size.width + imageButtonPadding;
    float searchButtonY = _uiiv_cover.frame.size.height / 4.0;
    float searchButtonHeight = _uiiv_cover.frame.size.height / 2.0;
    float searchButtonWidth = _uiv_bookInfoContainer.frame.size.width - _uiiv_cover.frame.origin.x - _uiiv_cover.frame.size.width - 2 * imageButtonPadding;
    _uib_searchAudible = [[UIButton alloc] initWithFrame:CGRectMake(searchButtonX, searchButtonY, searchButtonWidth, searchButtonHeight)];
    [_uib_searchAudible setBackgroundColor:[UIColor orangeColor]];
    [_uib_searchAudible setTitle:@"Search in Audible" forState:UIControlStateNormal];
    [_uib_searchAudible.titleLabel setAdjustsFontSizeToFitWidth:true];
    [_uiv_bookInfoContainer addSubview: _uib_searchAudible];
}

- (void) initFetchToggleButton {
    _uib_fetchToggle = [[UIButton alloc] initWithFrame:_prevLayer.frame];
    [_uib_fetchToggle setBackgroundColor:[UIColor clearColor]];
    [_uib_fetchToggle setEnabled: YES];
    [_uib_fetchToggle addTarget:self action:@selector(toggleFetcher) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview: _uib_fetchToggle];
}

- (void) toggleFetcher {
    if ([_session isRunning]) {
        return;
    } else {
        [_session startRunning];
    }
}

- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
//    CGRect highlightViewRect = CGRectZero;
    AVMetadataMachineReadableCodeObject *barCodeObject;
    NSString *detectionString = nil;
    NSArray *barCodeTypes = @[AVMetadataObjectTypeUPCECode, AVMetadataObjectTypeCode39Code, AVMetadataObjectTypeCode39Mod43Code,
                              AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeCode93Code, AVMetadataObjectTypeCode128Code,
                              AVMetadataObjectTypePDF417Code, AVMetadataObjectTypeQRCode, AVMetadataObjectTypeAztecCode];
    
    for (AVMetadataObject *metadata in metadataObjects) {
        for (NSString *type in barCodeTypes) {
            if ([metadata.type isEqualToString:type])
            {
                barCodeObject = (AVMetadataMachineReadableCodeObject *)[_prevLayer transformedMetadataObjectForMetadataObject:(AVMetadataMachineReadableCodeObject *)metadata];
//                highlightViewRect = barCodeObject.bounds;
                detectionString = [(AVMetadataMachineReadableCodeObject *)metadata stringValue];
                break;
            }
        }
        if (detectionString != nil) {
            NSLog(@"FIND THE BOOK: \n %@", detectionString);
            _fetcher = nil;
            _fetcher = [[FetchParseBookInfo alloc] init];
            [_fetcher setBSN: detectionString];
            if ([_fetcher getBookInfo]) {
                [_uil_bsn setText:[NSString stringWithFormat:@"%@: %@", @"BSN", [_fetcher getBookBSN]]];
                [_uil_title setText:[NSString stringWithFormat:@"%@: %@", @"Title", [_fetcher getBookTitle]]];
                NSURL *url = [NSURL URLWithString:[_fetcher getCoverUrl]];
                NSData *data = [NSData dataWithContentsOfURL:url];
                UIImage *uii_cover = [[UIImage alloc] initWithData:data];
                [_uiiv_cover setImage: uii_cover];
                [_uiiv_cover setContentMode: UIViewContentModeScaleAspectFit];
                [_session stopRunning];
            } else {
                [_session stopRunning];
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Errow With Finding Book"
                                                                                         message:@"We cannot find the book by this barcode."
                                                                                  preferredStyle:UIAlertControllerStyleAlert];
                //We add buttons to the alert controller by creating UIAlertActions:
                UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
                                                                   style:UIAlertActionStyleDefault
                                                                    handler:^(UIAlertAction * action) {
                                                                        [_session startRunning];
                                                                    }];
                [alertController addAction:actionOk];
                [self presentViewController:alertController animated:YES completion:nil];
            }
        }
        break;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
