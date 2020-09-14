import React, { useState } from 'react'

import AceEditor from "react-ace";
import defaultLiquid from './defaultLiquid';
import RenderedTemplate from './RenderedTemplate'

import "ace-builds/src-noconflict/mode-liquid";
import "ace-builds/src-noconflict/theme-monokai";

export default () => {
  const [code, setCode] = useState(defaultLiquid)
  const [data, setData] = useState({ first_name: 'Obama', guid: 'aaa-bbb-ccc' })
  const [html, setHtml] = useState('')

  function upsertData(payload) {
    setData(d => { return { ...d, ...payload }})
  }

  return <div className='container-fluid'>
    <div className='row'>
      <div className='col-md-3'>
        <h2>Member Data</h2>
        { Object.entries(data).map(([key, value]) => {
          return <div className="form-group">
          <label htmlFor="subject">{key}</label>
          <input
            type="text"
            className="form-control"
            id={key}
            placeholder="Enter content"
            value={value}
            onChange={e => upsertData({ [key]: e.target.value })}
            />
          </div>
        })}
      </div>
      <div className='col-md-4'>
        <h2>Liquid Input</h2>
        <div className="form-group">
          <AceEditor
            mode="liquid"
            theme="monokai"
            onChange={v => setCode(v)}
            name="code"
            editorProps={{ $blockScrolling: true, $wrap: true }}
            value={code}
            width='100%'
          />
        </div>
      </div>
      <div className='col-md-5'>
        <h2>Rendered Output</h2>
        <RenderedTemplate template={code} data={data} />
      </div>
    </div>
  </div>
}