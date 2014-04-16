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
    http_get
    "https://neil.fraser.name/software/diff_match_patch/svn/trunk/javascript/diff_match_patch.js"
    "goji_entry.js"
  ])
  ~doc:"Google's diff-match-patch Library"
  package "DiffMatchPatch"
  [ section "Types" [
      def_type ~doc:"Central object used by the library to perform actions"
        "dmp" (abstract any);
      def_type ~doc:"Diff type"
        "diff" (abstract string);
      def_type ~doc:"Type representing a patch"
        "patch" (abstract any);
    ];
    section "Constructor" [
      def_constructor "dmp" "make"
      ~doc:"constructor for the central object"
      []
      (call_constructor (global "diff_match_patch"))
    ];
    section "Methods on diffs" [
      map_method "dmp" "diff_main"
        ~doc:"An array of differences is computed which describe the transformation of text1 into text2"
        [ curry_arg ~doc:"text" "text1" (string @@ arg 0);
          curry_arg ~doc:"text" "text2" (string @@ arg 1)
        ]
        (array string);
      def_method "dmp" "diff_cleanup_semantic"
        ~doc:"If a diff is to be human-readable, it should be passed to diff_cleanup_semantic."
        [ curry_arg ~doc:"Array of diffs" "diffs" (array (abbrv "diff") @@ arg 0)]
        (call_method "diff_cleanupSemantic") void;
      def_method "dmp" "diff_cleanup_efficiency"
        ~doc:"Try to compact diffs to make more efficients ones"
        [ curry_arg ~doc:"Array of diffs" "diffs" (array (abbrv "diff") @@ arg 0)]
        (call_method "diff_cleanupEfficiency") void;
      def_method "dmp" "diff_levenshtein"
        ~doc:"Given a diff, measure its Levenshtein distance in terms of the number of inserted"
        [ curry_arg ~doc:"Array of diffs" "diffs" (array (abbrv "diff") @@ arg 0)]
        (call_method "diff_levenshtein") int;
      def_method "dmp" "diff_pretty_html"
        ~doc:"Return a formatted HTML of the diff"
        [ curry_arg ~doc:"Array of diffs" "diffs" (array (abbrv "diff") @@ arg 0)]
        (call_method "diff_prettyHtml") string;
      def_method "dmp" "match_main"
        ~doc:"Return the correct location of a given pattern within a text"
        [ curry_arg ~doc:"Text" "text" (string @@ arg 0);
          curry_arg ~doc:"Pattern" "pattern" (string @@ arg 1);
          curry_arg ~doc:"Represent the expect location for this patter"
          "location" (int @@ arg 2)
        ]
        (call_method "match_main") int;
    ]
  ]

