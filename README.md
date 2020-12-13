# This is an experiment to use fstar generated ocaml productively

Making an effort at 100% automatic setup and code extraction so we can use it
like a normal programming language.

- ```./ulib/generate-ulib.sh``` documents the process for getting a compilable
set of FStar dependencies (at least in a hacky way).  Some of these use F# type
conventions or slightly old ideas about the condition of dependencies on the
ocaml side.  Most of it can be patched in an easy if suboptimal way.

You shoud run the generate script first.

# Build
```
yarn install
make
```

# Run

```node ./src/demo.bs.js```
