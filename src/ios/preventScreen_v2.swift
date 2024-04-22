import UIKit

@objc(preventScreen)
class preventScreen: CDVPlugin {
    
    private var associatedObjectHandle = 0
    
    override func pluginInitialize() {

        print("yoon: preventScreen?")

        // 캡쳐 감지용 노티피케이션 센터 추가
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(captureAction),
            name: UIScreen.capturedDidChangeNotification,
            object: nil
        )
    }
    
    @objc func captureAction() {

        print("yoon: capture?")
        
        if UIScreen.main.isCaptured {
            // 캡쳐 중이면 = 화면 녹화 중이면
            self.secureMode(enable: true)
        } else {
            // 캡쳐 중이 아니면 = 화면 녹화가 끝났으면
            self.secureMode(enable: false)
        }
    }
    
    @objc func secureMode(enable: Bool) {
        // if let webView = self.webView {
        // if let webView = self.webView {
        //     let secureWebView = secureView(for: webView)
        //     secureWebView.isSecureTextEntry = enable
        // }

        // if let viewController = self.viewController {
           
        //     if let webView = viewController.view {
        //         let secureWebView = secureView(for: webView)
        //         secureWebView.isSecureTextEntry = enable
        //     }
        // }
        
        print("yoon: secureMode?")

        if let webView = self.webView {
            let secureWebView = secureView(for: webView)
            secureWebView.isSecureTextEntry = enable
        }

    }
    
    private func secureView(for view: UIView) -> UITextField {
        if let textField = objc_getAssociatedObject(view, &associatedObjectHandle) as? UITextField {
            return textField
        } else {
            let textField = UITextField()
            view.addSubview(textField)
            textField.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
            textField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            textField.layer.removeFromSuperlayer()
            view.layer.superlayer?.insertSublayer(textField.layer, at: 0)
            textField.layer.sublayers?.last?.addSublayer(view.layer)
            
            objc_setAssociatedObject(view, &associatedObjectHandle, textField, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            
            return textField
        }
    }
}
