# Asset Pipeline

This project leverages grunt for its asset pipeline.

## Asset Types

A seperate pipeline exists for stylesheets, images, and javascripts.

### Stylesheets

Stylesheets are written in `scss` and live in `./app/styles`. The grunt
task `asssets` compiles these files and distributes them to
`./dist/css`. The backend server symlinks its `public/assets` folder to
this `./dist` folder so files can be statically served via routes like
`/assets/css/application.css`

### Images

### Javascript

## Environments

The asset pipeline behaves different in development and production.

### In development

TODO: Discuss Livereload

### In production

TODO: Discuss fingerprinting, manifest files, and sinatra helpers
