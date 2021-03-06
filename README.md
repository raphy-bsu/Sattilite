# Sattilite

Data storage and handler application for univeristy satellite

## How to install

* rbenv install 2.2.2
* git pull https://github.com/OrelSokolov/Sattilite
* git submodule init
* git submodule update
* cd Sattilite
* bundle

## How to deploy

````
git push heroku master
```

## Authors

Inspired by [Evgenij Krivosheev](https://github.com/Evgeneus). Coded by [Oleg Orlov](https://github.com/OrelSokolov)

## How to contribute

* Get an issue from maintainer or create a new one
* Create branch `<type><issue_number>_<issue_summary>`
  * types: `f` - feature, `b` - bug, `t` - test
  * example: f1_fix_something
* Your commit  should be like "#1 - Short and informative message "
* `git push origin f1_fix_something`
* Convert issue to pull request `hub pull-request -i 1` [Read more](https://github.com/github/hub)
* Wait for review :)

## How to use

* To emulate satellite work run seed script:
`ruby script/seed.rb [host]`
