import UIKit

private var AssociatedObjectHandle = 0


@objc(preventScreen)
class preventScreen : CDVPlugin {

    override func pluginInitialize() {

        NotificationCenter.default.addObserver(
            self, 
            selector: #selector(captureAction), 
            name: UIScreen.capturedDidChangeNotification, 
            object: nil
        )

    }

    // 캡쳐시 실행되는 액션 메소드
    @objc func captureAction() {
        if UIScreen.main.isCaptured {
        // 캡쳐 중이면 = 화면 녹화 중이면
        view.secureMode(enable: true)
        } else {
        // 캡쳐 중이 아니면 = 화면 녹화가 끝났으면
        view.secureMode(enable: false)
        }

    }


}



extension UIView {
  // 트릭을 위한 임의의 UITextField
  private var secureTextField: UITextField {
    if let textField = objc_getAssociatedObject(self, &AssociatedObjectHandle) as? UITextField {
      // 추가된 TextField가 있다면 해당 객체 반환
      return textField
    } else {
      // 추가된 TextField가 없다면 생성해서
      let textField = UITextField()
      // 캡쳐하려는 UIView에 추가하고
      addSubview(textField)
      textField.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
      textField.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
      textField.layer.removeFromSuperlayer()
      // 캡쳐하려는 UIView의 Layer를 TextField의 Layer 사이에 끼워 넣고
      layer.superlayer?.insertSublayer(textField.layer, at: 0)
      textField.layer.sublayers?.last?.addSublayer(layer)
      // 마지막으로 set 해서 return
      objc_setAssociatedObject(self, &AssociatedObjectHandle, textField, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
      return textField
    }
  }

  // 트릭의 활성화를 제어하는 메소드
  func secureMode(enable: Bool) {
    secureTextField.isSecureTextEntry = enable
  }
}