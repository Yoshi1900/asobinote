

require("dotenv").config();

const { environment } = require('@rails/webpacker')
const webpack = require('webpack')

// bootstrap,星レビュー機能時に変更
environment.plugins.prepend(
  'Provide',
  new webpack.ProvidePlugin({
    $: 'jquery/src/jquery',
    jQuery: 'jquery/src/jquery',
    jquery: 'jquery/src/jquery',
    Popper: 'popper.js'
  })
)

module.exports = environment