snsData = {
  cubeToggle = {
    ID = 'cubeToggle',
    visible = true
    },
  cubeColor = {
    ID = 'cubeColor',
    color = vec(1,0,0)
  },
  cubeTexture = {
    ID = 'cubeTexture',
    primaryTexture = 'model.smile'
  },
  cubeAnim = {
    ID = 'cubeAnim',
    spin = false,
    roll = false
  }
}

snsMetadata = {
  cubeToggle = {
    ID = 'cubeToggle',
    paths = {'models.model.cube'},
    snsFunctions = {
      visible = 'updatePart'
    }
  },
  cubeColor = {
    ID = 'cubeColor',
    paths = {'models.model.cube'},
    snsFunctions = {
      color = 'updatePart'
    }
  },
  cubeTexture = {
    ID = 'cubeTexture',
    paths = {'models.model.cube'},
    snsFunctions = {
      primaryTexture = 'updatePart'
    }
  },
  cubeAnim = {
    ID = 'cubeAnim',
    snsFunctions = {
      spin = 'playAnimation',
      roll = 'playAnimation'
    }
  }
}