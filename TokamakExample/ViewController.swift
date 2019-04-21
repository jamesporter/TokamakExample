import Tokamak
import TokamakUIKit

final class ViewController: TokamakViewController {
    var update: Update? = nil
    
    override var node: AnyNode {
        return UpdatesList.node(UpdatesList.Props(setTitleFor: setTitleFor) { update in
            self.update = update
            self.performSegue(withIdentifier: "showDetail", sender: self)
        })
    }
    
    func setTitleFor(_ state: APIData) {
        switch(state) {
        case .loading:
            title = "Loading"
        case .loaded(let data):
            title = "\(data.count) Updates"
        case .error:
            title = "Error"
        case .notAsked:
            title = ""
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let dvc = segue.destination as? DetailViewController {
                dvc.update = self.update
            }
        }
    }
}
