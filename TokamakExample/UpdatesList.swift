import Tokamak

let basicStyle = Style(Edges.equal(to: .safeArea, inset: 20))

struct UpdatesList: LeafComponent {
    struct Props: Equatable {
        let title: String
    }
    
    static func render(props: Props, hooks: Hooks) -> AnyNode {
        let state = hooks.state(APIData.notAsked)
        hooks.effect {
            API.refreshData { newState in
                state.set(newState)
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
            return Label.node(.init(
                basicStyle,
                alignment: .center,
                text: "\(data.count) items loaded"
                ))
        }
    }
}
