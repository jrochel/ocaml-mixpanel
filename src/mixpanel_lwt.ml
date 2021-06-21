module type S = sig

  val x : string

end

module I : S = struct
  let x = "x"
end
