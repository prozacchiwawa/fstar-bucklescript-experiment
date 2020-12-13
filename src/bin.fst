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

type blist = list bool

val are_eq : predi 'a -> prf 'a -> bool
let are_eq = function
    | Predi c -> function
        | Prf a b -> c a b

assume val check_eq_list : x:blist -> y:blist{x = y} -> unit

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

val list_bin_empty : bin -> n:int -> blist
let rec list_bin_empty b n =
    if n > 0 then
        false :: (list_bin_empty b (n - 1))
    else
      match b with
      | BNil -> [true]
      | O n1 b1 ->
          let tail = list_bin_empty b1 n1 in
          true :: tail

val list_bin : bin -> blist
let list_bin = function
    | BNil -> [false]
    | O n b -> list_bin_empty b n

val bin_idx_gt_zero : bin -> bool
let bin_idx_gt_zero = function
  | BNil -> false
  | O 0 _ -> false
  | _ -> true

val first_of_list_is_false : blist -> bool
let first_of_list_is_false = function
  | [] -> true
  | false :: _ -> true
  | _ -> false

val list_bin_with_n_eq_zero_starts_with_zero : b:bin ->
  Lemma
    (requires (bin_idx_gt_zero b))
    (ensures (first_of_list_is_false (list_bin b)))

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
let twelve = O 2 (O 0 BNil)
val thirteen : bin
let thirteen = O 0 (O 1 (O 0 BNil))
val fifteen : bin
let fifteen = O 0 (O 0 (O 0 (O 0 BNil)))

val show_bin_list : blist -> string
let rec show_bin_list = function
  | [] -> ""
  | hd :: tl -> (if hd then "1" else "0") ^ (show_bin_list tl)

val show_bin : bin -> string
let show_bin b =
  show_bin_list (list_bin b)

val checkBin : unit -> unit
let checkBin () =
    let _ = check_eq_list (list_bin zero) [false] in
    let _ = check_eq_list (list_bin one) [true] in
    let _ = check_eq_list (list_bin two) [false ; true] in
    let _ = check_eq_list (list_bin three) [true ; true] in
    (* let _ = check_eq_list (list_bin three) [true ; false] in -- failed *)
    let _ = check_eq_list (list_bin four) [false;false;true] in
    let _ = check_eq_list (list_bin ten) [false;true;false;true] in
    let _ = check_eq_list (list_bin twelve) [false;false;true;true] in
    let _ = check_eq_list (list_bin thirteen) [true;false;true;true] in
    let _ = check_eq_list (list_bin fifteen) [true;true;true;true] in
    ()

let main =
  checkBin ()
