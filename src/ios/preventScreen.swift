import UIKit

@objc(preventScreen)
class preventScreen: CDVPlugin {
    
    private var associatedObjectHandle = 0
    
    override func pluginInitialize() {

        print("yoon: preventScreen real?")


        // 캡쳐 감지용 노티피케이션 센터 추가
        if let viewController = self.viewController {

            NotificationCenter.default.addObserver(
                self,
                selector: #selector(captureAction),
                name: UIScreen.capturedDidChangeNotification,
                object: nil
            )

        }

    }

    @objc(enable:)
    func enable(command: CDVInvokedUrlCommand) {

        guard let enable = command.arguments[0] as? Bool else {
            return
        }
        
         if let viewController = self.viewController {
            let view = viewController.view
            self.secureMode(enable: enable, for: view!)            

            // view.addSubview(UILabel());
        }
    }

    private func secureMode(enable: Bool, for view: UIView) {

        print("yoon: secureMode?")

        if let secureTextField = objc_getAssociatedObject(view, &associatedObjectHandle) as? UITextField {
            secureTextField.isSecureTextEntry = enable
        } else {
            let secureTextField = UITextField()
            view.addSubview(secureTextField)
            
            // Auto Layout 설정
            secureTextField.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                secureTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                secureTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            ])            
          
            // 메인 스레드에서 레이어 추가
            DispatchQueue.main.async {
                view.layer.addSublayer(secureTextField.layer)
            }
            
            objc_setAssociatedObject(view, &associatedObjectHandle, secureTextField, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }

    @objc private func captureAction() {

        print("yoon: captureAction?");

        let isCaptured = UIScreen.main.isCaptured
        
        if let viewController = self.viewController {
            let view = viewController.view
            self.secureMode(enable: isCaptured, for: view!)
        }
    }

    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
   
}
