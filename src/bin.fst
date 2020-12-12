(*
   Copyright 2008-2018 Microsoft Research

   Licensed under the Apache License, Version 2.0 (the "License");
   you may not use this file except in compliance with the License.
   You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

   Unless required by applicable law or agreed to in writing, software
   distributed under the License is distributed on an "AS IS" BASIS,
   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
   See the License for the specific language governing permissions and
   limitations under the License.
*)
module Bin

open FStar.Exn
open FStar.All
open FStar.HyperStack
open FStar.Monotonic.HyperHeap

type prf 'a =
    | Prf : 'a -> 'a -> prf 'a

noeq type predi 'a =
    | Predi : ('a -> 'a -> bool) -> predi 'a

val are_eq : predi 'a -> prf 'a -> bool
let are_eq = function
    | Predi c -> function
        | Prf a b -> c a b

assume val check_eq_str : x:string -> y:string{x = y} -> unit

type bin =
    | BNil : bin
    | O : int -> bin -> bin

val oneMore : bin -> bin
let oneMore = function
    | BNil -> BNil
    | (O a x) -> O (a + 1) x

val flipFromLeft : bin -> bin
let rec flipFromLeft = function
    | BNil -> O 0 BNil
    | (O a x) ->
      if a <= 0 then
        oneMore (flipFromLeft x)
      else
        O 0 (O (a - 1) x)

val binInc : bin -> bin
let binInc = function
    | BNil -> O 0 BNil
    | (O 0 BNil) -> O 1 BNil
    | (O a v) -> flipFromLeft (O a v)

val show_bin_empty : bin -> n:int -> string
let rec show_bin_empty b n =
    if n > 0 then
        "0" ^ (show_bin_empty b (n - 1))
    else
      match b with
      | BNil -> "1"
      | O n1 b1 ->
          let tail = show_bin_empty b1 n1 in
          "1" ^ tail

val show_bin : bin -> string
let show_bin = function
    | BNil -> "0"
    | O n b -> show_bin_empty b n

val zero : bin
let zero = BNil
val one : bin
let one = O 0 BNil
val two : bin
let two = O 1 BNil
val three : bin
let three = O 0 (O 0 BNil)
val four : bin
let four = O 2 BNil
val ten : bin
let ten = O 1 (O 1 BNil)
val twelve : bin
let twelve = O 2 (O 1 (O 1 BNil))
val thirteen : bin
let thirteen = O 0 (O 1 (O 0 BNil))
val fifteen : bin
let fifteen = O 0 (O 0 (O 0 (O 0 BNil)))

val checkBin : unit -> unit
let checkBin () =
    let _ = check_eq_str "a" "a" in
    (* let _ = check_eq_str "a" "b" in -- breaks *)
    let _ = check_eq_str (show_bin zero) "0" in
    let _ = check_eq_str (show_bin one) "1" in
    (*
    let _ = check_eq_str (show_bin two) "01" in
    let _ = check_eq_str (show_bin three) "11" in
    let _ = check_eq_str (show_bin four) "001" in
    let _ = check_eq_str (show_bin ten) "0101" in
    let _ = check_eq_str (show_bin twelve) "0011" in
    let _ = check_eq_str (show_bin thirteen) "1011" in
    let _ = check_eq_str (show_bin fifteen) "1111" in
    *)
    ()

let main =
  checkBin ()
