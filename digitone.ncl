let screenColorSchemes = {
  blackOnYellow = 17,
  whiteOnNavy = 64,
  blackOnOrange = 15,
  blackOnBrown = 16
}
in
let hapticModes = { knob = 0 } in
let Len16 = std.contract.from_predicate (fun a => std.array.length a == 16) in
let Knob = {
  controlIndex | doc "0-31" | Number,
  controlMode = 0,
  controlChannel | Number,
  controlParam | Number,
  nrprnAddress = 0,
  minValue | default = 0,
  maxValue | default = 127,
  controlName | String,
  colorScheme | Number,
  hapticMode | Number,
  hapticIndent1 | default = 255,
  hapticIndent2 | default = 255,
  hapticSteps | default = 0,
  stepNames | Len16 | default = std.array.generate (fun _ => "") 16
}
in
let Button = {
  controlIndex | doc "0-31" | Number,
  controlMode = 0,
  controlChannel | Number,
  controlParam | Number,
  nrprnAddress = 0,
  minValue | default = 0,
  maxValue | default = 127,
  controlName | String,
  colorScheme | Number,
  ledOnColor | Number,
  ledOffColor | Number,
  hapticMode | Number = 1, # toggle
  hapticSteps = 2,
  stepNameOff | String | not_exported,
  stepNameOn | String | not_exported,
  stepNames = std.array.concat [stepNameOff, stepNameOn] (std.array.generate (fun _ => "") 14)
}
in
let template = {
  version = 1,
  type = 'MIDI,
  name | String,
  index | Number = 0,
  knobs | Array Knob,
  buttons | Array Button
}
in
let kick_knob | Knob = {
  controlIndex = controlChannel - 1,
  controlChannel | Number,
  controlParam = 81,
  controlName = "TK%{std.string.from_number controlChannel} OD",
  colorScheme = screenColorSchemes.blackOnYellow,
  hapticMode = hapticModes.knob
}
in
let filter_knob | Knob = {
  controlIndex = controlChannel - 1,
  controlChannel | Number,
  controlParam = 16,
  controlName = "TK%{std.string.from_number controlChannel} FILTFRQ",
  colorScheme = screenColorSchemes.whiteOnNavy,
  hapticMode = hapticModes.knob,
  minValue = 93
}
in
let bitcrush_knob | Knob = {
  controlIndex = controlChannel - 1,
  controlChannel | Number,
  controlParam = 78,
  controlName = "TK%{std.string.from_number controlChannel} BITCRUSH",
  colorScheme = screenColorSchemes.blackOnOrange,
  hapticMode = hapticModes.knob,
}
in
let delay_knob | Knob = {
  controlIndex = controlChannel - 1,
  controlChannel | Number,
  controlParam = 30,
  controlName = "TK%{std.string.from_number controlChannel} DELAY",
  colorScheme = screenColorSchemes.blackOnBrown,
  hapticMode = hapticModes.knob,
}
in
template
& {
  name = "DIGITONE",
  knobs = [
    kick_knob & { controlChannel = 1 },
    kick_knob & { controlChannel = 2 },
    kick_knob & { controlChannel = 3 },
    kick_knob & { controlChannel = 4 },
    filter_knob & {controlChannel = 5},
    filter_knob & {controlChannel = 6},
    filter_knob & {controlChannel = 7},
    filter_knob & {controlChannel = 8},
    bitcrush_knob & {controlChannel = 9},
    bitcrush_knob & {controlChannel = 10},
    bitcrush_knob & {controlChannel = 11},
    bitcrush_knob & {controlChannel = 12},
    delay_knob & {controlChannel = 13},
    delay_knob & {controlChannel = 14},
    delay_knob & {controlChannel = 15},
    delay_knob & {controlChannel = 16},
  ],
  buttons = [
  ]
}
