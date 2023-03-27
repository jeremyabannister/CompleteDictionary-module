//
//  CompleteDictionary.swift
//  
//
//  Created by Jeremy Bannister on 3/27/23.
//

///
@_exported import FoundationToolkit


/// You use CompleteDictionary with an enum as the Key, and any type you want as the value. The point of CompleteDictionary is that it guarantees that there is a value for every possible key, and therefore it returns non-optional values when subscripted.
public struct CompleteDictionary
    <Key: CaseIterable & Hashable,
     Value>:
        ExpressionErgonomic {
    
    ///
    private var dict: [Key: Value]
    
    ///
    public init (initialValueGenerator: (Key)->Value) {
        self.dict = Key.allCases.makeDictionary(initialValueGenerator)
    }
    
    ///
    public init? (_ dict: [Key: Value]) {
        let dictContainsAllKeys = Key.allCases.allSatisfy { dict.keys.contains($0) }
        guard dictContainsAllKeys else { return nil }
        self.dict = dict
    }
}

///
extension CompleteDictionary: ExpressibleByDictionaryLiteral {
    
    ///
    public init
        (dictionaryLiteral elements: (Key, Value)...) {
        
        ///
        self.init(
            elements
                .makeDictionary(key: \.0, value: \.1)
        )!
    }
}

///
extension CompleteDictionary {
    
    ///
    public subscript (key: Key) -> Value {
        get { dict[key]! }
        set { dict[key] = newValue }
    }
    
    ///
    public var keys: Dictionary<Key, Value>.Keys {
        dict.keys
    }
    
    ///
    public var values: Dictionary<Key, Value>.Values {
        dict.values
    }
    
    ///
    public func map
        <Element>
        (_ transform: ((key: Key, value: Value))throws->Element)
    rethrows -> [Element] {
        
        ///
        try dict.map(transform)
    }
    
    ///
    public func forEach
        (_ body: ((key: Key, value: Value))throws->())
    rethrows {
        
        ///
        try dict.forEach(body)
    }
    
    ///
    public func reduce
        <Result>
        (into initialResult: Result,
         _ updateAccumulatingResult: (inout Result, (key: Key, value: Value))throws->())
    rethrows -> Result {
        
        ///
        try dict.reduce(into: initialResult, updateAccumulatingResult)
    }
}

///
extension CompleteDictionary: Codable
    where Key: Codable,
          Value: Codable {
    
    ///
    public func encode (to encoder: Encoder) throws {
        try dict.encode(to: encoder)
    }
    
    ///
    public init (from decoder: Decoder) throws {
        self.dict = try .init(from: decoder)
    }
}

///
extension CompleteDictionary: Hashable
    where Value: Hashable {
    
    ///
    public func hash (into hasher: inout Hasher) {
        hasher.combine(dict)
    }
}

///
extension CompleteDictionary: Equatable
    where Value: Equatable {
    
    ///
    public static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.dict == rhs.dict
    }
}
