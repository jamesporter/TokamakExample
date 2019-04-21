import Tokamak

let basicStyle = Style(Edges.equal(to: .safeArea, inset: 20))

struct UpdatesList: LeafComponent {
    struct Props: Equatable {
        static func == (lhs: UpdatesList.Props, rhs: UpdatesList.Props) -> Bool {
            return lhs.uuid == rhs.uuid
        }
        
        let uuid = UUID().uuidString
        let setTitleFor: (APIData) -> Void
        let showDetail: (Update) -> Void
    }
    
    static func render(props: Props, hooks: Hooks) -> AnyNode {
        let state = hooks.state(APIData.notAsked)
        hooks.effect {
            API.refreshData { newState in
                state.set(newState)
                props.setTitleFor(newState)
            }
        }
        
        switch state.value {
        case .notAsked:
            return Label.node(.init(
                basicStyle,
                alignment: .center,
                text: "Not Asked"
                ))
        case .error(let message):
            return Label.node(.init(
                basicStyle,
                alignment: .center,
                text: message
                ))
        case .loading:
            return Label.node(.init(
                basicStyle,
                alignment: .center,
                text: "Loading"
                ))
        case .loaded(let data):
            return StackView.node(.init(
                Edges.equal(to: .parent),
                axis: .vertical,
                distribution: .fillEqually), [ List.node(List.Props(model: data, onSelect: Handler { idx in props.showDetail(data[idx.item]) }
            ))
            ])
        }
    }
}
