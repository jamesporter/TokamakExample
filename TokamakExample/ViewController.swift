import Tokamak
import TokamakUIKit

final class ViewController: TokamakViewController {
    override var node: AnyNode {
        return UpdatesList.node(UpdatesList.Props(title: "Updates"))
    }
}
