# Team Trivia App

Demo: https://team-trivia.herokuapp.com/

A collaborative and accessible, real-time trivia game playing app. Inspired by Quarantrivia.

Based on Rails and:
 - [StimulusReflex](https://docs.stimulusreflex.com/)
 - [CableReady](https://cableready.stimulusreflex.com/)

## Features
 - Players can create Trivia to start and end at a specified date and time
 - Players can join Teams or play by themselves
 - Only the creator can edit their Trivia and see all Questions
 - Every Player can submit questions to an upcoming Trivia
 - Players are redirected to the Play page when a Trivia starts
 - Players in Teams will see a chat room with their Teammates in the Play page
 - Players can submit Guesses to Questions
 - Guesses appear in the Team chat room
 - Players can vote on Guesses
 - Guesses with the highest votes will be counted at the end
 - Players will be redirected to a Live Reveal page when a Trivia ends
 - The creator of the Trivia can Reveal questions and Answers one by one
 - Winners are revealed after all Questions/Answers are revealed

## Local Setup
```bash
# Set local user creds
export TEAM_TRIVIA_USER_EM='test@mail.com'
export TEAM_TRIVIA_USER_PW='password123'

bundle && npm i
rake db:setup
rails server
```

Run `rake -T | grep triv` for trivia seed data creation tasks.
