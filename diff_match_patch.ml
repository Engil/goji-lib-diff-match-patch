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
  ~depends:[]
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
        "diff" (public (array (tuple [int;string])));
      def_type ~doc:"Type representing a patch"
        "patch" (abstract any);
    ];
    section "Constructor and helpers" [
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
        (array (tuple_cells [int; string]));
      def_method "dmp" "diff_cleanup_semantic"
        ~doc:"If a diff is to be human-readable, it should be passed to diff_cleanup_semantic."
        [ curry_arg ~doc:"Array of diffs" "diffs" (array (abbrv "diff") @@ arg 0)]
        (call_method "diff_cleanupSemantic") void;
      def_method "dmp" "diff_cleanup_efficiency"
        ~doc:"Try to compact diffs to make more efficients ones"
        [ curry_arg ~doc:"Array of diffs" "diffs" (array (abbrv "diff") @@ arg 0)]
        (call_method "diff_cleanupEfficiency") void;
      map_method "dmp" "diff_levenshtein"
        ~doc:"Given a diff, measure its Levenshtein distance in terms of the number of inserted"
        [ curry_arg ~doc:"Array of diffs" "diffs" (array (abbrv "diff") @@ arg 0)]
      int;
      def_method "dmp" "diff_pretty_html"
        ~doc:"Return a formatted HTML of the diff"
        [ curry_arg ~doc:"Array of diffs" "diffs" (array (abbrv "diff") @@ arg 0)]
        (call_method "diff_prettyHtml") string;
      ];
      section "Methods on match" [
      map_method "dmp" "match_main"
        ~doc:"Return the correct location of a given pattern within a text"
        [ curry_arg ~doc:"Text" "text" (string @@ arg 0);
          curry_arg ~doc:"Pattern" "pattern" (string @@ arg 1);
          curry_arg ~doc:"Represent the expect location for this patter"
          "location" (int @@ arg 2)
        ]
      int;
      ];
      section "Methods on patches" [
      def_method "dmp" "patch_of_texts"
        ~doc:"Compute a patch from the two texts passed as arguments"
        [ curry_arg ~doc:"text" "text1" (string @@ arg 0);
          curry_arg ~doc:"text" "text2" (string @@ arg 1)
        ]
        (call_method "patch_make") (array (abbrv "patch"));
      def_method "dmp" "patch_of_diffs"
        ~doc:"Compute a patch from the diffs array passed as arguments"
        [ curry_arg ~doc:"Array of diffs" "diffs" (array (abbrv "diff") @@ arg 0)]
        (call_method "patch_make") (array (abbrv "patch"));
      map_method "dmp" "patch_make"
        ~doc:"Compute a patch from a diff array and its associated text"
        [
          curry_arg ~doc:"Text" "text" (string @@ arg 0);
          curry_arg ~doc:"Array of diffs" "diffs" (array (abbrv "diff") @@ arg 1)
        ]
        (array (abbrv "patch"));
      def_method "dmp" "string_of_patches"
        ~doc:"Produce a string from a patch array"
        [curry_arg ~doc:"Array of patches" "patches" (array (abbrv "patch") @@ arg 0)]
        (call_method "patch_toText") string;
      def_method "dmp" "patches_of_string"
        ~doc:"Produce a patches array from a diff-match-patch formatted string"
        [curry_arg ~doc:"String representing the patches" "patch_string" (string @@ arg 0)]
        (call_method "patch_fromText") (array (abbrv "patch"));
      map_method "dmp" "patch_apply"
        ~doc:"Apply a patch on a text and return it"
        [ curry_arg ~doc:"Array of patches" "patches" (array (abbrv "patch") @@
        arg 0);
          curry_arg ~doc:"Text to patch" "text" (string @@ arg 1)
        ]
        (string @@ cell root 0);
      ]
  ]
