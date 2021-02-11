import ApplicationController from './application_controller'
import Countdown from '../components/countdown.ts'

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
    this.countdown = new Countdown(this.element, this.startTime)
    this.countdown.startCountdown()
  }

  disconnect () {
    super.disconnect()
    this.countdown.stopCountdown()
  }
}
