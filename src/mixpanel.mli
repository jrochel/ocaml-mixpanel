type track_opt =
  | Transport [@js "_transport"]
  | Send_Immediately [@js "_send_immediately"]
[@@js.enum]

[@@@js.stop]

module Properties : sig
  type t

  val create : (string * string) list -> t
end

[@@@js.start]

[@@@js.implem
module Properties = struct
  type t = Ojs.t

  let create ls =
    Ojs.obj
      (Array.of_list (List.map (fun (k, v) -> (k, Ojs.string_to_js v)) ls))

  let t_to_js x = Ojs.t_to_js x
end]

val track :
  event:string ->
  ?properties:Properties.t ->
  ?options:track_opt ->
  ?options_transport:string ->
  ?options_send_immediatly:bool ->
  ?callback:(Ojs.t -> unit) ->
  unit ->
  unit
  [@@js.global "mixpanel.track"]

val get_distinct_id : unit -> string [@@js.global "mixpanel.get_distinct_id"]

val register : properties:Properties.t -> ?days:int -> unit -> unit
  [@@js.global "mixpanel.register"]

val people_set :
  properties:Properties.t ->
  ?_to:string ->
  ?callback:(unit -> unit) ->
  unit ->
  unit
  [@@js.global "mixpanel.people.set"]

type config

val config :
  ?apiHost:string ->
  ?appHost:string ->
  ?autotrack:bool ->
  ?cdn:string ->
  ?crossSubdomainCookie:bool ->
  ?persistence:string ->
  ?persistenceName:string ->
  ?cookieName:string ->
  ?loaded:(Ojs.t -> unit) ->
  ?storeGoogle:bool ->
  ?saveReferrer:bool ->
  ?test:bool ->
  ?verbose:bool ->
  ?img:bool ->
  ?trackLinksTimeout:int ->
  ?cookieExpiration:int ->
  ?upgrade:bool ->
  ?disablePersistence:bool ->
  ?disableCookie:bool ->
  ?secureCookie:bool ->
  ?ip:bool ->
  (*Check if PropertyBlacklist realy is a string list...*)
  ?propertyBlacklist:string list ->
  unit ->
  config
  [@@js.builder]

val init : token:string -> ?config:config -> ?name:string -> unit -> unit
  [@@js.global "mixpanel.init"]

val identify : ?unique_id:string -> unit -> unit
  [@@js.global "mixpanel.identify"]

val alias : alias:string -> ?original:string -> unit -> unit
  [@@js.global "mixpanel.alias"]

val reset : unit -> unit [@@js.global "mixpanel.reset"]

[@@@js.stop]

val available : unit -> bool

[@@@js.start]

[@@@js.implem
let available () =
  Js_of_ocaml.Js.Optdef.test Js_of_ocaml.Js.Unsafe.global##.mixpanel]

[@@@js.stop]

module Lwt : Mixpanel_lwt.S

[@@@js.start]

[@@@js.implem
module Lwt = Mixpanel_lwt.I
]
