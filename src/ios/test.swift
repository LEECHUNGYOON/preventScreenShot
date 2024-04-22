import UIKit

class ViewController: UIViewController {
  // 예시 콘텐츠
  private lazy var label = {
    let label = UILabel()
    label.text = "캡쳐 보호가 필요한 콘텐츠"
    return label
  }()

  override func viewDidLoad() {
    super.viewDidLoad()

    // 캡쳐 감지용 노티피케이션 센터 추가
    NotificationCenter.default.addObserver(
      self,
      selector: #selector(captureAction),
      name: UIScreen.capturedDidChangeNotification,
      object: nil
    )

    // 예시 콘텐츠 추가
    view.addSubview(label)
    label.translatesAutoresizingMaskIntoConstraints = false
    label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    label.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
  }

  // 캡쳐시 실행되는 액션 메소드
  @objc private func captureAction() {
    if UIScreen.main.isCaptured {
      // 캡쳐 중이면 = 화면 녹화 중이면
      view.secureMode(enable: true)
    } else {
      // 캡쳐 중이 아니면 = 화면 녹화가 끝났으면
      view.secureMode(enable: false)
    }
  }


  
}