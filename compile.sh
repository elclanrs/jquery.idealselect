#!/bin/sh
stylus -c css/jquery.idealselect.styl
browserify -t liveify js/jquery.idealselect.ls > js/jquery.idealselect.js
cat js/jquery.idealselect.js | uglifyjs --comments -m -c warnings=false -o js/jquery.idealselect.min.js
