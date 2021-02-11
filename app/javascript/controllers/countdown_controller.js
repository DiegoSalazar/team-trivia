import ApplicationController from './application_controller'

/* This is the custom StimulusReflex controller for the Countdown Reflex.
 * Learn more at: https://docs.stimulusreflex.com
 */
export default class extends ApplicationController {
  /*
   * Regular Stimulus lifecycle methods
   * Learn more at: https://stimulusjs.org/reference/lifecycle-callbacks
   *
   * If you intend to use this controller as a regular stimulus controller as well,
   * make sure any Stimulus lifecycle methods overridden in ApplicationController call super.
   *
   * Important:
   * By default, StimulusReflex overrides the -connect- method so make sure you
   * call super if you intend to do anything else when this controller connects.
  */

  connect () {
    super.connect()
    const { startTime, endTime } = this.element.dataset

    this.startTime = new Date(Date.parse(startTime))
    this.endTime = new Date(Date.parse(endTime))
    console.log(`Trivia starts on ${this.startTime}`) // debug

    this.startCountdown()
  }

  startCountdown () {
    this.updateClock()
    return setInterval(() => this.updateClock(), 1000)
  }

  updateClock () {
    const now = new Date().getTime()
    const { days, hours, minutes, seconds } = this.calcCountdown(now)

    this.element.innerHTML = this.clock(days, hours, minutes, seconds)
  }

  clock (days, hours, minutes, seconds) {
    const parts = []
    if (days > 0) parts.push(`<span>${days}</span><small>d</small>`)
    if (hours > 0) parts.push(`<span>${hours}</span><small>h</small>`)
    if (minutes > 0) parts.push(`<span>${minutes}</span><small>m</small>`)
    if (seconds > 0) parts.push(`<span>${seconds}</span><small>s</small>`)
    return parts.join(' ')
  }

  calcCountdown (to) {
    const diffMs = this.startTime.getTime() - to
    const days = Math.floor(diffMs / (1000 * 60 * 60 * 24))
    const hours = Math.floor((diffMs % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60))
    const minutes = Math.floor((diffMs % (1000 * 60 * 60)) / (1000 * 60))
    const seconds = Math.floor((diffMs % (1000 * 60)) / 1000)

    return { days, hours, minutes, seconds }
  }
}
