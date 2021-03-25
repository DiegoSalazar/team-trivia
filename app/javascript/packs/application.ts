require('@rails/ujs').start()
require('turbolinks').start()
// require('@rails/activestorage').start()
require('channels')
// require('controllers')
import 'bootstrap'
import 'controllers'

// Bootstraps alerts were not working. They weren't showing on their own.
// Had to add CSS in application.scss to force them to show
document.addEventListener('click', (e) => {
  const el = <Element>e.target
  if (!el.matches("[data-dismiss='alert']")) return

  document.querySelector('.alert').remove()
})
