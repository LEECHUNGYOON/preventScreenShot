import UIKit

@objc(preventScreen) class preventScreen : CDVPlugin {
    
    var coverView: UIView?
    
    override func pluginInitialize() {
        print("yoon: pluginInitialize?")
        NotificationCenter.default.addObserver(self, selector: #selector(preventScreenshot), name: UIApplication.userDidTakeScreenshotNotification, object: nil)
    }
    
    @objc func preventScreenshot() {
        // 현재 뷰 컨트롤러의 뷰에 검정색 UIView를 추가
        if let viewController = self.viewController {
            let coverView = UIView(frame: viewController.view.bounds)
            coverView.backgroundColor = UIColor.black
            coverView.alpha = 0.8
            viewController.view.addSubview(coverView)
            
            // 캡쳐가 완료되면 UIView를 제거
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                coverView.removeFromSuperview()
            }
        }
    }
}
