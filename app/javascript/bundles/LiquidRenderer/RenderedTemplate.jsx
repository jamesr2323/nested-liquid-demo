import axios from 'axios'
import React, { useState, useRef, useEffect } from 'react'
import _ from 'lodash'

export default ({ template, data }) => {
  const [renderedTemplate, setRenderedTemplate] = useState('')
  function getRenderedTemplate(template, data) {
    axios.post('/render', { template, data })
    .then(({ data: { renderedTemplate } }) => setRenderedTemplate(renderedTemplate))
  }
  const dGetRenderedTemplate = useRef(_.debounce(getRenderedTemplate, 500))

  useEffect(() => {
    dGetRenderedTemplate.current(template, data)
  }, [template, data])

  return <div dangerouslySetInnerHTML={{ __html: renderedTemplate }} />
}
