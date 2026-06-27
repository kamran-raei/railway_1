const http = require("http");
const httpProxy = require("http-proxy");

const TARGET = "https://ray.darkns.ir";

const proxy = httpProxy.createProxyServer({
  target: TARGET,
  changeOrigin: true,
  ws: true,
  secure: false, // accept self-signed cert
  xfwd: true,
});

const server = http.createServer((req, res) => {
  proxy.web(req, res, {
    target: TARGET,
  });
});

// WebSocket support
server.on("upgrade", (req, socket, head) => {
  proxy.ws(req, socket, head, {
    target: TARGET,
  });
});

// error handling
proxy.on("error", (err, req, res) => {
  if (res && !res.headersSent) {
    res.writeHead(502);
  }
  res.end("Proxy error");
});

server.listen(80, "0.0.0.0", () => {
  console.log("Proxy running on port 80 ->", TARGET);
});