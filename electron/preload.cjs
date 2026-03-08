// Preload script runs in renderer context with Node access disabled.
// Add contextBridge.exposeInMainWorld() calls here if you need to
// expose secure APIs to the renderer.
const { contextBridge } = require("electron");

contextBridge.exposeInMainWorld("manikAI", {
  platform: process.platform,
});
