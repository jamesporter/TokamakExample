import Tokamak

private struct Cells: CellProvider {
    static func cell(
        props: Null,
        item: Update,
        path: CellPath
        ) -> AnyNode {
        return Label.node(.init(
            Style(
                [CenterY.equal(to: .parent),
                 Height.equal(to: 44),
                 Leading.equal(to: .safeArea, constant: 20),
                Trailing.equal(to: .safeArea, constant: 20)
                 ]
            ),
            text: "\(item.title)"
            ))
    }
    
    typealias Props = Null
    
    typealias Model = Update
}

struct List: PureLeafComponent {
    struct Props: Equatable {
        let model: [Update]
        let onSelect: Handler<CellPath>
    }
    
    static func render(props: Props) -> AnyNode {
        return ListView<Cells>.node(.init(
            Style(
                [CenterY.equal(to: .parent),
                 Height.equal(to: 240)]
            ),
            model: [props.model],
            onSelect: props.onSelect
            ))
    }
}
