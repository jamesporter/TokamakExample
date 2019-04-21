import Tokamak

struct Item: Equatable {
    let name: String
}

private struct Cells: CellProvider {
    static func cell(
        props: Null,
        item: Item,
        path: CellPath
        ) -> AnyNode {
        return Label.node(.init(
            Style(
                [CenterY.equal(to: .parent),
                 Height.equal(to: 44),
                 Leading.equal(to: .safeArea, constant: 20)]
            ),
            text: "\(item.name)"
            ))
    }
    
    typealias Props = Null
    
    typealias Model = Item
}

struct List: PureLeafComponent {
    struct Props: Equatable {
        let model: [Item]
        let onSelect: Handler<CellPath>
    }
    
    static func render(props: Props) -> AnyNode {
        return ListView<Cells>.node(.init(
            Style([
                Edges.equal(to: .parent),
                ]),
            model: [props.model],
            onSelect: props.onSelect
            ))
    }
}
