import { useState } from 'react'
import { Card, DataProps } from './components/card'
import { useNuiEvent } from './hooks/useNuiEvent'
import { debugData } from './utils/debugData'
import { fetchNui } from './utils/fetchNui'

function App() {
  const [data, setData] = useState<{ [key: string]: DataProps } | undefined>(undefined)
  const [selected, setSelected] = useState<string | undefined>(undefined)
  const [disabled, setDisabled] = useState(false)

  useNuiEvent('setSpawns', setData)

  return (
    <main className="p-10 absolute h-screen right-0 flex flex-col font-inria bg-black/30">
      <div className="h-fit mb-4">
        <p className="font-semibold text-zh-100">SELECT LOCATION</p>
        <h1 className="text-2xl font-bold text-white">SPAWN SELECTOR</h1>
      </div>
      <div className="w-[300px] h-fit grid grid-cols-1 gap-4 overflow-y-scroll">
        {
          data && Object.entries(data).map(([key, value]) =>
            <Card
              key={key}
              {...value}
              active={(selected === key)}
              disabled={disabled}
              onClick={() => {
                if (selected === key) {
                  setSelected(undefined)
                  return fetchNui('spawn', key)
                }
                setSelected(key)
                setDisabled(true)
                fetchNui('setLocation', key).then(() => setDisabled(false))
              }}
            />
          )
        }
      </div>
    </main>
  )
}

export default App

const spawns = {
  last: {
    label: 'Last Location',
    description: 'Last Location Description',
  },
  harbor: {
    label: 'Harbor',
    description: 'Harbor Description',
    image: './images/harbour.png',
    icon: 'Sailboat'
  },
  airport: {
    label: 'Airport',
    description: 'Airport Description',
    image: './images/airport.png',
    icon: 'Plane'
  },
  cityhall: {
    label: 'City Hall',
    description: 'City Hall Description',
    image: './images/cityhall.png'
  },
  hospital: {
    label: 'Hospital',
    description: 'Hospital Description',
    image: './images/hospital.png'
  },
}

debugData([
  {
    action: 'setSpawns',
    data: spawns
  }
])