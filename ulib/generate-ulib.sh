#!/bin/sh

GENDIR=`dirname "${0}"`
FSTAR=`which fstar.exe`
FSDIR="`dirname ${FSTAR}`/.."
ULIB="${FSDIR}/ulib"

cd "${GENDIR}"
cp "${ULIB}"/ml/*.ml .

fstar.exe --codegen OCaml "${ULIB}/FStar.UInt128.fst"
fstar.exe --codegen OCaml "${ULIB}/FStar.Int128.fst"
fstar.exe --codegen OCaml "${ULIB}/FStar.UInt32.fst"
fstar.exe --codegen OCaml "${ULIB}/FStar.Int32.fst"
fstar.exe --codegen OCaml "${ULIB}/FStar.UInt8.fst"
fstar.exe --codegen OCaml "${ULIB}/FStar.Int8.fst"
fstar.exe --codegen OCaml "${ULIB}/FStar.Error.fst"
fstar.exe --codegen OCaml "${ULIB}/FStar.Monotonic.HyperStack.fst"
fstar.exe --codegen OCaml "${ULIB}/FStar.Monotonic.HyperHeap.fst"
fstar.exe --codegen OCaml "${ULIB}/FStar.HyperStack.fst"
fstar.exe --codegen OCaml "${ULIB}/FStar.HyperStack.ST.fst"
fstar.exe --codegen OCaml "${ULIB}/FStar.Map.fst"
fstar.exe --codegen OCaml "${ULIB}/FStar.PropositionalExtensionality.fst"
fstar.exe --codegen OCaml "${ULIB}/FStar.FunctionalExtensionality.fst"
fstar.exe --codegen OCaml "${ULIB}/FStar.Monotonic.Witnessed.fst"

patch -p1 --reverse < prims.diff
patch -p1 --reverse < FStar_String.diff
patch -p1 --reverse < FStar_Bytes.diff

(echo ; echo 'type int8 = t') >> FStar_Int8.ml
(echo ; echo 'type uint8 = t') >> FStar_UInt8.ml
(echo ; echo 'type int16 = t') >> FStar_Int16.ml
(echo ; echo 'type uint16 = t') >> FStar_UInt16.ml
(echo ; echo 'type int32 = t') >> FStar_Int32.ml
(echo ; echo 'type uint32 = t') >> FStar_UInt32.ml
(echo ; echo 'type int64 = t') >> FStar_Int64.ml
(echo ; echo 'type uint64 = t') >> FStar_UInt64.ml
(echo ; echo 'type int128 = t') >> FStar_Int128.ml
