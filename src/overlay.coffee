
React = require 'react'

div = React.createFactory 'div'

mixinLayered = require './mixin-layered'

Transition = React.createFactory (require './transition')

T = React.PropTypes

module.exports = React.createClass
  displayName: 'lite-overlay'
  mixins: [mixinLayered]

  propTypes:
    show: T.bool.isRequired
    name: T.string

  getDefaultProps: ->
    name: 'default'

  renderLayer: (afterTransition) ->
    Transition transitionName: 'fade', enterTimeout: 200, leaveTimeout: 350,
      if @props.show and afterTransition
        div className: "lite-overlay is-for-#{@props.name}",
          @props.children

  render: ->
    div()
