import UIKit

///The reason the StoreViewControllerDelegate is being dismissed
@objc public enum CompletionStatus : Int{
  ///Canced by the user.
  case Canceled
  /// The sail Succeeded
  case Success
  ///The sail failed for technical reasons.
  case Fail
}

///A delegate that adopts this protocol will get updates on changes in the StoreViewController object.
@objc public protocol StoreViewControllerDelegate {
  ///Updates the user when the view controller complete and must be dismissed.
  ///
  ///    - parameter viewController: the View Controller that has complete and must be dismissed.
  ///    - parameter status: the reason the view controller was dismissed.
  func complete( viewController: StoreViewController , status: CompletionStatus)
  
}






///StoreViewController displays the store UI for the particular Product you have initialise it with. The class, when displied to the user will take care of the sale and call the delegate method when it is done.
@objc public class StoreViewController : UIViewController{
  
  ///Recieves updates on changes in StoreViewController
  public var delegate : StoreViewControllerDelegate?
  
  
  @IBOutlet private var webview: UIWebView!
  @IBOutlet private var xBut: UIButton!
  
  //The product to be displayed
  private var product: Product?
  
  ///Create a new StoreViewController instance.
  ///
  ///   - parameter product: The product the StoreViewControllerDelegate will sell.
  ///   - parameter delegate: The delegate method that will be called with StoreViewController updates.
  
  public static func makeStoreViewController(product: Product, delegate: StoreViewControllerDelegate) -> StoreViewController{
    
    let storyboard = StoreViewController.getStoryboard(  bundle: Bundle(for: self.classForCoder()))
    
    let controller = storyboard.instantiateInitialViewController() as! StoreViewController
    controller.product = product
    controller.delegate = delegate
    
    return controller
  }
  
  //MARK: - lifecycle functions
  
  public override func viewDidLoad() {
    super.viewDidLoad()
    let request = URLRequest(url: product!.url)
    self.webview.loadRequest(request)
  }
  //MARK: - actions

  @IBAction func xPressed(_ sender: Any) {
    delegate!.complete(viewController: self, status: .Canceled)
  }
  
  
  //MARK: - private functions
  
  internal static func getStoryboard(bundle: Bundle) -> UIStoryboard{
    let finalBundle = getBundle(bundle: bundle)
    let storyboard = UIStoryboard(name: "Castor", bundle: finalBundle)
    
    return storyboard
    
  }
  internal static func getBundle(bundle: Bundle) -> Bundle{
    
    let bundleURL = bundle.url(forResource: "CastorSDK", withExtension: "bundle")
    let finalBundle = Bundle(url: bundleURL!)
    return finalBundle!
  }
}

extension StoreViewController : UIWebViewDelegate{

  public func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
    if request.url?.absoluteString.range(of: "3dcastor.com/completepurchase") != nil {
      delegate?.complete(viewController: self, status: .Success)
      return false
    }
    return true
  }
}
