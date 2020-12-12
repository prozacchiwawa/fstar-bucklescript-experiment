all: ulib/prims.ml
	fstar.exe --codegen OCaml \
		--no_extract FStar.Pervasives.Native \
		--no_extract FStar.Pervasives \
		--no_extract FStar.Mul \
		--no_extract FStar.Preorder \
		--no_extract FStar.Calc \
	  --no_extract FStar.Heap \
	  --no_extract FStar.HyperStack \
		--no_extract FStar.StrongExcludedMiddle \
		--no_extract FStar.List.Tot.Base \
		--no_extract FStar.List.Tot.Properties \
		--no_extract FStar.List.Tot \
		--no_extract FStar.Seq.Base \
		--no_extract FStar.Seq.Properties \
		--no_extract FStar.Seq \
		--no_extract FStar.Math.Lib \
		--no_extract FStar.Math.Lemmas \
		--no_extract FStar.BitVector \
		--no_extract FStar.UInt \
		--no_extract FStar.UInt32 \
		--no_extract FStar.UInt64 \
		--no_extract FStar.UInt8 \
		--no_extract FStar.PropositionalExtensionality \
		--no_extract FStar.PredicateExtensionality \
		--no_extract FStar.TSet \
		--no_extract FStar.ST \
		--no_extract FStar.IO \
		--no_extract FStar.All \
		--no_extract FStar.Exn \
	  --no_extract FStar.Heap \
	  --no_extract FStar.HyperStack \
		--no_extract FStar.StrongExcludedMiddle \
		--no_extract FStar.List.Tot.Base \
		--no_extract FStar.List.Tot.Properties \
		--no_extract FStar.List.Tot \
		--no_extract FStar.Seq.Base \
		--no_extract FStar.Seq.Properties \
		--no_extract FStar.Seq \
		--no_extract FStar.Math.Lib \
		--no_extract FStar.Math.Lemmas \
		--no_extract FStar.BitVector \
		--no_extract FStar.UInt \
		--no_extract FStar.UInt32 \
		--no_extract FStar.UInt64 \
		--no_extract FStar.UInt8 \
		--no_extract FStar.PropositionalExtensionality \
		--no_extract FStar.PredicateExtensionality \
		--no_extract FStar.TSet \
		--no_extract FStar.ST \
		--no_extract FStar.IO \
		--no_extract FStar.All \
		--no_extract FStar.Exn \
		src/bin.fst
	mv Bin.ml src/bin.ml
	yarn run build

clean:
	rm ulib/*.ml ulib/*.bs.js src/*.bs.js z/*.bs.js

ulib/prims.ml:
	cd ulib && ./generate-ulib.sh
