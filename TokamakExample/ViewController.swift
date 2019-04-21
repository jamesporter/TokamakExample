import Tokamak
import TokamakUIKit

final class ViewController: TokamakViewController {
    override var node: AnyNode {
        return Counter.node(.init(countFrom: 1))
    }
}
