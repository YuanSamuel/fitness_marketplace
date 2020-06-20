import UIKit
import Flutter
import SquareInAppPaymentsSDK

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}

class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_: UIApplication,
                     didFinishLaunchingWithOptions _:
                     [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Set your Square Application ID
        SQIPInAppPaymentsSDK.squareApplicationID = "***REMOVED***"
        return true
    }
}

extension<#YourViewController#>: UINavigationControllerDelegate {
   func navigationControllerSupportedInterfaceOrientations(
       _: UINavigationController
   ) -> UIInterfaceOrientationMask {
       return .portrait
   }
}


extension <#YourViewController#> {
    func makeCardEntryViewController() -> SQIPCardEntryViewController {
        let cardEntry = SQIPCardEntryViewController(theme: theme)
        cardEntry.collectPostalCode = false
        cardEntry.delegate = self
        return cardEntry
    }
}
extension<#YourViewController#>: SQIPCardEntryViewControllerDelegate {
    func cardEntryViewController(
        _: SQIPCardEntryViewController,
        didCompleteWith _: SQIPCardEntryCompletionStatus
    )

    {
        dismiss(animated: true, completion: nil)
    }

    func cardEntryViewController(
        _: SQIPCardEntryViewController,
        didObtain _: SQIPCardDetails,
        completionHandler _: @escaping (Error?) -> Void
    )

    {
        if let chargeError = chargeError {
                            completionHandler(chargeError)
                        }
                        else {
                            completionHandler(nil)
                        }
                    }


    func completionHandler(nil)
    }




