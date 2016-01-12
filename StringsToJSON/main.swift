//
//  main.swift
//  StringsToJSON
//
//  Created by Warren Burton on 12/01/2016.
//  Copyright © 2016 Digital-Dirtbag. All rights reserved.
//

import Foundation

let arguments = Process.arguments

if arguments.count < 2 {
    print("usage: StringsToJSON <file> [output-file]")
}
else {
    
    let file = arguments[1]
    
    let url = NSURL(fileURLWithPath: file)
    
    var outputurl = url.URLByAppendingPathExtension("json")
    
    if arguments.count > 2 {
        outputurl = NSURL(fileURLWithPath: arguments[2])
    }
    
    print("converting \(file) , output path is \(outputurl.path)")
    
    let dictionary = NSDictionary(contentsOfURL:url)
    
    if let dictionary = dictionary {
        do {
            let json = try NSJSONSerialization.dataWithJSONObject(dictionary, options:NSJSONWritingOptions.PrettyPrinted)
            json.writeToURL(outputurl, atomically: true)
        }
        catch {
            print("unable to convert to JSON \(error)")
        }
    } else {
        print("unable to load \(file) as NSDictionary, are you sure its a plist or strings file?")
    }
    
}
