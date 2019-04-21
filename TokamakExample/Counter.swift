import Tokamak

struct Counter: LeafComponent {
    struct Props: Equatable {
        let countFrom: Int
    }
    
    static func render(props: Props, hooks: Hooks) -> AnyNode {
        let count = hooks.state(props.countFrom)
        let delta = hooks.state(1)
        
        return StackView.node(.init(
            Edges.equal(to: .parent),
            axis: .vertical,
            distribution: .fillEqually), [
                Button.node(Button.Props(
                    onPress: Handler { count.set { $0 + delta.value } },
                    text: "Increment"
                )),
                Button.node(Button.Props(
                    onPress: Handler { count.set { $0 - delta.value } },
                    text: "Decrement"
                )),
                Button.node(Button.Props(
                    onPress: Handler { delta.set { $0 + 1 } },
                    text: "Change Delta (\(delta.value))"
                )),
                Label.node(.init(alignment: .center, text: "\(count.value)")),
                List.node(List.Props(model: [Item(name: "yes")], onSelect: Handler {
                    print($0.item)
                }))
            ])
    }
}
