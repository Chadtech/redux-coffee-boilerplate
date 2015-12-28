{ createStore, compose }  = require 'redux'
React                     = require 'react/addons'
el                        = React.createElement
{ Provider }              = require 'react-redux'
Root                      = require './Root'
Reducers                  = require '../reducers/root'

# DOM
{div, ul, form, input, button} = React.DOM

makeStore = () ->
  if __DEV__
    { devTools, persistState } = require 'redux-devtools'
    composedStore = compose(
      devTools(),
      persistState(window.location.href.match(/[?&]debug_session=([^&]+)\b/)),
      createStore
    )
    composedStore Reducers
  else
    createStore Reducers

makeDev = (store) ->
  if __DEV__
    { DevTools, DebugPanel, LogMonitor } = require 'redux-devtools/lib/react'
    el DebugPanel, {top:true, right:true, bottom:true, key: 'devtools'},
      el DevTools, {store, monitor: LogMonitor}

module.exports = MountApp = (mountPoint) ->
  store = makeStore()
  view = 
    div null,
      el Provider, store: store,
        -> el Root
        

  mounted = React.render view, mountPoint
  {store, mounted}