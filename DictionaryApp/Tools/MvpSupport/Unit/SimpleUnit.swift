import Foundation

public enum SimpleUnit<D, H, E>: UnitType {
    public typealias Event = E
    public typealias Delegate = D
    public typealias Handler = H
}
