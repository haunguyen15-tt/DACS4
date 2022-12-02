const express = require('express');
const { RtcRole, RtcTokenBuilder } = require('agora-access-token');
const e = require('express');

const port = 8000;
const APP_ID = 'e8dc0d7831d74e3bb50c82cfb1af9301';
const APP_CERTIFICATE = 'f5e6ba1ab94c430d8874f7886f204376';

const app = express();

const nocache = (req, resp, next) => {
  resp.header('Cache-Control', 'private, no-cache, no-store, must-revalidate');
  resp.header('Expires', '-1');
  resp.header('Pragma', 'no-cache');
  next();
};

const generateToken = (req, resp) => {
  resp.header('Access-Control-Allow-Origin', '*');

  const channelName = req.query.channelName;

  if (!channelName) {
    return resp.status(500).json({ error: 'channel is required' });
  }

  let uid = req.query.uid;
  if (!uid || uid == '') {
    uid = 0;
  }

  let role = RtcRole.SUBSCRIBER;

  if (req.query.role == 'publisher') {
    role = RtcRole.PUBLISHER;
  }

  let expireTime = req.query.expireTime;
  if (!expireTime || expireTime == '') {
    expireTime = 3600;
  } else {
    expireTime = parseInt(expireTime, 10);
  }

  const currentTime = Math.floor(Date.now() / 1000);
  const privilegeExpireTime = currentTime + expireTime;

  const token = RtcTokenBuilder.buildTokenWithUid(
    APP_ID,
    APP_CERTIFICATE,
    channelName,
    uid,
    privilegeExpireTime
  );

  console.log('WORKING');

  return resp.json({ token: token });
};

app.get('/access-token', nocache, generateToken);

app.listen(port, () => {
  console.log('Agora access token server start on port' + port);
});
