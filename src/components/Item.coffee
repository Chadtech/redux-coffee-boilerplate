React = require 'react/addons'

# DOM
{ li } = React.DOM

module.exports = Item = React.createClass
  render: ->
    {index, id, text, done, onSetDone} = @props

    props =
      className: 'item'
      key: id
      style:
        textDecoration: if done then 'line-through' else 'none'
      onClick: ->
        onSetDone index, not done
    
    li props, text
