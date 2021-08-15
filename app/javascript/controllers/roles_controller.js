import { Controller } from "stimulus"
import Rails from "@rails/ujs";

export default class extends Controller {
  static values = { url: String }
  static targets = ['checkbox']

  update() {
    var datos = new FormData
    // Armamos el payload como lo espera rails, según el name del input (e.g.
    // roles[clientes] = 'true').
    datos.append(
      this.checkboxTarget.name, this.checkboxTarget.checked
    )

    Rails.ajax({
      type: 'patch',
      dataType: 'json',
      url: this.urlValue,
      data: datos
    })
  }
}
