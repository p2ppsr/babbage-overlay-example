const ejs = require('ejs')
const fs = require('fs')
require('dotenv').config()

// debug env vars
// console.log(process.env)
const env = process.env
Object.keys(env).forEach(function (key) {
  console.log('export ' + key + '="' + env[key] + '"')
})

ejs.renderFile(
  'src/templates/documentation.ejs',
  {
    ...process.env,
    routes: []
  },
  {},
  (err, res) => {
    if (err) {
      throw err
    }
    console.log('Generating API documentation...')
    fs.writeFileSync('public/index.html', res)
  }
)
