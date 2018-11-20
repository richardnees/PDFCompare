import Foundation

infix operator =~

public func =~ (input: String, pattern: String) -> Bool {
    return Regex(pattern).test(input: input)
}

public class Regex {
    let internalExpression: NSRegularExpression
    let pattern: String
    
    public init(_ pattern: String) {
        self.pattern = pattern
        internalExpression = try! NSRegularExpression(pattern: pattern, options: .caseInsensitive)
    }
    
    public func test(input: String) -> Bool {
        let range = NSRange(location: 0, length: input.count)
        let matches = internalExpression.matches(in: input, options: [], range: range)
        return matches.count > 0
    }
}
