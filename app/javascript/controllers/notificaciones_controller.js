import { Controller } from 'stimulus'
// TODO, Parece que está deprecated, habría que reemplazarla.
import Noty from 'noty'
import 'noty/src/noty.scss'
import 'noty/src/themes/bootstrap-v4.scss'

export default class extends Controller {
  static values = { tipo: String, mensaje: String }

  // Detecta cada notificación en el layout y lanza una de Noty en su
  // lugar.
  connect () {
    new Noty({
      text: this.mensajeValue,
      type: this.tipo,
      theme: 'bootstrap-v4',
      layout: 'topCenter',
      progressBar: true,
      timeout: 5000,
    }).show()
  }

  // Convierte los tipos de notificación del sistema en los de
  // Noty/Bootstrap.
  get tipo() {
    switch (this.tipoValue) {
      case 'notice':
        return 'info'
      case 'success':
        return 'success'
      case 'error':
        return 'error'
      case 'alert':
        return 'warning'
      default:
        return 'info'
    }
  }
}
