open Bin
open Z

let () =
  let two_str = show_bin Bin.two in
  let z = Z.of_int 3 in
  Js.log @@ "two_str " ^ two_str
