//
//  Configurations
//
//  Created by Koen Punt on 15-01-16.
//  Copyright © 2016 Fetch!. All rights reserved.
//

import Foundation

open class Configuration: NSObject {
  
  let ConfigurationPlistKey = "ConfigurationFileName"
  let CurrentConfigurationPlistKey = "Configuration"
  
  open fileprivate(set) var configurationName: String?
  fileprivate var dictionary: NSDictionary!
  
  open static func defaultConfiguration() -> Configuration {
    struct Static {
      static var instance = Configuration()
    }
    return Static.instance
  }
  
  fileprivate override init() {
    super.init()
    
    let bundle = Bundle.main
    
    self.configurationName = bundle.infoDictionary![CurrentConfigurationPlistKey] as? String
    
    guard self.configurationName != nil else {
      fatalError("No Configuration property found in plist")
    }
    
    let plistName = bundle.infoDictionary![self.ConfigurationPlistKey] as! String
    let plistPath = bundle.path(forResource: plistName, ofType: "plist")
    let dictionary = NSDictionary(contentsOfFile: plistPath!)
    
    self.dictionary = dictionary?.value(forKey: self.configurationName!) as! NSDictionary
  }
  
  open subscript(key: String) -> AnyObject? {
    get {
      return self.dictionary.value(forKey: key) as AnyObject?
    }
  }
  
}
