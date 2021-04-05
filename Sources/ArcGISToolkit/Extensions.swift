// Copyright 2017 Esri.

// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
// http://www.apache.org/licenses/LICENSE-2.0

// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import Foundation
import UIKit

extension UIApplication {
    func topViewController(_ controller: UIViewController? = UIApplication.shared.windows.first(where: { $0.isKeyWindow })?.rootViewController) -> UIViewController? {
        if let navigationController = controller as? UINavigationController {
            return topViewController(navigationController.visibleViewController)
        }
        if let tabController = controller as? UITabBarController {
            if let selected = tabController.selectedViewController {
                return topViewController(selected)
            }
        }
        if let presented = controller?.presentedViewController {
            return topViewController(presented)
        }
        return controller
    }
}

#if !SWIFT_PACKAGE
// This is a workaround for installing the toolkit using the project file or cocoapods.
extension Bundle {
    static var module: Bundle {
        var validModule: Bundle
        // Toolkit was installed using project file.
        if let module = Bundle(identifier: "com.esri.ArcGISToolkit") {
            validModule = module
        } else { // Toolkit was installed using cocoapods.
            validModule = Bundle(identifier: "org.cocoapods.ArcGISToolkit")!
        }
        return validModule
    }
}
#endif
