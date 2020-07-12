/* 주제 : 응용
-
*/

const {app, BrowserWindow} = require('electron')
const path = require('path')

//
const url = require('url')

let win

app.on('ready', createWindow)

function createWindow () {
  win = new BrowserWindow({width: 700, height: 600})

  win.loadURL(url.format({
    protocol: 'file:',
    pathname: path.join(__dirname, '/index.html'),
    slashes: true
  }))
  // win.webContents.openDevTools() // 웹브라우저의 개발도구 창 띄우기
}
