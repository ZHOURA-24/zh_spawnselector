import { debugData } from './utils/debugData';
import ButtonAnimation from './components/ButtonAnimation';
import { useState } from 'react';
import useNuiEvent from './utils/useNuiEvent';
import { sendNui } from './utils/sendNui';

debugData([
  {
    action: 'setVisible',
    data: true,
  }
])

function App() {
  const [spawns, setSpawns] = useState({})

  useNuiEvent('setSpawns', (data) => {
    setSpawns(data)
  })

  debugData([
    {
      action: 'setSpawns',
      data: {
        last: {
          label: 'Last Location'
        },
        airport: {
          label: 'Airport'
        },
      },
    }
  ])

  return (
    <>
      <div className='bg'>
        <h1 className='text-center pt-10 pb-0 text-cyan-400 text-2xl'>Spawn Selector</h1>
        <div className='flex justify-center pt-10'>
          {Object.keys(spawns).map((key, index) => {
            return <ButtonAnimation label={spawns[key].label} name={key} key={index} />
          })}
        </div>
        <div className='flex justify-center pt-10'>
          <button className='bg-cyan-400  p-1 hover:bg-cyan-600 hover:p-2 ' style={{
            borderRadius: '1vh'
          }} onClick={() => sendNui('spawn')} >Spawn</button>
        </div>
      </div>
    </>
  )
}

export default App;
