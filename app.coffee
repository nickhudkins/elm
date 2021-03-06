css_pipeline = require 'css-pipeline'
js_pipeline  = require 'js-pipeline'
contentful   = require 'roots-contentful'
config       = require './contentful'
marked       = require 'marked'
moment       = require 'moment'
roots_yaml   = require 'roots-yaml'

module.exports =
  ignores: [
    'contentful.coffee'
    'readme.md'
    '**/layout.*'
    '**/_*'
    '.gitignore'
    '.nvmrc'
    '.netlify'
    'ship.*conf'
    'helpers/**'
  ]

  locals:
    marked: marked
    moment: moment
    helpers:
      getPageName: require './helpers/get-page-name.js'
      buildEmbed:  require './helpers/build-embed.js'

  extensions: [
    js_pipeline(files: 'assets/js/*.coffee'),
    css_pipeline(files: 'assets/css/*.scss')
    contentful(config)
    roots_yaml()
  ]

  scss:
    includePaths: [
      './assets/css/vendor'
      './node_modules/'
    ]
    # outFile: './public/css/app.css'
    outputStyle: 'nested' # nested (default), expanded, compact, compressed
    sourceMap: true
    sourceMapEmbed: true
    # indentedSyntax: true

  'coffee-script':
    sourcemap: true

  jade:
    pretty: true

  server:
    clean_urls: true

  open_browser: false
