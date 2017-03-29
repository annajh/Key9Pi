import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        if let filepath = Bundle.main.path(forResource: "comm-dict", ofType: "txt") {
            
            var allWords: [String:UInt64] = [:]
            func getWordList(node: Node) {
                if node.children.count == 0 {
                    return
                }
                for word in node.wordList {
                    allWords[word.key] = word.value
                }
                for child in node.children {
                    getWordList(node: child.value)
                }
            }
            
            //writing
            do {
                // TODO: get all words from trie and write to filepath
                // ALSO, THERE'S GOTTA BE A BETTER WAY 😡
                for word in allWords {
                    try word.key.write(toFile: filepath, atomically: false, encoding: String.Encoding.unicode)
                }
            }
            catch {
                print("contents could not be stored")
            }
        }

    }
    
    
}

