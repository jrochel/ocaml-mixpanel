# ocaml-mixpanel

Binding to
[mixpanel](https://developer.mixpanel.com/docs/javascript-full-api-reference)

## What does ocaml-mixpanel do

This plugin provides function that give the opportunity to use
"Mixpanel" in your ocalm projects.

> Mixpanel is a product analytics tool that enables you to capture data on how users interact with your digital product. Mixpanel then lets you analyze this product data with simple, interactive reports that let you query and visualize the data with just a few clicks.

Source: [mixpanel.com](https://developer.mixpanel.com/docs/what-is-mixpanel)

## How to install and compile your project by using this plugin ?

You can use opam by pinning the repository with:
```Shell
opam pin add mixpanel https://github.com/Thibaut-Gudin/ocaml-mixpanel.git
```

to compile your project, use:
```Shell
dune build @install
```

Finally, install the cordova plugin "mixpanel" with:
```Shell
cordova plugin add mixpanel
```


## How to use?

### Mixpanel.available
You can use this function to know if the object "Mixpanel" is available
in your project, it is recommended tu use it before to call the
functions that depend on the server Mixpanel, it indicate if Mixpanel is
unavailable.

### Mixpanel.init
> This function initializes a new instance of the Mixpanel tracking
object. All new instances are added to the main mixpanel object as sub
properties (such as mixpanel.library_name) and also returned by this
function.\n
Source: [mixpanel API](https://developer.mixpanel.com/docs/javascript-full-api-reference)

The optional argument "config" in an object of type "config", all it's
optional argument represent a config name and the value of the
configuration option we want to override.
Example:
```Shell
let token = "new token" in
let config =
Mixpanel.config ~cookiesName:"Cookies"
                ~loaded:(function
                        |_ -> print_endline "Hello World")
in
let name = "library_name" in
Mixpanel.init ~token ~config ~name
```
  [See the default config options](https://github.com/mixpanel/mixpanel-js/blob/8b2e1f7b/src/mixpanel-core.js#L87-L110)

### What is the type Properties.t?
The type "Properties.t" is an associative array of properties to store about the use (for
example "{'Gender': 'Male', 'Age': 21}"), this type is used for
several function arguments.
You can create a "Properties.t" object with the function
"Properties.create" that can convert a list of (string * string) into a "Properties.t" object:
```Shell
let props = [("Gender", "Male");("Age", "21")] in
let properties = Mixpanel.create props
```

### Mixpanel.track
The main function of this plugin is "track", like its name suggest, it
track an event and send it to the "Mixpanel" server, where it could be
analyzed later.

The optional argument "properties" is an object of type "Properties.t".
The optional argument "options" in an object of type "track_opt" that
can have 2 value "Transport" or "Send_Immediately"
```Shell
Mixpanel.track ~event:"Registered" ~properties ()
Mixpanel.track ~event:"Registered" ~properties:(Mixpanel.create [("Gender", "Male");("Age", "21")]) ()
```

The optionnal argument "callback" represent a function that will be
executed at the end of the "track". The function that we gave in
argument take an argument of type "Ojs.t", it represents the value
returned by the execution of "Mixpanel.track". "Mixpanel.track" return
either a boolean "false" if the track failed of an object if it suceed,
so the function given in "callback" takes an  object "Ojs.t" to
represent that.
You can use the function "Ojs.type_of_payload" to identify the type of
the value returned:
```Shell
Mixpanel.track ~event:"Event name" ~properties
               ~callback:(function payload ->
                                   if String.equal (Ojs.type_of payload)
                                   "boolean" then print_endline "Track
                                   Failed"
                                   else print_endline "Track Succeed")
               ()
```


### Mixpanel.get_distinct_id
This function returns the current "distinct id" of the user.

> get_distinct_id() can only be called after the Mixpanel library has
  finished loading. You can handle this automatically in init() with
  the "~loaded" parametter of "config". For exemple, we can see bellow a
  case were "distinct_id" is set after the mixpanel library has finish loaded \n
  ```Shell
  Mixpanel.init ~token:"YOUR PROJECT TOKEN"
                ~config:( Mixpanel.config
                          ~loaded: (function mixpanel ->
                                   distinct_id = mixpanel.get_distinct_id()))
                ()
  ```
  \n
  Source: [mixpanel API](https://developer.mixpanel.com/docs/javascript-full-api-reference)


[TODO]
