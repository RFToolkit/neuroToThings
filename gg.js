const Ganglion = require("openbci-ganglion");
const ganglion = new Ganglion();
ganglion.once("ganglionFound", peripheral => {
  // Stop searching for BLE devices once a ganglion is found.
  ganglion.searchStop();
  ganglion.on("sample", sample => {
    /** Work with sample */
    console.log(sample.sampleNumber);
    for (let i = 0; i < ganglion.numberOfChannels(); i++) {
      console.log(
        "Channel " +
          (i + 1) +
          ": " +
          sample.channelData[i].toFixed(8) +
          " Volts."
      );
    }
  });
  ganglion.once("ready", () => {
    ganglion.streamStart();
  });
  ganglion.connect(peripheral);
});
// Start scanning for BLE devices
ganglion.searchStart();