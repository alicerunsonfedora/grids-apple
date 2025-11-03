import Adwaita
import Foundation

struct Stepper<T: Numeric & Comparable>: View {
    typealias StepperCallback = (T) -> Void
    @Binding var value: T
    var min: T
    var max: T
    var stride: T

    private var callbackOnly: Bool = false
    private var onDecrement: StepperCallback?
    private var onIncrement: StepperCallback?

    var view: Body {
        HStack(spacing: 4) {
            Text("\(value)")
                .padding(4, [.trailing])
            HStack {
                Button(icon: .custom(name: "minus")) {
                    if !callbackOnly {
                        value = value - stride
                    }
                    onDecrement?(value)
                }
                .insensitive(value <= min)

                Button(icon: .custom(name: "plus")) {
                    if !callbackOnly {
                        value = value + stride
                    }
                    onIncrement?(value)
                }
                .insensitive(value >= max)
            }
            .style("linked")
        }
        .numeric()
        .raised()
    }

    func callbackPerformsEditing(_ active: Bool = true) -> Self {
        var newSelf = self
        newSelf.callbackOnly = active
        return newSelf
    }

    func onIncrement(_ callback: @escaping StepperCallback) -> Self {
        var newSelf = self
        newSelf.onIncrement = callback
        return newSelf
    }

    func onDecrement(_ callback: @escaping StepperCallback) -> Self {
        var newSelf = self
        newSelf.onDecrement = callback
        return newSelf
    }
}

extension Stepper where T == Int {
    init(value: Binding<T>, min: Int = .min, max: Int = .max, stride: Int = 1) {
        self._value = value
        self.min = min
        self.max = max
        self.stride = stride
    }
}
