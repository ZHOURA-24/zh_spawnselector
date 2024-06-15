Config = Config or {}

Config.Default = 'harbour'

Config.spawns = {
    ['harbour'] = { -- Default spawn
        label  = 'Harbour',
        description = 'Harbour Location',
        coords = vec4(-746.5240, -1286.9004, 18.1261, 229.9520),
        point  = vec4(-726.5360, -1303.2379, 5.1019, 50.4984),
        image = './images/harbour.png',
        icon = 'Sailboat'
    },
    ['airport'] = {
        label  = 'Airport',
        description = 'Airport Location',
        coords = vec4(-1019.8279, -2701.0479, 32.5290, 154.0629),
        point  = vec4(-1037.7335, -2737.2827, 20.1693, 333.3880),
        image = './images/airport.png',
        icon = 'Plane'
    }
}
