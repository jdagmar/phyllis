import * as http from 'http';
import * as fs from 'fs';

const html = fs.readFileSync('App/index.html', 'UTF-8');
const app = fs.readFileSync('App/app.js', 'UTF-8');
const css = fs.readFileSync('App/main.css', 'UTF-8');

type Actions = 'WatchTV' | 'Source' | 'CursorRight' | 'CursorLeft' | 'Confirm';

const postInput = (action: Actions) => () => {
  const data = JSON.stringify({ key: action });

  return new Promise((resolve, reject) => {
    const req = http.request(
      {
        hostname: '192.168.1.119',
        port: 1925,
        path: '/1/input/key',
        method: 'POST',
        headers: {
          'content-type': 'application/json',
          'content-lenght': data.length,
        },
        timeout: 3000,
      },
      res => {
        if (res.statusCode === 200) {
          resolve();
        } else {
          reject('bad statuscode ' + res.statusCode);
        }
        console.log(res.statusCode);
      }
    );

    req.on('timeout', () => {
      req.abort();
      reject('connection timed out');
    });
    req.on('error', () => {
      reject('something went bad');
    });
    req.end(data);
  });
};

const delay = (ms: number) => () => {
  return new Promise((resolve, reject) => {
    setTimeout(() => {
      resolve();
    }, ms);
  });
};

const postInputs = (actions: Actions[]) => {
  return actions.reduce(
    (promise: Promise<unknown>, action) =>
      promise.then(postInput(action)).then(delay(500)),
    Promise.resolve()
  );
};

const switchSourceToBoxer = () =>
  postInputs([
    'WatchTV',
    'Source',
    'CursorRight',
    'CursorRight',
    'CursorRight',
    'Confirm',
  ]);

const switchSourceToComputer = () =>
  postInputs([
    'WatchTV',
    'Source',
    'CursorRight',
    'CursorRight',
    'CursorRight',
    'CursorRight',
    'CursorRight',
    'Confirm',
    'Confirm',
  ]);

const server = http.createServer((req, res) => {
  if (req.url === '/boxer') {
    switchSourceToBoxer()
      .then(() => {
        res.statusCode = 200;
        res.end();
      })
      .catch(err => {
        res.statusCode = 500;
        res.end(err);
      });
  } else if (req.url === '/computer') {
    switchSourceToComputer()
      .then(() => {
        res.statusCode = 200;
        res.end();
      })
      .catch(err => {
        res.statusCode = 500;
        res.end(err);
      });
  } else if (req.url === '/') {
    res.statusCode = 200;
    res.end(html);
  } else if (req.url === '/app.js') {
    res.statusCode = 200;
    res.end(app);
  } else if (req.url === '/main.css') {
    res.statusCode = 200;
    res.end(css);
  } else {
    res.statusCode = 404;
    res.end();
    console.log('bad stuff');
  }
});

server.listen(3000, () => {
  console.log('server is listening on port 3000');
});
