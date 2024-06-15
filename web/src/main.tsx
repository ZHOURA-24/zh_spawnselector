import React from 'react'
import ReactDOM from 'react-dom/client'
import App from './App.tsx'
import './index.css'
import { VisibilityProvider } from './providers/VisiblityProvider.tsx'
import { debugData } from './utils/debugData.ts'

const root = document.getElementById('root')

root!.style.backgroundImage = 'url("https://i.imgur.com/3pzRj9n.png")';
root!.style.backgroundSize = 'cover';
root!.style.backgroundRepeat = 'no-repeat';
root!.style.backgroundPosition = 'center';
root!.className = 'w-screen h-screen'

ReactDOM.createRoot(root!).render(
  <React.StrictMode>
    <VisibilityProvider>
      <App />
    </VisibilityProvider>
  </React.StrictMode>,
)

debugData([
    {
        action: 'setVisible',
        data: true
    }
])