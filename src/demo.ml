open Bin
open Z

let () =
  let two_str = show_bin Bin.two in
  let twelve_str = show_bin Bin.twelve in
  let thirteen_str = show_bin Bin.thirteen in
  let z = Z.of_int 3 in
  Js.log @@ "two_str " ^ two_str ;
  Js.log @@ "twelve_str " ^ twelve_str ;
  Js.log @@ "thirteen_str " ^ thirteen_str
