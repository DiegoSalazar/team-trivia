require("@rails/ujs").start()
require("turbolinks").start()
// require("@rails/activestorage").start()
require("channels")
// require("controllers")
import "bootstrap"
import "controllers"

// Bootstraps alerts were not working. They weren't showing on their own.
// Had to add CSS in application.scss to force them to show
var $ = require("jquery")
$(document).on('click', '[data-dismiss="alert"]', () => {
  $('.alert').slideUp('fast')
})
