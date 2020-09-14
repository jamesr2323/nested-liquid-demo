// Run this example by adding <%= javascript_pack_tag 'hello_react' %> to the head of your layout file,
// like app/views/layouts/application.html.erb. All it does is render <div>Hello React</div> at the bottom
// of the page.

import React from 'react'
import ReactDOM from 'react-dom'
import LiquidRenderer from '../bundles/LiquidRenderer/LiquidRenderer'
import axios from 'axios'

const csrfToken = document.querySelector("meta[name=csrf-token]").content
 axios.defaults.headers.common['X-CSRF-Token'] = csrfToken

document.addEventListener('DOMContentLoaded', () => {
  ReactDOM.render(
    <LiquidRenderer name="React" />,
    document.body.appendChild(document.createElement('div')),
  )
})
