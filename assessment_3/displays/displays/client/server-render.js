import fs from 'fs';

// eslint-disable-next-line no-sync
const template = fs.readFileSync(__dirname + '/../index.html', 'utf8');

function renderApp(path, callback) {
  const page = template;
  callback(null, page);
}

module.exports = renderApp;