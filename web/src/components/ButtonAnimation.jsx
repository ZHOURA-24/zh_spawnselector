import React from 'react'
import '../button.css'
import { sendNui } from '../utils/sendNui'

function ButtonAnimation({ label, name }) {
    const handleClick = (name) => {
        sendNui('setLocation', name)
    }
    return (
        <div className="pl-2 pr-2 w-64" onClick={() => handleClick(name)}>
            <div className="btn btn-animation text-cyan-300">
                <span className='block absolute w-full h-full'>{label}</span>
            </div>
        </div>
    )
}

export default ButtonAnimation