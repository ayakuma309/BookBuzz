import { Controller } from "@hotwired/stimulus"
import TomSelect from "tom-select"

// Connects to data-controller="select"
export default class extends Controller {
  connect() {
    // 初期化処理を書く
    const config = {};
    new TomSelect(this.element, config);
  }
}
