rule = {
    matches = {
      {
        { "node.name", "equals", "alsa_output.pci-0000_00_1f.3.hdmi-stereo" },
      },
    },
    apply_properties = {
      ["node.disabled"] = true,
    },
  }
  
  table.insert(alsa_monitor.rules,rule)