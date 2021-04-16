const path = require('path')
const { ProvidePlugin } = require('webpack')
const { environment } = require('@rails/webpacker')
const typescript =  require('./loaders/typescript')

environment.loaders.prepend('typescript', typescript)

environment.plugins.prepend('Provide',
  new ProvidePlugin({
    $: 'jquery/src/jquery',
    datetimepicker: 'bootstrap4-datetimepicker/src/js/datetimepicker'
  })
)

environment.config.resolve.alias = {
  // Force all modules to use the same jquery version
  'jquery': 'jquery/src/jquery'
}

module.exports = environment
