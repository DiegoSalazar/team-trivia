require('@rails/ujs').start()
require('turbolinks').start()
// require('@rails/activestorage').start()
require('channels')
require('controllers')
const $ = require('jquery')
require('bootstrap')
require('bootstrap4-datetimepicker')

const isChrome = /chrome/i.test(navigator.userAgent)

document.addEventListener('load', onLoad)
document.addEventListener('turbolinks:load', onLoad)

function onLoad () {
  if (!isChrome) {
    // Chrome has its own datetime picker built in
    $('[type^="datetime"]').datetimepicker()
  }
}

// Bootstraps alerts were not working. They weren't showing on their own.
// Had to add CSS in application.scss to force them to show
document.addEventListener('click', (e) => {
  const el = <Element>e.target
  if (!el.matches("[data-dismiss='alert']")) return

  document.querySelector('.alert').remove()
})
