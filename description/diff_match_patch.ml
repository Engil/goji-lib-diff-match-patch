open Goji

let package =
  register_package
    ~doc:"Google's diff-match-patch library"
    ~version:"20121119"
    "diff_match_patch"

let _ =
  register_component
  ~version:"20121119"
  ~author:"Neil Fraser"
  ~license:License.apache_v2
  ~depends:[ "browser" ]
  ~grabber:Grab.(sequence [
    exec "cp diff_match_patch.js goji_entry.js"
  ])
  ~doc:"Google's diff-match-patch Library"
  package "DiffMatchPatch"
  [ section "Types" [
      def_type ~doc:"central object used by the library to perform actions"
      "dmp" (abstract any);
    ];
    section "Constructor" [
      def_constructor "dmp" "make"
      ~doc:"constructor for the central object"
      []
      (call_constructor (global "diff_match_patch"))
    ]
  ]

