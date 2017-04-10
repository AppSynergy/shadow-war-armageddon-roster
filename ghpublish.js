const ghpages = require('gh-pages');
const path = require('path');

ghpages.publish(path.join(__dirname, 'build'), function() {
  console.log("Published to github.");
});
