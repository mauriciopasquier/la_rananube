const { environment } = require('@rails/webpacker')
const webpack = require('webpack')

// Importar automáticamente estos módulos cuando otro módulo (i.e. bootstrap)
// los trate de usar.
environment.plugins.append('Provide', new webpack.ProvidePlugin({
  $: 'jquery',
  jQuery: 'jquery',
  Popper: ['popper.js', 'default']
}))

module.exports = environment
